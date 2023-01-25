from sqlalchemy import Column, Integer, String, ForeignKey, Float
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from flask_sqlalchemy import SQLAlchemy

Base = declarative_base()


class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    username = Column(String(80), unique=True, nullable=False)
    password = Column(String(120), nullable=False)
    email = Column(String(120), unique=True, nullable=False)
    role = Column(String(20), nullable=False)
    orders = relationship("Order", back_populates="user")
    restaurant = relationship("Restaurant", back_populates="owner", uselist=False)

    def to_dict(self):
        return {
            "id": self.id,
            "username": self.username,
            "email": self.email,
            "role": self.role,
        }


class Restaurant(Base):
    __tablename__ = "restaurants"
    id = Column(Integer, primary_key=True)
    name = Column(String(80), unique=True, nullable=False)
    location = Column(String(120), nullable=False)
    contact = Column(String(120), nullable=False)
    user_id = Column(Integer, ForeignKey("users.id"))
    owner = relationship("User", back_populates="restaurant")
    items = relationship("Item", back_populates="restaurant")
    menus = relationship("Menu", back_populates="restaurant")
    orders = relationship("Order", back_populates="restaurant")

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "location": self.location,
            "contact": self.contact,
            "user_id": self.user_id,
        }


class Order(Base):
    __tablename__ = "orders"
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    date = Column(String(80), nullable=False)
    total = Column(Integer, nullable=False)
    restaurant_id = Column(Integer, ForeignKey("restaurants.id"))
    user = relationship("User", back_populates="orders")
    restaurant = relationship("Restaurant", back_populates="orders")

    def to_dict(self):
        return {
            "id": self.id,
            "user_id": self.user_id,
            "username": self.user.username,
            "date": self.date,
            "total": self.total,
            "restaurant_id": self.restaurant_id,
            "restaurant_name": self.restaurant.name,
        }


class Item(Base):
    __tablename__ = "items"
    id = Column(Integer, primary_key=True)
    name = Column(String(80), nullable=False)
    description = Column(String(120), nullable=False)
    price = Column(Float, nullable=False)
    quantity = Column(Integer, nullable=False)
    restaurant_id = Column(Integer, ForeignKey("restaurants.id"))
    restaurant = relationship("Restaurant", back_populates="items")

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "price": self.price,
            "quantity": self.quantity,
            "restaurant_id": self.restaurant_id,
            "restaurant_name": self.restaurant.name,
        }


class ItemOrder(Base):
    __tablename__ = "item_orders"
    id = Column(Integer, primary_key=True)
    order_id = Column(Integer, ForeignKey("orders.id"))
    item_id = Column(Integer, ForeignKey("items.id"))
    quantity = Column(Integer, nullable=False)

    def to_dict(self):
        return {
            "id": self.id,
            "order_id": self.order_id,
            "item_id": self.item_id,
            "quantity": self.quantity,
        }


class Menu(Base):
    __tablename__ = "menus"
    id = Column(Integer, primary_key=True)
    name = Column(String(80), nullable=False)
    description = Column(String(120), nullable=False)
    price = Column(Float, nullable=False)
    quantity = Column(Integer, nullable=False)
    restaurant_id = Column(Integer, ForeignKey("restaurants.id"))
    restaurant = relationship("Restaurant", back_populates="menus")

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "price": self.price,
            "quantity": self.quantity,
            "restaurant_id": self.restaurant_id,
        }


class MenuOrder(Base):
    __tablename__ = "menu_orders"
    id = Column(Integer, primary_key=True)
    order_id = Column(Integer, ForeignKey("orders.id"))
    menu_id = Column(Integer, ForeignKey("menus.id"))
    quantity = Column(Integer, nullable=False)

    def to_dict(self):
        return {
            "id": self.id,
            "order_id": self.order_id,
            "menu_id": self.menu_id,
            "quantity": self.quantity,
        }


def get_db(app):
    db = SQLAlchemy(app)
    db.init_app(app)
    return db
