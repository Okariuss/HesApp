from flask import jsonify, request
from . import validation
from .db import User, Menu
from flask_jwt_extended import get_jwt_identity


class MenuHandler:
    def __init__(self, app, db):
        self.app = app
        self.db = db

    def get_menus(self):
        page = request.args.get("page", default=1, type=int)
        size = request.args.get("size", default=10, type=int)
        restaurant_id = request.args.get("restaurant_id", type=int)
        query = self.db.session.query(Menu)
        if restaurant_id:
            query = query.filter_by(restaurant_id=restaurant_id)
        menus = query.offset((page - 1) * size).limit(size).all()
        return jsonify({"menus": [i.to_dict() for i in menus]})

    def create_menu(self):
        username = get_jwt_identity()
        user = self.db.session.query(User).filter_by(username=username).first()
        if not user:
            return jsonify({"message": "User not found"}), 404
        if user.role != "restaurant":
            return jsonify({"message": "Unauthorized"}), 403

        data = request.get_json()
        v = validation.Validator(validation.create_menu_schema)
        if not v.validate(data):
            return jsonify({"message": "Invalid request data", "errors": v.errors}), 400

        # check if menu with same name already exists in restaurant
        existing_menu = (
            self.db.session.query(Menu)
            .filter_by(name=data["name"], restaurant=user.restaurant)
            .first()
        )
        if existing_menu:
            return (
                jsonify(
                    {"message": "Menu with that name already exists in the restaurant"}
                ),
                409,
            )

        new_menu = Menu(
            name=data["name"],
            description=data["description"],
            price=data["price"],
            quantity=data["quantity"],
            restaurant=user.restaurant,
        )
        self.db.session.add(new_menu)
        self.db.session.commit()
        return jsonify({"message": "Menu created successfully"})

    def update_menu(self):
        username = get_jwt_identity()
        user = self.db.session.query(User).filter_by(username=username).first()
        if not user:
            return jsonify({"message": "User not found"}), 404
        if user.role != "restaurant":
            return jsonify({"message": "Unauthorized"}), 403

        data = request.get_json()
        v = validation.Validator(validation.update_menu_schema)
        if not v.validate(data):
            return jsonify({"message": "Invalid request data", "errors": v.errors}), 400

        menu = self.db.session.query(Menu).get(data["id"])
        if not menu:
            return jsonify({"message": "Menu not found"}), 404

        if menu.restaurant.user_id != user.id:
            return jsonify({"message": "Unauthorized"}), 403

        new_name = data.get("name", menu.name)
        existing_menu = (
            self.db.session.query(Menu)
            .filter_by(name=new_name, restaurant=user.restaurant)
            .first()
        )

        if existing_menu and existing_menu.id != menu.id:
            return jsonify({"message": "Menu with this name already exists"}), 409

        menu.name = new_name
        menu.description = data.get("description", menu.description)
        menu.price = data.get("price", menu.price)
        menu.quantity = data.get("quantity", menu.quantity)

        self.db.session.commit()
        return jsonify({"message": "Menu updated successfully"})

    def delete_menu(self, id: int):
        username = get_jwt_identity()
        user = self.db.session.query(User).filter_by(username=username).first()
        if not user:
            return jsonify({"message": "User not found"}), 404
        if user.role != "restaurant":
            return jsonify({"message": "Unauthorized"}), 403

        menu = self.db.session.query(Menu).get(id)
        if not menu:
            return jsonify({"message": "Menu not found"}), 404
        if menu.restaurant.user_id != user.id:
            return jsonify({"message": "Unauthorized"}), 403
        self.db.session.delete(menu)
        self.db.session.commit()
        return jsonify({"message": "Menu deleted successfully"})
