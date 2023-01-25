from flask import Flask
from flask_jwt_extended import (
    JWTManager,
    jwt_required,
)
from .db import Base, get_db
from .authentication_handler import AuthenticationHandler
from .order_handler import OrderHandler
from .item_handler import ItemHandler
from .menu_handler import MenuHandler

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///hesapp.db"
app.config["JWT_SECRET_KEY"] = "thisisakekwsecret007"

db = get_db(app)
jwt = JWTManager(app)

with app.app_context():
    Base.metadata.create_all(bind=db.engine)

h_auth = AuthenticationHandler(app, db)
h_order = OrderHandler(app, db)
h_item = ItemHandler(app, db)
h_menu = MenuHandler(app, db)

# Authentication
app.route("/register", methods=["POST"])(h_auth.register)
app.route("/login", methods=["POST"])(h_auth.login)
app.route("/get_profile", methods=["GET"])(jwt_required()(h_auth.get_profile))
app.route("/update_profile", methods=["PUT"])(jwt_required()(h_auth.update_profile))
app.route("/delete_profile", methods=["DELETE"])(jwt_required()(h_auth.delete_profile))

# Item
app.route("/create_item", methods=["POST"])(jwt_required()(h_item.create_item))
app.route("/get_items", methods=["GET"])(jwt_required()(h_item.get_items))
app.route("/update_item", methods=["PUT"])(jwt_required()(h_item.update_item))
app.route("/delete_item", methods=["DELETE"])(jwt_required()(h_item.delete_item))

# Menu
app.route("/create_menu", methods=["POST"])(jwt_required()(h_menu.create_menu))
app.route("/get_menus", methods=["GET"])(jwt_required()(h_menu.get_menus))
app.route("/update_menu", methods=["PUT"])(jwt_required()(h_menu.update_menu))
app.route("/delete_menu", methods=["DELETE"])(jwt_required()(h_menu.delete_menu))

# Order
app.route("/create_order", methods=["POST"])(jwt_required()(h_order.create_order))
app.route("/get_orders", methods=["GET"])(jwt_required()(h_order.get_orders))
app.route("/get_order", methods=["GET"])(jwt_required()(h_order.get_order))


if __name__ == "__main__":
    app.run(host="0.0.0.0",debug=False)
