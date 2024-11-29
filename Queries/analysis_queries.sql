-- Query 1: High-Value In-Transit Orders
-- Business Context: Identify priority shipments and high-value customers for enhanced tracking
-- and customer service.
SELECT customerFName, customerLName, orderStatus, SUM(orderQty*productPrice) AS "Order Total" 
FROM Customers
JOIN Orders ON Customers.customerID = Orders.customerID
JOIN OrderDetails ON Orders.orderID = OrderDetails.orderID
WHERE orderStatus = 'In transit'
GROUP BY customerFName, customerLName, orderStatus
HAVING SUM(orderQty*productPrice) > 100;

-- Query 2: In-Transit Orders Without Shopping Lists
-- Business Context: Identify opportunities for customer engagement and shopping list feature adoption
SELECT customerFName, customerLName 
FROM Customers
JOIN Orders ON Customers.customerID = Orders.customerID
WHERE orderstatus REGEXP "In transit"
AND NOT EXISTS (SELECT * FROM ShoppingList
                WHERE Customers.customerID = ShoppingList.customerID);

-- Query 3: Customer Order Value Analysis
-- Business Context: Analyze customer spending patterns and identify top spenders
SELECT customerFName, customerLName, SUM(productPrice) AS 'OrderPrice' 
FROM Customers
JOIN Orders ON Orders.customerID=Customers.customerID
JOIN OrderDetails ON OrderDetails.orderID=Orders.orderID
GROUP BY customerFName, customerLName
ORDER BY SUM(productPrice);

-- Query 4: Ad Category Analysis
-- Business Context: Identify underutilized advertisement categories for optimization
SELECT DATEDIFF(endDate,startDate), adCategory 
FROM WeeklyAd
GROUP BY adCategory, DATEDIFF(endDate,startDate)
HAVING COUNT(adCategory) = 1;

-- Query 5: Shopping List Product Analysis
-- Business Context: Track specific product interest among customers
SELECT customerFName, customerLName 
FROM Customers
JOIN ShoppingList ON Customers.customerId = ShoppingList.customerID
JOIN shoppingItems ON ShoppingList.listID = shoppingItems.listID
JOIN Products ON shoppingItems.productID = Products.productID
WHERE productName = "Drain cleaner"
AND EXISTS (SELECT * FROM shoppingItems 
           WHERE shoppingItems.productID = Products.productID);

-- Query 6: High-Value Item Customer Analysis
-- Business Context: Identify customers interested in premium products
SELECT customerFName, customerLName 
FROM Customers
JOIN Orders ON Orders.customerID=Customers.customerID
WHERE orderID IN
    (SELECT orderID FROM OrderDetails WHERE productPrice >25);

-- Query 7: Organic Product Shopping List Analysis
-- Business Context: Track customer interest in organic products
SELECT listName, productName, ShoppingList.listID 
FROM ShoppingList
JOIN shoppingItems ON ShoppingList.listID = shoppingItems.listID
JOIN Products ON shoppingItems.productID = Products.productID
WHERE productName REGEXP "^organic";

-- Query 8: High-Value Coupon Analysis
-- Business Context: Track significant discount offerings
SELECT couponCode, couponRate 
FROM Coupons
WHERE couponRate >10.00
ORDER BY couponRate DESC;

-- Query 9: Customer Age Analysis
-- Business Context: Identify longest-standing customer
SELECT customerFName, customerLName, customerDOB 
FROM Customers
WHERE customerDOB = (SELECT MIN(customerDOB) FROM Customers);

-- Query 10: Shipped Orders Analysis
-- Business Context: Track order completion status
SELECT customerFName, customerLName 
FROM Customers
JOIN Orders ON Customers.customerID = Orders.customerID
WHERE orderStatus = "Shipped";