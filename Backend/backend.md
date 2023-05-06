# Inventory
## GET all inventories 
```
GET /inventories/
```
```
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}
```
## CREATE an inventory
```
POST /inventories/
```
## GET an inventory by id
```
GET /inventories//<int:inventory_id>/
```

# Category
## assign a category to an inventory by inventory_id
## GET all categories
## GET a category of an by inventory_id 


# Menu
## GET all menus
## CREATE a menu
## ADD inventories to menu


# Order
## GET all orders
## CREATE an order
## ADD an item to order
## submit the order
## DELETE the order


# Order Item
## GET order item
## CREATE order item (simple)
## CREATE order item (full version)
## UPDATE order item (increase)
## UPDATE order item (decrease)
## DELETE order item
