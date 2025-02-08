CALL db.schema.visualization()

CALL db.schema.nodeTypeProperties()
CALL db.schema.relTypeProperties()
SHOW CONSTRAINTS

//-----------------------

LOAD CSV WITH HEADERS
FROM 'https://drive.google.com/uc?export=download&id=12E9_mZdfger5jYD0H5fw17eRtPq-5Xll' AS row
return row

LOAD CSV WITH HEADERS
FROM 'https://drive.google.com/uc?export=download&id=1iyEyFGrsWH6-iq2A36Do-6piIQ5g9DRl' AS row
return row

LOAD CSV WITH HEADERS
FROM 'https://drive.google.com/uc?export=download&id=1S0nk7SZMEbdsQC0RmuJhjdSqQQw7v4AO' AS row
return row

LOAD CSV WITH HEADERS
FROM 'https://drive.google.com/uc?export=download&id=1lxPCogo1Mlp2VPy61uCFHraPBDsm1G7z' AS row
return row

LOAD CSV WITH HEADERS
FROM 'https://drive.google.com/uc?export=download&id=1bM5B3r7oGvQPI7mi6W9wTUnpwjU6ebja' AS row
return row

//--------------

LOAD CSV WITH HEADERS
FROM 'https://drive.google.com/uc?export=download&id=12E9_mZdfger5jYD0H5fw17eRtPq-5Xll' AS row
MERGE (c:Customer {customerId: toInteger(row.customerId)})
SET
c.name = row.name,
c.title = row.title

CREATE CONSTRAINT Customer_id IF NOT EXISTS
FOR (c:Customer) 
REQUIRE c.customerId IS UNIQUE

MATCH (c:Customer)
return c

//-----------

LOAD CSV WITH HEADERS
FROM 'https://drive.google.com/uc?export=download&id=1iyEyFGrsWH6-iq2A36Do-6piIQ5g9DRl' AS row
MERGE (o:Order {orderId: (row.orderId)})
SET
o.title = row.title

CREATE CONSTRAINT Order_id IF NOT EXISTS
FOR (o:Order) 
REQUIRE o.orderId IS UNIQUE

MATCH (o:Order)
return o


//---------------------------

LOAD CSV WITH HEADERS
FROM 'https://drive.google.com/uc?export=download&id=1S0nk7SZMEbdsQC0RmuJhjdSqQQw7v4AO' AS row
MERGE (i:Item {itemId: (row.itemId)})
SET
i.title = row.title,
i.price = toFloat(row.price),
i.likesCounter = toInteger(row.likesCounter)

CREATE CONSTRAINT Item_id IF NOT EXISTS
FOR (i:Item) 
REQUIRE i.itemId IS UNIQUE

MATCH (i:Item)
return i