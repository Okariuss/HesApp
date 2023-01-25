from flask import jsonify, request
from . import validation
from .db import Base, User, Restaurant, get_db, Item, ItemOrder, Menu, MenuOrder, Order
import datetime
from flask_jwt_extended import create_access_token, get_jwt_identity
import bcrypt


class OrderHandler:
    def __init__(self, app, db):
        self.app = app
        self.db = db

    def get_orders(self):
        page = request.args.get("page", default=1, type=int)
        size = request.args.get("size", default=10, type=int)
        user_id = request.args.get("user_id", type=int)
        restaurant_id = request.args.get("restaurant_id", type=int)
        query = self.db.session.query(Order)

        username = get_jwt_identity()
        user = self.db.session.query(User).filter_by(username=username).first()
        if user:
            if user.role == "restaurant":
                query = query.filter(Order.restaurant_id == user.restaurant.id)
                if user_id:
                    query = query.filter_by(user_id=user_id)
            else:
                query = query.filter(Order.user_id == user.id)
                if restaurant_id:
                    query = query.filter_by(restaurant_id=restaurant_id)
            orders = query.offset((page - 1) * size).limit(size).all()
            return jsonify({"orders": [i.to_dict() for i in orders]})
        else:
            return jsonify({"message": "User not found"}), 404

    def get_order(self):
        order_id = request.args.get("order_id", type=int)
        if not order_id:
            return jsonify({"message": "Missing order_id parameter"}), 400

        order = self.db.session.query(Order).get(order_id)
        if not order:
            return jsonify({"message": "Order not found"}), 404

        # Check if the order belongs to the current user
        username = get_jwt_identity()
        user = self.db.session.query(User).filter_by(username=username).first()
        if not user:
            return jsonify({"message": "User not found"}), 404

        if (
            user.role == "customer"
            and user.id != order.user_id
            or (user.role == "restaurant" and user.restaurant.id != order.restaurant_id)
        ):
            return jsonify({"message": "Unauthorized"}), 403

        items = (
            self.db.session.query(ItemOrder, Item)
            .filter(ItemOrder.item_id == Item.id)
            .filter(ItemOrder.order_id == order_id)
            .all()
        )
        menus = (
            self.db.session.query(MenuOrder, Menu)
            .filter(MenuOrder.menu_id == Menu.id)
            .filter(MenuOrder.order_id == order_id)
            .all()
        )
        item_list = []
        for item in items:
            item_list.append(
                {
                    "name": item[1].name,
                    "quantity": item[0].quantity,
                    "price": item[1].price,
                }
            )
        menu_list = []
        for menu in menus:
            menu_list.append(
                {
                    "name": menu[1].name,
                    "quantity": menu[0].quantity,
                    "price": menu[1].price,
                }
            )

        return jsonify(
            {
                "order": {
                    "id": order.id,
                    "user_id": order.user.username,
                    "date": order.date,
                    "total": order.total,
                    "items": item_list,
                    "menus": menu_list,
                }
            }
        )

    def create_order(self):
        username = get_jwt_identity()
        user = self.db.session.query(User).filter_by(username=username).first()
        if not user:
            return jsonify({"message": "User not found"}), 404

        data = request.get_json()
        v = validation.Validator(validation.create_order_schema)
        if not v.validate(data):
            return jsonify({"message": "Invalid request data", "errors": v.errors}), 400

        items = data.get("items", [])
        menus = data.get("menus", [])
        if not items and not menus:
            return (
                jsonify({"message": "No items or menus provided in the request"}),
                400,
            )
        restaurant_id = data.get("restaurant_id")

        order = Order(
            user_id=user.id,
            date=datetime.datetime.now(),
            total=0,
            restaurant_id=restaurant_id,
        )
        self.db.session.add(order)
        self.db.session.flush()

        for item in items:
            db_item = self.db.session.query(Item).get(item["id"])
            if not db_item:
                return jsonify({"message": f"Item with id {item['id']} not found"}), 404
            if db_item.restaurant.id != restaurant_id:
                return (
                    jsonify(
                        {
                            "message": f"Item with id {item['id']} is not belong to the same restaurant"
                        }
                    ),
                    400,
                )
            if item["quantity"] > db_item.quantity:
                return (
                    jsonify(
                        {
                            "message": f"Item with id {item['id']} has insufficient quantity"
                        }
                    ),
                    400,
                )
            order.total += db_item.price * item["quantity"]
            db_item.quantity -= item["quantity"]
            item_order = ItemOrder(
                order_id=order.id, item_id=db_item.id, quantity=item["quantity"]
            )
            self.db.session.add(item_order)

        for menu in menus:
            db_menu = self.db.session.query(Menu).get(menu["id"])
            if not db_menu:
                return jsonify({"message": f"Menu with id {menu['id']} not found"}), 404
            if db_menu.restaurant.id != restaurant_id:
                return (
                    jsonify(
                        {
                            "message": f"Menu with id {menu['id']} is not belong to the same restaurant"
                        }
                    ),
                    400,
                )
            if menu["quantity"] > db_menu.quantity:
                return (
                    jsonify(
                        {
                            "message": f"Menu with id {menu['id']} has insufficient quantity"
                        }
                    ),
                    400,
                )
            order.total += db_menu.price * menu["quantity"]
            db_menu.quantity -= menu["quantity"]
            menu_order = MenuOrder(
                order_id=order.id, menu_id=db_menu.id, quantity=menu["quantity"]
            )
            self.db.session.add(menu_order)

        self.db.session.commit()
        return (
            jsonify({"message": "Order placed successfully", "order_id": order.id}),
            201,
        )
