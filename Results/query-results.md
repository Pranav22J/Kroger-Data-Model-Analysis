# Kroger Database Analysis - Query Results

## Query 1: High-Value In-Transit Orders

### Business Question
Which customers have high-value orders currently in transit?

### Business Value
Helps identify priority shipments and high-value customers for enhanced tracking and customer service.

### Query
```sql
SELECT customerFName, customerLName, orderStatus, SUM(orderQty*productPrice) AS "Order Total" 
FROM Customers
JOIN Orders ON Customers.customerID = Orders.customerID
JOIN OrderDetails ON Orders.orderID = OrderDetails.orderID
WHERE orderStatus = 'In transit'
GROUP BY customerFName, customerLName, orderStatus
HAVING SUM(orderQty*productPrice) > 100;
```

### Results
| customerFName | customerLName | orderStatus | Order Total |
|--------------|---------------|-------------|-------------|
| Ben          | Baria        | In transit  | 155         |

### Insights
- Only one customer currently has a high-value order in transit
- The order value is significantly above the $100 threshold
- Could indicate opportunity for premium shipping services
- Potential for targeted high-value customer service

## Query 2: In-Transit Orders Without Shopping Lists

### Business Question
Which customers with in-transit orders haven't created a shopping list?

### Business Value
Identifies opportunities for customer engagement and shopping list feature adoption.

### Query
```sql
SELECT customerFName, customerLName 
FROM Customers
JOIN Orders ON Customers.customerID = Orders.customerID
WHERE orderstatus REGEXP "In transit"
AND NOT EXISTS (SELECT * FROM ShoppingList
                WHERE Customers.customerID = ShoppingList.customerID);
```

### Results
| customerFName | customerLName |
|--------------|---------------|
| Juan         | Guavera      |

### Insights
- One customer identified who hasn't utilized the shopping list feature
- Opportunity for targeted feature promotion
- Could indicate need for better shopping list feature visibility
- Potential for customer education about platform features

## Query 3: Customer Order Value Analysis

### Business Question
What is the total order value per customer, ranked by spending?

### Business Value
Enables customer segmentation by spend and identifies top customers for loyalty programs.

### Query
```sql
SELECT customerFName, customerLName, SUM(productPrice) AS 'OrderPrice' 
FROM Customers
JOIN Orders ON Orders.customerID=Customers.customerID
JOIN OrderDetails ON OrderDetails.orderID=Orders.orderID
GROUP BY customerFName, customerLName
ORDER BY SUM(productPrice);
```

### Results
| customerFName | customerLName | OrderPrice |
|--------------|---------------|------------|
| Juan         | Guavera      | 5          |
| Pranav       | Jonnavithula | 10         |
| Conner       | Reid         | 17         |
| Engin        | Terzi        | 19         |
| Vaughn       | McCavey      | 25         |
| Alan         | Zoloev       | 29         |
| Ben          | Baria        | 31         |
| Jacob        | Sehl         | 35         |
| Levan        | Saginashvili | 38         |
| Cody         | Wood         | 70         |

### Insights
- Wide range of order values from $5 to $70
- Majority of customers spend less than $40
- Potential for targeted promotions to increase average order value
- Opportunity to analyze what drives higher order values

## Query 4: Ad Category Analysis

### Business Question
Which advertisement categories have been used only once in weekly ads?

### Business Value
Helps optimize advertising strategy by identifying underutilized categories.

### Query
```sql
SELECT DATEDIFF(endDate,startDate), adCategory 
FROM WeeklyAd
GROUP BY adCategory, DATEDIFF(endDate,startDate)
HAVING COUNT(adCategory) = 1;
```

### Results
| datediff(endDate,startDate) | adCategory |
|----------------------------|------------|
| 6                          | Makeup     |
| 6                          | Coupons    |

### Insights
- Two categories show limited usage: Makeup and Coupons
- Both categories run for 6-day periods
- Potential opportunity to increase advertising frequency
- Could indicate need for category performance analysis

## Query 5: Shopping List Product Analysis

### Business Question
Which customers included drain cleaner in their shopping lists?

### Business Value
Enables targeted marketing for cleaning supply promotions.

### Query
```sql
SELECT customerFName, customerLName 
FROM Customers
JOIN ShoppingList ON Customers.customerId = ShoppingList.customerID
JOIN shoppingItems ON ShoppingList.listID = shoppingItems.listID
JOIN Products ON shoppingItems.productID = Products.productID
WHERE productName = "Drain cleaner"
AND EXISTS (SELECT * FROM shoppingItems 
           WHERE shoppingItems.productID = Products.productID);
```

### Results
| customerFName | customerLName |
|--------------|---------------|
| Levan        | Saginashvili |

### Insights
- One customer identified with interest in cleaning supplies
- Opportunity for targeted cleaning product promotions
- Potential for bundle recommendations
- Could indicate timing for cleaning supply promotions

## Query 6: High-Value Item Customer Analysis

### Business Question
Who are our premium item purchasers (items >$25)?

### Business Value
Identifies customers interested in higher-value items for premium product marketing.

### Query
```sql
SELECT customerFName, customerLName 
FROM Customers
JOIN Orders ON Orders.customerID=Customers.customerID
WHERE orderID IN
    (SELECT orderID FROM OrderDetails WHERE productPrice >25);
```

### Results
| customerFName | customerLName |
|--------------|---------------|
| Jacob        | Sehl         |
| Cody         | Wood         |

### Insights
- Two customers identified as premium purchasers
- Potential for luxury item marketing
- Opportunity for high-end product recommendations
- Could indicate market for premium product lines

## Query 7: Organic Product Shopping List Analysis

### Business Question
What organic products are customers interested in?

### Business Value
Helps understand organic product demand for inventory management.

### Query
```sql
SELECT listName, productName, ShoppingList.listID 
FROM ShoppingList
JOIN shoppingItems ON ShoppingList.listID = shoppingItems.listID
JOIN Products ON shoppingItems.productID = Products.productID
WHERE productName REGEXP "^organic";
```

### Results
| listName  | productName      | listID |
|-----------|------------------|---------|
| Groceries | Organic tomatoes | 801     |
| Groceries | Organic potatoes | 801     |
| Groceries | Organic cilantro | 802     |
| Groceries | Organic eggs     | 802     |
| Groceries | Organic milk     | 802     |

### Insights
- Strong interest in organic produce and dairy
- Two distinct shopping lists containing organic items
- Variety of organic products being purchased
- Potential for organic product line expansion

## Query 8: High-Value Coupon Analysis

### Business Question
What are our highest-value coupon offerings?

### Business Value
Tracks high-value promotions for budget and effectiveness analysis.

### Query
```sql
SELECT couponCode, couponRate 
FROM Coupons
WHERE couponRate >10.00
ORDER BY couponRate DESC;
```

### Results
| couponCode | couponRate |
|------------|------------|
| pqr123     | 25.00      |
| jkl123     | 20.00      |

### Insights
- Two high-value coupons identified
- Significant discount values of $20+ 
- Opportunity to track redemption rates
- Could inform future promotion strategies

## Query 9: Customer Age Analysis

### Business Question
Who is our longest-standing customer?

### Business Value
Identifies loyal customers for recognition and retention programs.

### Query
```sql
SELECT customerFName, customerLName, customerDOB 
FROM Customers
WHERE customerDOB = (SELECT MIN(customerDOB) FROM Customers);
```

### Results
| customerFName | customerLName | customerDOB  |
|--------------|---------------|--------------|
| Engin        | Terzi        | 1600-03-01   |

### Insights
- Oldest customer identified (note: this appears to be test data)
- Opportunity for customer loyalty recognition
- Could inform customer retention strategies
- Potential for customer milestone celebrations

## Query 10: Shipped Orders Analysis

### Business Question
Which customers have received their orders?

### Business Value
Tracks successful order completions and delivery performance.

### Query
```sql
SELECT customerFName, customerLName 
FROM Customers
JOIN Orders ON Customers.customerID = Orders.customerID
WHERE orderStatus = "Shipped";
```

### Results
| customerFName | customerLName |
|--------------|---------------|
| Vaughn       | McCavey      |
| Jacob        | Sehl         |

### Insights
- Two customers with successfully shipped orders
- Could indicate delivery performance metrics
- Opportunity for post-delivery feedback
- Potential for customer satisfaction follow-up