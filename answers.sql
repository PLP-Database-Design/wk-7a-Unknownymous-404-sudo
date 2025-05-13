-- Question 1

WITH RECURSIVE ProductSplit AS (
    SELECT
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Products, ',', 1)) AS Product,
        SUBSTRING(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2) AS Remaining
    FROM ProductDetail

    UNION ALL

    SELECT
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Remaining, ',', 1)) AS Product,
        SUBSTRING(Remaining, LENGTH(SUBSTRING_INDEX(Remaining, ',', 1)) + 2)
    FROM ProductSplit
    WHERE Remaining != ''
)

SELECT OrderID, CustomerName, Product
FROM ProductSplit
ORDER BY OrderID;

-- Question 2
-- split the tables into two
-- Orders Table which contains OrderID and CustomerName;

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Order Items Table which contains OrderID, Product and Quantity;

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;



