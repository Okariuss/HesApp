from flask import Flask
from flask_jwt_extended import (
    JWTManager,
    jwt_required,
)
from flask_cors import CORS
from sqlalchemy import inspect
from .db import Base, get_db
from .authentication_handler import AuthenticationHandler
from .order_handler import OrderHandler
from .item_handler import ItemHandler
from .menu_handler import MenuHandler
from .restaurant_handler import RestaurantHandler

APP = Flask(__name__)
APP.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///hesapp.db"
APP.config["JWT_SECRET_KEY"] = "thisisakekwsecret007"
CORS(APP)

db = get_db(APP)
jwt = JWTManager(APP)

with APP.app_context():
    try:
        inspector = inspect(db.engine)
        for table_name in Base.metadata.tables:
            if table_name not in inspector.get_table_names():
                Base.metadata.create_all(bind=db.engine, checkfirst=True)
    except Exception as e:
        if "already exists" in str(e):
            pass
        else:
            raise e


h_auth = AuthenticationHandler(APP, db)
h_order = OrderHandler(APP, db)
h_item = ItemHandler(APP, db)
h_menu = MenuHandler(APP, db)
h_restaurant = RestaurantHandler(APP, db)

# Authentication
APP.route("/register", methods=["POST"])(h_auth.register)
APP.route("/login", methods=["POST"])(h_auth.login)
APP.route("/get_profile", methods=["GET"])(jwt_required()(h_auth.get_profile))
APP.route("/update_profile", methods=["PUT"])(jwt_required()(h_auth.update_profile))
APP.route("/delete_profile", methods=["DELETE"])(jwt_required()(h_auth.delete_profile))

# Restaurant
APP.route("/get_restaurants", methods=["GET"])(h_restaurant.get_restaurants)
APP.route("/get_items_and_menus", methods=["GET"])(h_restaurant.get_items_and_menus)
APP.route("/", methods=["GET"])(h_restaurant.qrs)

# Item
APP.route("/create_item", methods=["POST"])(jwt_required()(h_item.create_item))
APP.route("/get_items", methods=["GET"])(h_item.get_items)
APP.route("/update_item", methods=["PUT"])(jwt_required()(h_item.update_item))
APP.route("/delete_item/<int:id>", methods=["DELETE"])(
    jwt_required()(h_item.delete_item)
)

# Menu
APP.route("/create_menu", methods=["POST"])(jwt_required()(h_menu.create_menu))
APP.route("/get_menus", methods=["GET"])(h_menu.get_menus)
APP.route("/update_menu", methods=["PUT"])(jwt_required()(h_menu.update_menu))
APP.route("/delete_menu/<int:id>", methods=["DELETE"])(
    jwt_required()(h_menu.delete_menu)
)

# Order
APP.route("/create_order", methods=["POST"])(jwt_required()(h_order.create_order))
APP.route("/get_orders", methods=["GET"])(jwt_required()(h_order.get_orders))
APP.route("/get_order", methods=["GET"])(jwt_required()(h_order.get_order))


if __name__ == "__main__":
    APP.run(host="0.0.0.0", debug=False)
