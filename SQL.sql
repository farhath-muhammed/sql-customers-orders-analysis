CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50),
    JoinDate DATE
);

CREATE TABLE Products (
    ProductID VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID VARCHAR(10),
    OrderDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers (CustomerID, CustomerName, City, JoinDate) VALUES
(101, 'Aarav', 'Bangalore', '2023-01-15'),
(102, 'Diya', 'Chennai', '2023-03-22'),
(103, 'Rahul', 'Mumbai', '2022-11-05'),
(104, 'Sneha', 'Hyderabad', '2024-02-10'),
(105, 'Arjun', 'Delhi', '2023-08-12');

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
('P101', 'Laptop', 'Electronics', 45000),
('P102', 'Mouse', 'Accessories', 1200),
('P103', 'Keyboard', 'Accessories', 800),
('P104', 'Monitor', 'Electronics', 25000),
('P105', 'Printer', 'Office', 1500);

INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate, Amount) VALUES
(1001, 101, 'P101', '2024-01-12', 45000),
(1002, 102, 'P102', '2024-02-15', 1200),
(1003, 101, 'P103', '2024-03-10', 800),
(1004, 103, 'P104', '2024-04-08', 25000),
(1005, 104, 'P105', '2024-05-01', 1500);

SELECT 
c.CustomerName,
p.ProductName,
o.OrderDate,
O.Amount
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID;


SELECT 
c.CustomerName,
p.ProductName,
p.Category,
o.OrderDate
FROM Orders o
INNER JOIN  Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE p.Category = 'Electronics';


SELECT 
c.CustomerName,
p.ProductName,
p.Price
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID;

SELECT 
c.CustomerName,
c.CustomerID,
SUM(o.Amount) AS Total_Amount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName;

SELECT 
c.CustomerID, 
c.CustomerName, 
c.City, 
o.OrderID, 
o.Amount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

SELECT 
c.CustomerName, 
o.OrderDate, 
o.Amount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

SELECT 
c.CustomerID, 
c.CustomerName, 
o.OrderID, 
o.ProductID, 
o.OrderDate, 
o.Amount
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;

SELECT 
o.OrderID, 
o.CustomerID, 
o.ProductID, 
o.OrderDate, 
o.Amount
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL;


CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(50),
ManagerID INT,
FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Employees (EmployeeID, EmployeeName, ManagerID)
VALUES
(101, 'Aarav', NULL),
(102, 'Diya', 101),
(103, 'Rahul', 101),
(104, 'Sneha', 102),
(105, 'Arjun', 103);

SELECT 
e.EmployeeName AS Employee,
m.EmployeeName AS Manager
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;

SELECT 
e.EmployeeName
FROM Employees e
INNER JOIN Employees m ON e.ManagerID = m.EmployeeID
WHERE m.EmployeeName = 'Aarav';

SELECT 
m.EmployeeName AS Manager_Name, 
COUNT(e.EmployeeID) AS No_of_People
FROM Employees e
INNER JOIN Employees m ON e.ManagerID = m.EmployeeID
GROUP BY m.EmployeeID, m.EmployeeName
HAVING COUNT(e.EmployeeID) > 1;

SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
WHERE c.CustomerID IN (
SELECT CustomerID 
FROM Orders 
WHERE Amount > (SELECT AVG(Amount) FROM Orders)
);

SELECT *
FROM Products
WHERE Price = (SELECT MAX(Price) FROM Products);

SELECT CustomerID, CustomerName
FROM Customers
WHERE CustomerID IN (SELECT DISTINCT CustomerID FROM Orders);

SELECT *
FROM Products
WHERE ProductID NOT IN (
SELECT DISTINCT ProductID 
FROM Orders 
WHERE ProductID IS NOT NULL
);

SELECT CustomerID, CustomerName
FROM Customers
WHERE CustomerID IN (
SELECT CustomerID
FROM Orders
GROUP BY CustomerID
HAVING SUM(Amount) > 30000
);

SELECT MAX(Price) AS SecondHighestPrice
FROM Products
WHERE Price < (SELECT MAX(Price) FROM Products);

SELECT DISTINCT c.CustomerName
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.ProductID IN (
SELECT ProductID 
FROM Products 
WHERE Price = (SELECT MAX(Price) FROM Products)
);

SELECT *
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

SELECT CURRENT_DATE() AS TodaysDate;

SELECT NOW() AS CurrentDateTime;

SELECT * 
FROM Orders 
WHERE EXTRACT(YEAR FROM OrderDate) = 2024;

SELECT * 
FROM Customers 
WHERE JoinDate > '2023-01-01';

SELECT OrderID, 
MONTH(OrderDate) AS OrderMonth 
FROM Orders;

SELECT CustomerID, 
YEAR(JoinDate) AS JoinYear 
FROM Customers;

SELECT CustomerName, 
DATEDIFF(CURRENT_DATE(), JoinDate) 
AS Days_Since_Join 
FROM Customers;

SELECT * 
FROM Orders 
WHERE OrderDate >= '2024-04-01' AND OrderDate <= '2024-04-30';

SELECT * FROM Customers 
WHERE YEAR(JoinDate) = YEAR(CURRENT_DATE());

SELECT CustomerName, 
PERIOD_DIFF(DATE_FORMAT(CURRENT_DATE(), '%Y%m'), 
DATE_FORMAT(JoinDate, '%Y%m')) AS MonthsRegistered 
FROM Customers;

CREATE INDEX idx_customers_customername 
ON Customers (CustomerName);

CREATE INDEX idx_orders_cust_date 
ON Orders (CustomerID, OrderDate);

ALTER TABLE Customers 
DROP INDEX idx_customers_customername;

SELECT 
c.CustomerName, 
p.ProductName, 
o.OrderDate, 
o.Amount
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID;

SELECT 
c.CustomerID, 
c.CustomerName
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

SELECT 
c.CustomerName, 
p.ProductName, 
p.Category, 
o.Amount
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE p.Category = 'Electronics';

SELECT 
c.CustomerName, 
SUM(o.Amount) AS TotalSpent
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalSpent DESC
LIMIT 1; 

SELECT 
p.ProductID, 
p.ProductName, 
p.Category, 
p.Price
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL;

SELECT *
FROM Orders
WHERE OrderDate >= '2024-01-01' AND OrderDate <= '2024-12-31';

SELECT 
CustomerName, 
DATEDIFF(CURRENT_DATE(), 
JoinDate) AS DaysRegistered 
FROM Customers;

SELECT *
FROM Customers
WHERE JoinDate > '2023-01-01';

CREATE INDEX idx_orders_customerid 
ON Orders (CustomerID);