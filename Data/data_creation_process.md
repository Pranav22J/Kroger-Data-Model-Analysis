# Data Creation Process Documentation

## Overview
This document outlines the process of creating synthetic test data for the Kroger database system using MySQL Workbench's data insertion features. The data was designed to demonstrate realistic customer behaviors, order patterns, and promotional activities while maintaining data consistency across tables.

## Database Tables and Sample Data

### 1. Customers Table
**Business Context**: Stores essential customer information for order processing and personalization.
```
Screenshot: ![Customers Table Data](images/customer_table.png)
```
**Data Structure**:
- customerID (Primary Key)
- customerFName
- customerLName
- customerEmail
- customerDOB
- storeID (Foreign Key - "Store" table)

**Data Considerations**:
- Created diverse customer profiles
- Ensured realistic age distributions, along with some fun age ranges
- Generated valid email formats pertaining to UGA email format

### 2. Orders Table
**Business Context**: Tracks customer orders and their current status in the fulfillment process.
```
Screenshot: [Orders Table Data](images/orders_table.png)
```
**Sample Data Structure**:
- orderID (Primary Key)
- customerID (Foreign Key - "Customers" table)
- orderDate
- orderStatus
- orderQty

**Data Considerations**:
- Varied order statuses (Shipped, In Transit, Received)
- Realistic order dates
- Consistent customer ID references

### 3. OrderDetails Table
**Business Context**: Contains specific information about items within each order.
```
Screenshot: [Orders Details Table Data](images/OrderDetails%20.png)
```
**Sample Data Structure**:
- orderID (Foreign Key - "Orders" table)
- productID (Foreign Key - "Products" table)
- productPrice

**Data Considerations**:
- Varied order quantities
- Realistic product prices
- Consistent order ID references

### 4. Products Table
**Business Context**: Maintains product information including organic and non-organic items.
```
Screenshot: [Products Table Data](images/products_table.png)
```
**Sample Data Structure**:
- productID (Primary Key)
- productName
- categoryID (Foreign Key - "productCategory" table)
**Data Considerations**:
- Mix of organic and non-organic products
- Various product categories
- Realistic price ranges
- Common grocery store items

### 5. ShoppingList Table
**Business Context**: Tracks customer shopping lists for future purchases.
```
Screenshot: [ShoppingList Table Data](images/shoppinglist_table.png)
```
**Sample Data Structure**:
- listID (Primary Key)
- customerID (Foreign Key - "Customers" table)
- listName

**Data Considerations**:
- Realistic creation dates
- Varied list names

### 6. ShoppingItems Table
**Business Context**: Links products to shopping lists.
```
Screenshot: [ShoppingItems Table Data](images/shoppingitems_table.png)
```
**Sample Data Structure**:
- listID (Foreign Key - "ShoppingList" table)
- productID (Foreign Key - "Products" table)

**Data Considerations**:
- Various quantity amounts
- Mix of products per list
- Consistent list and product references

### 7. WeeklyAd Table
**Business Context**: Manages weekly advertisement campaigns.
```
Screenshot: [WeeklyAd Table Data](images/weeklyad_table.png)
```
**Sample Data Structure**:
- adID (Primary Key)
- startDate
- endDate
- adCategory
- storeID (Foreign Key - "Store" table)

**Data Considerations**:
- Realistic date ranges
- Various ad categories
- Non-overlapping dates
- 6-day duration periods

### 8. Coupons Table
**Business Context**: Tracks available promotional discounts.
```
Screenshot: [Coupons Table Data](images/coupons_table.png)
```
**Sample Data Structure**:
- couponID (Primary Key)
- couponCode
- couponExp
- storeID (Foreign Key - "Store" table)
- couponRate

**Data Considerations**:
- Varied discount amounts
- Future expiration dates
- Unique coupon codes
- Mix of high and low value offers

### 9. Store Table
**Business Context**: Tracks the Kroger store. Useful for future implementations involving multiple stores
```
Screenshot: [Store Table Data](images/store_table.png)
```
**Sample Data Structure**:
- storeID (Primary Key)
- storeName
- storeDesc

**Data Considerations**:
- Single store for consolidated analysis
- Provides area for improvement in future versions of data model by adding more stores

### 10. Product Category Table
**Business Context**: Showcases the categories for each product
```
Screenshot: [Product Category Table Data](images/product_category_table.png)
```
**Sample Data Structures**:
- categoryID
- categoryName
- storeID

**Data Considerations**:
- Multiple categories for the Kroger store
- Diverse product ranges 

## Data Generation Process
1. Started with Customers table to establish base user profiles
2. Created a Store table to establish one specific store
2. Created Orders and OrderDetails with realistic patterns
3. Added Products with varied categories through the Product Category Table and prices
4. Generated Shopping Lists and Items for select customers
5. Created promotional content (WeeklyAd and Coupons)
6. Verified referential integrity across all tables
7. Validated data consistency and relationships

## Data Relationships and Integrity
- Each Order is associated with a valid Customer
- OrderDetails reference valid Orders and Products
- Shopping Lists belong to existing Customers
- Shopping Items reference valid Products and Lists
- All foreign key constraints maintained
- No orphaned records

## Data Usage Notes
- Test data is synthetic and for demonstration only
- Prices and dates are representative but not real
- Customer information is fictional
- Order patterns designed to demonstrate query capabilities
- Promotional data structured to show marketing analysis potential

---
*Note: All data is synthetic and for demonstration only*
