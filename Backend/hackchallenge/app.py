import json

from db import db
from flask import Flask, request
from db import Inventory
from db import Category
from db import Menu
from db import Order
from db import Orderitem
import os

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
# def greet_user():
#     return "Hello" + os.environ.get("NAME")


@app.route("/inventories/")
def get_inventories():
    """
    Endpoint for getting all inventories
    """
    inventories = []
    for inventory in Inventory.query.all():  #query.all() / Task in an SQLAlchemy object of class db.Model
        inventories.append(inventory.serialize()) #serialize takes in a python object and turns into a dictionary format to user

    return success_response({"inventories": inventories})



@app.route("/inventories/", methods=["POST"])
def create_inventory():
    """
    Endpoint for creating a new task
    """
    body = json.loads(request.data)  
    new_inventory= Inventory(
        image = body.get("image"),
        name = body.get("name"),
        description = body.get("description"),
        price = body.get("price")     
    )

    db.session.add(new_inventory)
    db.session.commit()
    return success_response(new_inventory.serialize(), 201)


@app.route("/inventories/<int:inventory_id>/")
def get_task(inventory_id):
    """
    Endpoint for getting a task by id
    """
    inventory = Inventory.query.filter_by(id = inventory_id).first()
    if inventory is None:
        return failure_response(f"Task not found {inventory_id}!")
    return success_response(inventory.serialize())


# @app.route("/tasks/<int:task_id>/", methods=["POST"])
# def update_task(task_id):
#     """
#     Endpoint for updating a task by id
#     """
#     body = json.loads(request.data)
#     task = Task.query.filter_by(id = task_id).first()
#     if task is None:
#         return failure_response("Task not found!")
#     task.description = body.get("description", task.description) #second argument is the default
#     task.done = body.get("done", task.done)
#     db.session.commit()
#     return success_response(task.serialize())

# @app.route("/tasks/<int:task_id>/", methods=["DELETE"])
# def delete_task(task_id):
#     """
#     Endpoint for deleting a task by id
#     """
#     task = Task.query.filter_by(id = task_id).first()
#     if task is None:
#         return failure_response("Task not found!")
#     db.session.delete(task)
#     db.session.commit()
#     return success_response(task.serialize())

# -- CATEGORY ROUTES---------------------------------------------------

@app.route("/inventories/<int:inventory_id>/category/", methods=["POST"])
def assign_category(inventory_id):
    """
    Endpoint for assigning a category
    to an inventory by id
    """
    inventory = Inventory.query.filter_by(id = inventory_id).first()
    if inventory is None:
        return failure_response("Task not found!")
    
    body = json.loads(request.data)
    name = body.get("name")
    description = body.get("description")

    category = Category.query.filter_by(name = name).first()
    if category is None:
        category = Category(name = name, description= description)
    inventory.categories.append(category)
    db.session.commit()
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
    category = Category.query.filter_by(id = category_id).first()
    if category is None:
        return failure_response("Category not found!")
    return success_response(category.serialize())


@app.route("/categories/", methods=["GET"])
def get_categories():
    """
    Endpoint for getting multiple categories by ids
    """
    length :int = request.args["length"]
    category_id_list =[]
    for i in range(length):
        category_id_list.append(request.args[f"c{i}"])

    response = []
    for category_id in category_id_list:
      category = Category.query.filter_by(id = category_id).first()
      if category is None:
        return failure_response("Category not found!")
      response.append(category.serialize())
      
    return success_response({"categories": response })

# -- MENU ROUTES---------------------------------------------------




#---------------------------------reference from demo 5-------------------------
#---------------------------------reference from demo 5-------------------------   

# -- SUBTASK ROUTES ---------------------------------------------------


# @app.route("/tasks/<int:task_id>/subtasks/", methods=["POST"])
# def create_subtask(task_id):
#     """
#     Endpoint for creating a subtask
#     for a task by id
#     """
#     task = Task.query.filter_by(id = task_id).first()
#     if task is None:
#         return failure_response("Task not found!")
#     body = json.loads(request.data)
#     new_subtask = Subtask(
#         description = body.get("description"),
#         done = body.get("done"),
#         task_id = task_id
#     )

#     db.session.add(new_subtask)
#     db.session.commit()
#     return success_response(new_subtask.serialize())







if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8002, debug=True)

