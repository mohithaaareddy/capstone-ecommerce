/*1. What is the maximum quantity of any order ID in the data? 
 Also, determine the number of orders placed which have this maximum quantity.(2 marks)*/
SELECT MAX(Quantity) AS Max_quantity, COUNT(Quantity) AS No_of_max_orders
FROM TR_OrderDetails
WHERE Quantity=(SELECT MAX(Quantity)
FROM TR_OrderDetails);

/*2. Find the number of unique products that are sold. (2 marks)*/
SELECT COUNT(DISTINCT(ProductID)) AS Unique_Products
FROM TR_OrderDetails;

/*3. List the different types of “Chair” that are sold by using product table (Hint:TR_Products) (2marks)*/
SELECT ProductName
FROM TR_Products
WHERE ProductName LIKE '%chair%';

/*4. What is the average price of each of these chair listed in the output of previous question? (2 marks)*/
SELECT ProductName, AVG(Price)
FROM TR_Products
WHERE ProductName LIKE '%chair'
GROUP BY ProductID;

/*5. Find the details of the Properties where the state names are more than 10 characters in length? (2 marks)*/
SELECT PropertyState, Length(PropertyState)
FROM TR_PropertyInfo
WHERE Length(PropertyState)>10;

/*6. Find the details of the Properties where the second character of the city name is “e”.(2 marks)*/
SELECT *
FROM TR_PropertyInfo
WHERE PropertyCity LIKE '_e%';

/*7. Find the minimum and maximum prices for products in the “Office Supplies” category (2 marks)*/
SELECT ProductName, MAX(Price), MIN(Price)
FROM TR_Products
WHERE ProductCategory='Office Supplies'
GROUP BY ProductName;

/*9. List the different states in which sales are made and count how many orders are there in each of the states? (Hint: Consider order details as the primary table) (2 marks)*/
SELECT PropertyState, COUNT(OrderID) AS No_of_Orders
FROM TR_PropertyInfo
INNER JOIN TR_OrderDetails ON
TR_PropertyInfo.PropertyID=TR_OrderDetails.PropertyID
GROUP BY PropertyState;

/*10. Find the average price of items sold in each Product Category and sort it in a decreasing order. (2 marks)*/
SELECT ProductCategory, AVG(Price)
FROM TR_Products
GROUP BY ProductCategory
ORDER BY AVG(Price) DESC;

/*11. Find the Product Category that sells the least number of products? Something for the management to focus on. (2 marks)*/
SELECT ProductCategory, SUM(Quantity) AS No_of_quantities
FROM TR_Products
INNER JOIN TR_OrderDetails ON
TR_Products.ProductID = TR_OrderDetails.ProductID
GROUP BY ProductCategory
ORDER BY SUM(Quantity) ASC
Limit 1;

/*13. Select the Product categories where the average price is more than 25 (2 marks)*/
SELECT ProductCategory, AVG(Price) AS avg
FROM TR_Products
GROUP BY ProductCategory
HAVING AVG(Price)>25;

/*14. Find the top 5 products IDs that sold the maximum quantities? (2 marks)*/
SELECT ProductID, SUM(Quantity) AS No_of_max_quantities
FROM TR_OrderDetails
GROUP BY ProductID
ORDER BY SUM(Quantity) DESC
Limit 5;

/*15. For the above question, print the product names instead of Product IDs. (2 marks)*/
SELECT  ProductName, SUM(Quantity) AS No_of_max_quantities
FROM TR_OrderDetails
INNER JOIN TR_Products ON
TR_OrderDetails.ProductID=TR_Products.ProductID
GROUP BY ProductName
ORDER BY SUM(Quantity) DESC
Limit 5;

/*17. Determine the 5 products that give the overall minimum sales? (Hint: Sales = Quantity * Price) (2 marks)*/
SELECT  ProductName, (SUM(Quantity)*Price) AS Sales
FROM TR_OrderDetails
INNER JOIN TR_Products ON
TR_OrderDetails.ProductID=TR_Products.ProductID
GROUP BY ProductName
ORDER BY (SUM(Quantity)*Price) ASC
Limit 5;

/*18. Repeat the above query for the City of “Orlando”. (2 marks)*/
SELECT  ProductName, (SUM(Quantity)*Price) AS Sales
FROM TR_Products
INNER JOIN TR_OrderDetails ON
TR_Products.ProductID=TR_OrderDetails.ProductID
INNER JOIN TR_PropertyInfo ON
TR_PropertyInfo.PropertyID=TR_OrderDetails.PropertyID
WHERE PropertyCity="Orlando"
GROUP BY ProductName
ORDER BY (SUM(Quantity)*Price) ASC
Limit 5;

/*20. Which are the cities that belong to the same states? (2 marks)*/
SELECT PropertyCity, PropertyState
FROM TR_PropertyInfo
WHERE PropertyState IN (SELECT PropertyState
FROM TR_PropertyInfo
GROUP BY PropertyState
HAVING COUNT(PropertyState)>1);
