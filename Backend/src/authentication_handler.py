from flask import jsonify, request
from . import validation
from .db import User, Restaurant
import datetime
from flask_jwt_extended import create_access_token, get_jwt_identity
import bcrypt


class AuthenticationHandler:
    def __init__(self, app, db):
        self.app = app
        self.db = db

    def register(self):
        data = request.get_json()
        v1 = validation.Validator(validation.register_customer_schema)
        v2 = validation.Validator(validation.register_restaurant_schema)
        if v1.validate(data) or v2.validate(data):
            pass
        else:
            print(v1.errors)
            print(v2.errors)
            return (
                jsonify(
                    {
                        "message": "Invalid request data",
                        "errors": f"{v1.errors} or {v2.errors}",
                    }
                ),
                400,
            )
        user1, user2 = (
            self.db.session.query(User).filter_by(username=data["username"]).first(),
            self.db.session.query(User).filter_by(email=data["email"]).first(),
        )
        if user1 or user2:
            return (
                jsonify({"message": "This email/username is already registered"}),
                409,
            )

        # Hash the password
        hashed_password = bcrypt.hashpw(data["password"].encode(), bcrypt.gensalt())
        new_user = User(
            username=data["username"],
            password=hashed_password,
            email=data["email"],
            role=data["role"],
        )
        self.db.session.add(new_user)
        self.db.session.flush()
        if data["role"] == "restaurant":
            restaurant = (
                self.db.session.query(Restaurant)
                .filter_by(name=data["restaurant_name"])
                .first()
            )
            if restaurant:
                return (
                    jsonify({"message": "This restaurant name is already registered"}),
                    409,
                )
            new_restaurant = Restaurant(
                user_id=new_user.id,
                name=data["restaurant_name"],
                location=data["restaurant_location"],
                contact=data["restaurant_contact"],
            )
            self.db.session.add(new_restaurant)
        self.db.session.commit()
        return jsonify({"message": "User created successfully"})

    def login(self):
        data = request.get_json()
        v = validation.Validator(validation.login_schema)
        if not v.validate(data):
            return jsonify({"message": "Invalid request data", "errors": v.errors}), 400
        user = None
        if "username" in data:
            user = (
                self.db.session.query(User).filter_by(username=data["username"]).first()
            )
        elif "email":
            user = self.db.session.query(User).filter_by(email=data["email"]).first()
        if user and bcrypt.checkpw(data["password"].encode(), user.password):
            access_token = create_access_token(
                identity=user.username, expires_delta=datetime.timedelta(minutes=30)
            )
            return jsonify({"access_token": access_token})
        else:
            return jsonify({"message": "Invalid username or password"}), 401

    def get_profile(self):
        username = get_jwt_identity()
        user = self.db.session.query(User).filter_by(username=username).first()
        if user:
            return jsonify(user.to_dict()), 200
        else:
            return jsonify({"message": "User not found"}), 404

    def update_profile(self):
        username = get_jwt_identity()
        user = self.db.session.query(User).filter_by(username=username).first()
        if user:
            data = request.get_json()
            v = validation.Validator(validation.update_profile_schema)
            if not v.validate(data):
                return (
                    jsonify({"message": "Invalid request data", "errors": v.errors}),
                    400,
                )

            if "new_password" in data:
                if not bcrypt.checkpw(data["password"].encode(), user.password):
                    return jsonify({"message": "Invalid password"}), 400
                if data["new_password"] != data["confirm_new_password"]:
                    return (
                        jsonify(
                            {"message": "New password and confirmation don't match"}
                        ),
                        400,
                    )
                # Hash the new password
                hashed_password = bcrypt.hashpw(
                    data["new_password"].encode(), bcrypt.gensalt()
                )
                user.password = hashed_password

            if "username" in data:
                existing_user = (
                    self.db.session.query(User)
                    .filter_by(username=data["username"])
                    .first()
                )
                if existing_user and existing_user.username != user.username:
                    return jsonify({"message": "Username already in use"}), 400
                user.username = data["username"]
            if "email" in data:
                existing_user = (
                    self.db.session.query(User).filter_by(email=data["email"]).first()
                )
                if existing_user and existing_user.email != user.email:
                    return jsonify({"message": "Email already in use"}), 400
                user.email = data["email"]

            self.db.session.commit()
            return jsonify({"message": "Profile updated successfully"}), 200
        else:
            return jsonify({"message": "User not found"}), 404

    def delete_profile(self):
        username = get_jwt_identity()
        user = self.db.session.query(User).filter_by(username=username).first()
        if user:
            if user.role == "restaurant":
                restaurant = (
                    self.db.session.query(Restaurant).filter_by(user_id=user.id).first()
                )
                if restaurant:
                    self.db.session.delete(restaurant)
            self.db.session.delete(user)
            self.db.session.commit()
            return jsonify({"message": "Profile deleted successfully"}), 200
        else:
            return jsonify({"message": "User not found"}), 404
