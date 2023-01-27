from cerberus import Validator

### AUTHENTICATION ###
register_customer_schema = {
    "username": {"type": "string", "required": True},
    "password": {"type": "string", "required": True},
    "email": {"type": "string", "required": True},
    "role": {"type": "string", "required": True, "allowed": ["customer"]},
}

register_restaurant_schema = {
    "username": {"type": "string", "required": True},
    "password": {"type": "string", "required": True},
    "email": {"type": "string", "required": True},
    "role": {"type": "string", "required": True, "allowed": ["restaurant"]},
    "restaurant_name": {"type": "string", "required": True},
    "restaurant_location": {"type": "string", "required": True},
    "restaurant_contact": {"type": "string", "required": True},
}

login_schema = {
    "username": {
        "required": True,
        "type": "string",
        "empty": False,
        "nullable": False,
        "excludes": ["email"],
    },
    "email": {
        "required": True,
        "type": "string",
        "empty": False,
        "nullable": False,
        "excludes": ["username"],
    },
    "password": {"type": "string", "required": True},
}

update_profile_schema = {
    "username": {"type": "string", "required": False},
    "password": {"type": "string", "required": False},
    "new_password": {
        "type": "string",
        "required": False,
        "dependencies": ["confirm_new_password", "password"],
    },
    "confirm_new_password": {
        "type": "string",
        "required": False,
        "dependencies": ["new_password", "password"],
    },
    "email": {"type": "string", "required": False},
    "restaurant_name": {
        "type": "string",
        "required": False,
        "dependencies": {"role": "restaurant"},
    },
    "restaurant_location": {
        "type": "string",
        "required": False,
        "dependencies": {"role": "restaurant"},
    },
    "restaurant_contact": {
        "type": "string",
        "required": False,
        "dependencies": {"role": "restaurant"},
    },
}

### ITEM ###
create_item_schema = {
    "name": {"type": "string", "required": True},
    "description": {"type": "string", "required": True},
    "price": {"type": "float", "required": True},
    "quantity": {"type": "integer", "required": True},
}

update_item_schema = {
    "id": {"type": "integer", "required": True},
    "name": {"type": "string", "required": False},
    "description": {"type": "string", "required": False},
    "price": {"type": "float", "required": False},
    "quantity": {"type": "integer", "required": False},
}

delete_item_schema = {
    "id": {"type": "integer", "required": True},
}

### MENU ###
create_menu_schema = {
    "name": {"type": "string", "required": True},
    "description": {"type": "string", "required": True},
    "price": {"type": "float", "required": True},
    "quantity": {"type": "integer", "required": True},
}

update_menu_schema = {
    "id": {"type": "integer", "required": True},
    "name": {"type": "string", "required": False},
    "description": {"type": "string", "required": False},
    "price": {"type": "float", "required": False},
    "quantity": {"type": "integer", "required": False},
}

delete_menu_schema = {
    "id": {"type": "integer", "required": True},
}


### ORDER ###
create_order_schema = {
    "restaurant_id": {"type": "integer", "required": True},
    "items": {
        "type": "list",
        "schema": {
            "type": "dict",
            "schema": {
                "id": {"type": "integer", "required": True},
                "quantity": {"type": "integer", "required": True},
            },
        },
    },
    "menus": {
        "type": "list",
        "schema": {
            "type": "dict",
            "schema": {
                "id": {"type": "integer", "required": True},
                "quantity": {"type": "integer", "required": True},
            },
        },
    },
}
