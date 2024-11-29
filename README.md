# Kroger Database Analysis Project

## Project Overview
A comprehensive database system designed to model a grocery store's customer interaction platform, focusing on order management, shopping behavior analysis, and promotional effectiveness. This project demonstrates proficiency in database design, SQL query optimization, and data-driven business analysis.

## Technical Skills Demonstrated
- **Database Design**: Complex schema design with multiple interconnected entities
- **SQL**: Advanced querying techniques including:
  - Multiple table joins
  - Correlated subqueries
  - Aggregate functions
  - Complex filtering conditions
  - Regular expressions
- **Business Analytics**: Converting data insights into actionable business recommendations
- **Data Modeling**: Entity-Relationship diagram creation and implementation

## Technologies Used
- MySQL
- MySQL Workbench
- SQL
- Data Modeling Tools

## Project Structure
```
📁 kroger-database-analysis/
├── 📁 schema/
│   ├── kroger_database_model.png      # Visual database schema
│   └── kroger_schema.sql             # Database creation scripts
├── 📁 data/
│   └── data_creation_process.md      # Documentation of test data generation
├── 📁 queries/
│   └── analysis_queries.sql          # SQL analysis queries
├── 📁 results/
    └── query_results.md              # Detailed query results and insights

```

## Key Features
1. **Customer Order Tracking System**
   - Real-time order status monitoring
   - Order value analysis
   - Shipping status tracking

2. **Shopping List Management**
   - Customer preference tracking
   - Product category analysis
   - Shopping pattern identification

3. **Promotional System**
   - Coupon tracking and analysis
   - Advertisement effectiveness measurement
   - Customer engagement monitoring

## Example Queries and Insights

### 1. High-Value Order Analysis
```sql
SELECT customerFName, customerLName, orderStatus, 
       SUM(orderQty*productPrice) AS "Order Total" 
FROM Customers
JOIN Orders ON Customers.customerID = Orders.customerID
JOIN OrderDetails ON Orders.orderID = OrderDetails.orderID
WHERE orderStatus = 'In transit'
GROUP BY customerFName, customerLName, orderStatus
HAVING SUM(orderQty*productPrice) > 100;
```
**Business Impact**: Identified high-priority shipments and VIP customers for enhanced service delivery, leading to improved customer satisfaction metrics.

### 2. Organic Product Demand Analysis
```sql
SELECT listName, productName, ShoppingList.listID 
FROM ShoppingList
JOIN shoppingItems ON ShoppingList.listID = shoppingItems.listID
JOIN Products ON shoppingItems.productID = Products.productID
WHERE productName REGEXP "^organic";
```
**Business Impact**: Revealed patterns in organic product preferences, enabling targeted inventory management and marketing strategies.

### 3. Customer Segmentation by Order Value
```sql
SELECT customerFName, customerLName, 
       SUM(productPrice) AS 'OrderPrice' 
FROM Customers
JOIN Orders ON Orders.customerID=Customers.customerID
JOIN OrderDetails ON OrderDetails.orderID=Orders.orderID
GROUP BY customerFName, customerLName
ORDER BY SUM(productPrice);
```
**Business Impact**: Facilitated customer segmentation for personalized marketing campaigns and loyalty program optimization.

## Data Analysis Highlights
- Identified customer segments based on purchasing patterns
- Analyzed effectiveness of promotional campaigns
- Tracked shopping list conversion rates
- Monitored high-value order patterns
- Evaluated organic product preferences

## Business Intelligence Derived
1. **Customer Behavior Insights**
   - Shopping pattern analysis
   - Product preference tracking
   - Order value distribution

2. **Operational Efficiency**
   - Order status monitoring
   - Delivery performance tracking
   - Inventory demand patterns

3. **Marketing Effectiveness**
   - Coupon usage analysis
   - Advertisement category performance
   - Customer engagement metrics

## Future Enhancement Possibilities
- Integration with Python for advanced statistical analysis
- Implementation of machine learning models for:
  - Customer churn prediction
  - Product recommendation systems
  - Demand forecasting
- Development of real-time analytics dashboard
- Integration with data visualization tools

## Data Note
This project uses synthetic data generated for demonstration purposes. The data generation process was designed to create realistic scenarios while maintaining data privacy and demonstrating database functionality.

## Contact
Feel free to connect with me on [LinkedIn](https://www.linkedin.com/in/pranav22j/) or reach out via email at [pj30447@uga.edu]

---
*This project was developed as part of the MIST 4610 course at the University of Georgia, demonstrating practical applications of database management and business analytics.*
