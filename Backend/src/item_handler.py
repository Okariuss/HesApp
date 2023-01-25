from flask import jsonify, request
from . import validation
from .db import Base, User, Restaurant, get_db, Item
import datetime
from flask_jwt_extended import create_access_token, get_jwt_identity
import bcrypt


class ItemHandler:
    def __init__(self, app, db):
        self.app = app
        self.db = db

    def get_items(self):
        page = request.args.get("page", default=1, type=int)
        size = request.args.get("size", default=10, type=int)
        restaurant_id = request.args.get("restaurant_id", type=int)
        query = self.db.session.query(Item)
        if restaurant_id:
            query = query.filter_by(restaurant_id=restaurant_id)
        items = query.offset((page - 1) * size).limit(size).all()
        return jsonify({"items": [i.to_dict() for i in items]})

    def create_item(self):
        username = get_jwt_identity()
        user = self.db.session.query(User).filter_by(username=username).first()
        if not user:
            return jsonify({"message": "User not found"}), 404
        if user.role != "restaurant":
            return jsonify({"message": "Unauthorized"}), 403

        data = request.get_json()
        v = validation.Validator(validation.create_item_schema)
        if not v.validate(data):
            return jsonify({"message": "Invalid request data", "errors": v.errors}), 400

        # check if item with same name already exists in restaurant
        existing_item = (
            self.db.session.query(Item)
            .filter_by(name=data["name"], restaurant=user.restaurant)
            .first()
        )
        if existing_item:
            return (
                jsonify(
                    {"message": "Item with that name already exists in the restaurant"}
                ),
                409,
            )

        new_item = Item(
            name=data["name"],
            description=data["description"],
            price=data["price"],
            quantity=data["quantity"],
            restaurant=user.restaurant,
        )
        self.db.session.add(new_item)
        self.db.session.commit()
        return jsonify({"message": "Item created successfully"})

    def update_item(self):
        username = get_jwt_identity()
        user = self.db.session.query(User).filter_by(username=username).first()
        if not user:
            return jsonify({"message": "User not found"}), 404
        if user.role != "restaurant":
            return jsonify({"message": "Unauthorized"}), 403

        data = request.get_json()
        v = validation.Validator(validation.update_item_schema)
        if not v.validate(data):
            return jsonify({"message": "Invalid request data", "errors": v.errors}), 400

        item = self.db.session.query(Item).get(data["id"])
        if not item:
            return jsonify({"message": "Item not found"}), 404

        if item.restaurant.user_id != user.id:
            return jsonify({"message": "Unauthorized"}), 403

        new_name = data.get("name", item.name)
        existing_item = (
            self.db.session.query(Item)
            .filter_by(name=new_name, restaurant=user.restaurant)
            .first()
        )

        if existing_item and existing_item.id != item.id:
            return jsonify({"message": "Item with this name already exists"}), 409

        item.name = new_name
        item.description = data.get("description", item.description)
        item.price = data.get("price", item.price)
        item.quantity = data.get("quantity", item.quantity)

        self.db.session.commit()
        return jsonify({"message": "Item updated successfully"})

    def delete_item(self):
        username = get_jwt_identity()
        user = self.db.session.query(User).filter_by(username=username).first()
        if not user:
            return jsonify({"message": "User not found"}), 404
        if user.role != "restaurant":
            return jsonify({"message": "Unauthorized"}), 403
        data = request.get_json()
        v = validation.Validator(validation.delete_item_schema)
        if not v.validate(data):
            return jsonify({"message": "Invalid request data", "errors": v.errors}), 400
        item = self.db.session.query(Item).get(data["id"])
        if not item:
            return jsonify({"message": "Item not found"}), 404
        if item.restaurant.user_id != user.id:
            return jsonify({"message": "Unauthorized"}), 403
        self.db.session.delete(item)
        self.db.session.commit()
        return jsonify({"message": "Item deleted successfully"})
