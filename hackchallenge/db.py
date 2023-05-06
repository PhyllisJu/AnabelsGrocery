from flask_sqlalchemy import SQLAlchemy
import base64
import boto3
import datetime
import io
from io import BytesIO
from mimetypes import guess_extension, guess_type
import os
from PIL import Image
import random
import re
import string

db = SQLAlchemy()

inventory_category_association_table = db.Table(
  "association_category",
  db.Column("inventory_id", db.Integer, db.ForeignKey("inventory.id")),
  db.Column("category_id", db.Integer, db.ForeignKey("category.id"))
)

inventory_order_menu_association_table = db.Table(
  "association_menu",
  db.Column("inventory_id", db.Integer, db.ForeignKey("inventory.id")),
  db.Column("menu_id", db.Integer, db.ForeignKey("menu.id")) 
)

class Inventory (db.Model):
  """
  Inventory Model
  """

  __tablename__ = "inventory"
  id = db.Column(db.Integer, primary_key = True, autoincrement = True) 
  image = db.Column(db.String, nullable = False)
  name = db.Column(db.String, nullable = False)
  description = db.Column(db.String, nullable = False)
  price = db.Column(db.Float, nullable = False)
  # many to many (name + 's' represents for many to many field name), could be null
  categories = db.relationship("Category", secondary = inventory_category_association_table, back_populates = "inventories") 
  menus = db.relationship("Menu", secondary = inventory_order_menu_association_table, back_populates = "inventories")
  # orderitems
  order_items = db.relationship("Orderitem", cascade = "delete")

  def __init__(self, **kwargs):
    """
    Initializes an Inventory object
    """
    self.image =  kwargs.get("image", "") 
    self.name = kwargs.get("name", "") 
    self.description = kwargs.get("description", "") 
    self.price = kwargs.get("price", "") 
  
  def serialize_for_category(self):
    """
    Serializes a Inventory object
    """

    return {
      "id": self.id,
      "image": self.image,
      "name": self.name,
      "description": self.description,
      "price": self.price
    }


class Category(db.Model):
  """
  Category model
  """

  __tablename__ = "category"
  id = db.Column(db.Integer, primary_key = True, autoincrement = True)
  name = db.Column(db.String, nullable = False)
  description = db.Column(db.String, nullable = False)
  inventories = db.relationship("Inventory", secondary = inventory_category_association_table, back_populates ="categories")


  def __init__(self, **kwargs):
    """
    Initialize a Category object
    """

    self.name = kwargs.get("name")
    self.description = kwargs.get("description", "")
   

  def serialize(self):
    """
    serialize
    """


class Menu(db.Model):
  """
  Menu model
  """

  __tablename__ = "menu"
  id = db.Column(db.Integer, primary_key = True, autoincrement = True) 
  name = db.Column(db.String, nullable = False)
  description = db.Column(db.String, nullable = False)
  instruction = db.Column(db.String, nullable = False)
  inventories = db.relationship("Inventory", secondary = inventory_order_menu_association_table, back_populates ="menus")
  #----------
  # images = db.relationship("Asset", cascade = "delete")
  image_id = db.Column(db.Integer, db.ForeignKey("assets.id"), nullable=False)


  def __init__(self, **kwargs):
    """
    Initialize a Category object
    """
    self.name = kwargs.get("name", "")
    self.description = kwargs.get("description", "")
    self.instruction = kwargs.get("instruction", "")
    self.image_id = kwargs.get("image_id", "")
  
  
  def simple_serialize(self):
    return{"id": self.id,  
           "name": self.name, 
           "description": self.description
           }
  
class Order(db.Model):
  """
  Order model
  """

  __tablename__ = "order"
  id = db.Column(db.Integer, primary_key = True, autoincrement = True) 
  time_created = db.Column(db.DateTime)
  pick_up_by  = db.Column(db.DateTime)
  total_price = db.Column(db.Float, nullable = False)
  valid = db.Column(db.Boolean, nullable = False)
  # one to many
  order_items = db.relationship("Orderitem", cascade = "delete")


  
  def __init__(self, **kwargs):
    """
    Initialize a Category object
    """
    
    self.total_price = kwargs.get("total_price", 0)
    self.valid = kwargs.get("valid", False)
    

  def serialize(self):
    """
    serialize
    """
    return{"id": self.id, 
           "time_created": str(self.time_created),
           "pick_up_by": str(self.pick_up_by),
           "total_price": self.total_price,
           "valid": self.valid,
           "order_items": [oi.serialize() for oi in self.order_items]
           }

  
class Orderitem(db.Model):
  """
  Orderitem model
  """
  __tablename__ = "orderitem"
  id = db.Column(db.Integer, primary_key = True, autoincrement = True) 
  num_sel = db.Column(db.Integer,  nullable = False)
  inventory_id = db.Column(db.Integer, db.ForeignKey("inventory.id"), nullable = False)
  order_id = db.Column(db.Integer, db.ForeignKey("order.id"), nullable = False)

  def __init__(self, **kwargs):
    """
    Initialize an Orderitem object
    """
    self.inventory_id = kwargs.get("inventroy_id", "")
    self.num_sel = kwargs.get("num_sel", "")
    self.order_id = kwargs.get("order_id", "")
  

  
  def serialize_for_order(self):
    """
    Serialize
    """
    inventory = Inventory.query.filter_by(id = self.inventory_id).first()

    return{

      "image": inventory.image,
      "name": inventory.name,
      "selectedNum":self.num_sel
    }
  
  