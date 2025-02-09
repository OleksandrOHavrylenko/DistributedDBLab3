CALL db.schema.visualization()

CALL db.schema.nodeTypeProperties()
CALL db.schema.relTypeProperties()
SHOW CONSTRAINTS

//You can also delete all nodes and relationships in a database with this code.
MATCH (n)
DETACH DELETE n
//-----------------------

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/OleksandrOHavrylenko/DistributedDBLab3/refs/heads/main/src/main/resources/data/customers.csv' AS customers
return customers

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/OleksandrOHavrylenko/DistributedDBLab3/refs/heads/main/src/main/resources/data/orders.csv' AS orders
return orders

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/OleksandrOHavrylenko/DistributedDBLab3/refs/heads/main/src/main/resources/data/items.csv' AS items
return items

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/OleksandrOHavrylenko/DistributedDBLab3/refs/heads/main/src/main/resources/data/bought_includes.csv' AS bought
return bought

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/OleksandrOHavrylenko/DistributedDBLab3/refs/heads/main/src/main/resources/data/viewed.csv' AS viewed
return viewed

//Load Customers--------------

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/OleksandrOHavrylenko/DistributedDBLab3/refs/heads/main/src/main/resources/data/customers.csv' AS row
MERGE (c:Customer {customerId: toInteger(row.customerId)})
SET
c.name = row.name

CREATE CONSTRAINT Customer_id IF NOT EXISTS
FOR (c:Customer) 
REQUIRE c.customerId IS UNIQUE

MATCH (c:Customer)
return c

// Load Orders-----------

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/OleksandrOHavrylenko/DistributedDBLab3/refs/heads/main/src/main/resources/data/orders.csv' AS row
MERGE (o:Order {orderId: toInteger(row.orderId)})
SET
o.title = row.title

CREATE CONSTRAINT Order_id IF NOT EXISTS
FOR (o:Order) 
REQUIRE o.orderId IS UNIQUE

MATCH (o:Order)
return o


//Load Items---------------------------

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/OleksandrOHavrylenko/DistributedDBLab3/refs/heads/main/src/main/resources/data/items.csv' AS row
MERGE (i:Item {itemId: toInteger(row.itemId)})
SET
i.title = row.title,
i.price = toFloat(row.price),
i.likesCounter = toInteger(row.likesCounter)

CREATE CONSTRAINT Item_id IF NOT EXISTS
FOR (i:Item) 
REQUIRE i.itemId IS UNIQUE

MATCH (i:Item)
return i

//Load BOUGHT and INCLUDES relationships----

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/OleksandrOHavrylenko/DistributedDBLab3/refs/heads/main/src/main/resources/data/bought_includes.csv' AS row
MATCH (c:Customer {customerId: toInteger(row.customerId)})
MATCH (o:Order {orderId: toInteger(row.orderId)})
MATCH (i:Item {itemId: toInteger(row.itemId)})
MERGE (c)-[:BOUGHT]->(o)
MERGE (o)-[:INCLUDES]->(i)

//Load VIEWED relationships----

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/OleksandrOHavrylenko/DistributedDBLab3/refs/heads/main/src/main/resources/data/viewed.csv' AS row
MATCH (c:Customer {customerId: toInteger(row.customerId)})
MATCH (i:Item {itemId: toInteger(row.itemId)})
MERGE (c)-[:VIEWED]->(i)