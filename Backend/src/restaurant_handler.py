from flask import jsonify, request, render_template
from . import validation
from .db import User, Restaurant, Item, Menu
from flask_jwt_extended import get_jwt_identity
import qrcode


class RestaurantHandler:
    def __init__(self, app, db):
        self.app = app
        self.db = db

    def get_restaurants(self):
        page = request.args.get("page", default=1, type=int)
        size = request.args.get("size", default=10, type=int)
        name = request.args.get("name")
        location = request.args.get("location")
        query = self.db.session.query(Restaurant)
        if name:
            query = query.filter(Restaurant.name.like("%" + name + "%"))
        if location:
            query = query.filter(Restaurant.location.like("%" + location + "%"))
        restaurants = query.offset((page - 1) * size).limit(size).all()
        return jsonify({"restaurants": [r.to_dict() for r in restaurants]})

    def get_items_and_menus(self):
        page = request.args.get("page", default=1, type=int)
        size = request.args.get("size", default=10, type=int)
        restaurant_id = request.args.get("restaurant_id", type=int)
        item_query = self.db.session.query(Item)
        menu_query = self.db.session.query(Menu)
        if restaurant_id:
            item_query = item_query.filter_by(restaurant_id=restaurant_id)
            menu_query = menu_query.filter_by(restaurant_id=restaurant_id)
        items = item_query.offset((page - 1) * size).limit(size).all()
        menus = menu_query.offset((page - 1) * size).limit(size).all()
        return jsonify(
            {
                "items": [i.to_dict() for i in items],
                "menus": [m.to_dict() for m in menus],
            }
        )

    def qr(self):
        # Data to be encoded
        data = "https://hesapp.herokuapp.com"

        # Encoding data using make() function
        img = qrcode.make(data)
        img.save("src/static/restaurant.png")
        return render_template(
            "qr.html",
            filename="restaurant.png",
            restaurant_name="My Restaurant",
        )

    def qrs(self):
        try:
            restaurant_names, data = zip(
                *[
                    (
                        _.name,
                        f"https://hesapp.herokuapp.com/get_items_and_menus?restaurant_id={_.id}",
                    )
                    for _ in self.db.session.query(Restaurant).all()
                ]
            )

            # Create an empty list to store the QR code images
            qr_codes = []
            for i, d in enumerate(data):
                # Encoding data using make() function
                img = qrcode.make(d)
                img.save(f"src/static/restaurant{i+1}.png")
                qr_codes.append(f"restaurant{i+1}.png")
            return render_template(
                "qrs.html",
                qr_codes=qr_codes,
                restaurant_names=restaurant_names,
            )
        except ValueError:
            return jsonify(
                "Welcome to HesApp. Currently there is no restaurant/cafe to show."
            )
