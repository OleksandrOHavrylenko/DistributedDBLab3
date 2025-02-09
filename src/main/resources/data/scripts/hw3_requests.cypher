//1 Знайти Items які входять в конкретний Order
MATCH (o:Order)-[:INCLUDES]->(i:Item)
WHERE o.orderId = 1
RETURN i AS `Items`;

//2 Підрахувати вартість конкретного Order
MATCH (o:Order)-[:INCLUDES]->(i:Item)
WHERE o.orderId = 1
RETURN SUM(i.price) AS `Order Cost`;

//3 Знайти всі Orders конкретного Customer
MATCH (c:Customer)-[:BOUGHT]->(o:Order)
WHERE c.customerId = 1
RETURN o AS `Orders`;

//4 Знайти всі Items куплені конкретним Customer (через Order)
MATCH (c:Customer)-[:BOUGHT]->(o:Order)-[:INCLUDES]->(i:Item)
WHERE c.customerId = 1
RETURN DISTINCT i AS `Items`;

//5 Знайти кількість Items куплені конкретним Customer (через Order)
MATCH (c:Customer)-[:BOUGHT]->(o:Order)-[:INCLUDES]->(i:Item)
WHERE c.customerId = 1
RETURN COUNT(i) AS `Items Count`;

//6 Знайти для Customer на яку суму він придбав товарів (через Order)
MATCH (c:Customer)-[:BOUGHT]->(o:Order)-[:INCLUDES]->(i:Item)
WHERE c.customerId = 1
RETURN SUM(i.price) AS `Total Cost`;

//7 Знайті скільки разів кожен товар був придбаний, відсортувати за цим значенням
MATCH (o:Order)-[:INCLUDES]->(i:Item)
RETURN i.itemId, i.title, COUNT(i) AS `Count times bought`
ORDER BY COUNT(i) DESC;

//8 Знайти всі Items переглянуті (view) конкретним Customer
MATCH (c:Customer)-[:VIEWED]->(i:Item)
WHERE c.customerId = 1
RETURN i AS `Items Viewed`;

//9 Знайти інші Items що купувались разом з конкретним Item (тобто всі Items що входять до Order-s разом з даними Item)


//10 Знайти Customers які купили даний конкретний Item
MATCH (c:Customer)-[:BOUGHT]->(o:Order)-[:INCLUDES]->(i:Item)
WHERE i.itemId = 2
RETURN DISTINCT c AS `Customers`;

//11 Знайти для певного Customer(а) товари, які він переглядав, але не купив
MATCH (c:Customer)-[:VIEWED]->(i:Item)
WHERE c.customerId = 1 AND
NOT EXISTS {
    MATCH (c:Customer)-[:BOUGHT]->(o:Order)-[:INCLUDES]->(i:Item)
    WHERE c.customerId = 1
}
RETURN i AS `Viewed but not Bought Items`;