import json

from db import db
from flask import Flask, request
from db import Task
from db import Category
from db import Menu
from db import Order
from db import Orderitem
from db import Asset

# define db filename
db_filename = "todo.db"
app = Flask(__name__) #instiation of an instance of flask

# setup config
app.config["SQLALCHEMY_DATABASE_URI"] = f"sqlite:///{db_filename}" #specify the variations we are using
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False  #has event listener feature to track the files modified
app.config["SQLALCHEMY_ECHO"] = True  #what to know what our python code would translate to sql code

# initialize app
db.init_app(app)
with app.app_context():
    db.create_all() # create all our tables


# generalized response formats
def success_response(data, code=200):
    return json.dumps(data), code


def failure_response(message, code=404):
    return json.dumps({"error": message}), code


# -- TASK ROUTES ------------------------------------------------------

@app.route("/")
def greet_user():
    return "Hello" + os.environ.get("NAME")

@app.route("/inventories/")
def get_inventories():
    """
    Endpoint for getting all inventories
    """
    inventories = []
    for inventory in Task.query.all():  
        inventories.append(inventory.serialize_for_render()) 

    return success_response({"inventories": inventories})



@app.route("/inventories/", methods=["POST"])
def create_inventory():
    """
    Endpoint for creating a new task
    """
    body = json.loads(request.data)  
    new_inventory= Task(
        image = body.get("image"),
        name = body.get("name"),
        description = body.get("description"),
        price = body.get("price")     
    )


@app.route("/inventories/<int:inventory_id>/")
def get_inventory_by_id(inventory_id):
    """
    Endpoint for getting an inventory by id
    """
    inventory = Task.query.filter_by(id = inventory_id).first()
    if inventory is None:
        return failure_response(f"Task not found {inventory_id}!")
    return success_response(inventory.serialize_for_render())


# -- CATEGORY ROUTES---------------------------------------------------

@app.route("/inventories/<int:inventory_id>/category/", methods=["POST"])
def assign_category(inventory_id):
    """
    Endpoint for assigning a category
    to an inventory by id
    """
    inventory = Task.query.filter_by(id = inventory_id).first()
    if inventory is None:
        return failure_response("Inventory not found!")
    
    body = json.loads(request.data)
    name = body.get("name")
    description = body.get("description")

    category = Category.query.filter_by(name = name).first()
    if category is None:
        category = Category(name = name, description= description)
    inventory.categories.append(category)
    return success_response(category.serialize())


@app.route("/categories/", methods=["GET"])
def get_all_categories():
    """
    Endpoint for getting all inventories
    """
    categories = []
    for category in Category.query.all(): 
        categories.append(category.serialize()) 
    return success_response({"categories": categories})


@app.route("/categories/<int:category_id>/", methods=["GET"])
def get_category(category_id):
    """
    Endpoint for getting a category by id
    """
    categories = []
    for category in Category.query.all(): 
        categories.append(category.serialize()) 
    return success_response({"categories": categories})

@app.route("/categories/m/", methods=["GET"])
def get_categories():
    """
    Endpoint for getting multiple categories by ids
    """
    categories = []
    for category in Category.query.all(): 
        categories.append(category.serialize()) 
    return success_response({"categories": categories})

def update_categories():
    pass

# -- MENU ROUTES---------------------------------------------------

@app.route("/menus/", methods=["GET"])
def get_menus():
    """
    Endpoint for getting all menus
    """
    menus = []
    for menu in Menu.query.all(): 
        menus.append(menu.serialize()) 
    return success_response({"menus": menus})

@app.route("/menus/", methods=["POST"])
def create_menu():
    """
    Endpoint for creating a new menu
    """
    menus = []
    for menu in Menu.query.all(): 
        menus.append(menu.serialize(Menu(description = "description"))) 
    return success_response({"menus": menus})

# -- ORDER ROUTES---------------------------------------------------
@app.route("/orders/", methods=["GET"])
def get_orders():
    """
    Endpoint for getting all orders
    """
    orders = []
    for order in Menu.query.all(): 
        orders.append(order.simple_serialize()) 
    return success_response({"orders": orders})

@app.route("/orders/submit/<int:order_id>/", methods=["POST"])
def submit_order(order_id):
    """
    Endpoint for submitting all orderitems with pickup information 
    """

    body = json.loads(request.data)  
    order.user_name =  body.get("user_name")
    order.time_created = datetime.datetime.now()
    # if the order is created after 19 
    pick_up_time = order.time_created + datetime.timedelta(days = 1)
    pick_up_time = pick_up_time.replace(hour =  18, minute= 59, second= 59)
    

    return success_response(order.serialize())

# -- ORDERITEM ROUTES---------------------------------------------------
@app.route("/orderitems/", methods=["GET"])
def get_orderitems():
    """
    Endpoint for getting all orderitems
    """
    orderitems = []
    for orderitem in Menu.query.all(): 
        orderitems.append(orderitem.serialize()) 
    return success_response({"orderitems": orderitems})

@app.route("/orderitems/<int:order_id>/<int:inventory_id>/", methods=["DELETE"])
def delete_orderitem(order_id, inventory_id):
    """
    Endpoint for deletinf an orderitem
    if order.order_items is empty, delte the order

    """
    if len(order.order_items) == 0:
        delete_order(order_id)

    return success_response(order.serialize())


    




