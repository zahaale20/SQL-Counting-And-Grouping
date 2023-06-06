-- Lab 6 - BAKERY
-- azaharia@calpoly.edu
-- Jun 1, 2023

-- Query 1
--  Report all customers who made more than 10 different purchases (unique receipts)  from the bakery. Report first and last name of the customer, 
-- sort output in alphabetical order by last name.

SELECT c.FirstName, c.LastName, COUNT(DISTINCT r1.RNumber) AS Purchases
FROM customers AS c, receipts AS r1, receipts AS r2
WHERE c.CId = r1.Customer
  AND c.CId = r2.Customer
  AND r1.RNumber <> r2.RNumber
GROUP BY c.FirstName, c.LastName
HAVING COUNT(DISTINCT r1.RNumber) > 10
ORDER BY c.LastName;

-- Query 2
-- For each flavor of cookie report total number of times it was purchased (count the actual cookies, not receipts), 
-- number of unique customers who purchased the cookie, and the total sales amount. Sort output in alphabetical order by cookie flavor.

SELECT g.Flavor AS Flavor, COUNT(i.Item) AS Purchases, COUNT(DISTINCT r.Customer) AS Customers, SUM(g.Price) AS SalesAmount
FROM goods g, items i, receipts r
WHERE g.Food = 'Cookie'
  AND g.GId = i.Item
  AND i.Receipt = r.RNumber
GROUP BY g.Flavor
ORDER BY g.Flavor ASC;

-- Query 3
--  For each day of the week of October 15 (Monday to Sunday) report the total
-- number of purchases (receipts), the total number of pastries purchased and the overall daily revenue.  Report results in chronological order and include both the day of the week  and the date.   (Note: the total amounts paid may look
-- strange, if you are using floating points for prices.)

SELECT
    CASE WEEKDAY(r.SaleDate)
        WHEN 0 THEN 'Monday'
        WHEN 1 THEN 'Tuesday'
        WHEN 2 THEN 'Wednesday'
        WHEN 3 THEN 'Thursday'
        WHEN 4 THEN 'Friday'
        WHEN 5 THEN 'Saturday'
        WHEN 6 THEN 'Sunday'
    END AS Day,
    r.SaleDate AS SaleDate,
    COUNT(DISTINCT r.RNumber) AS Purchases,
    COUNT(i.Item) AS Items,
    SUM(g.Price) AS Revenue
FROM receipts r, items i, goods g
WHERE r.RNumber = i.Receipt
    AND i.Item = g.GId
    AND r.SaleDate >= '2007-10-15'
    AND r.SaleDate < '2007-10-22'
GROUP BY Day, SaleDate
ORDER BY SaleDate;

-- Query 4
-- Find all purchases that totaled $25 or more. Report the customer who made the purchase, the receipt number, and the total amount of the purchase. 
-- Sort output in descending order by the total amount.

SELECT c.FirstName, c.LastName, r.RNumber, SUM(g.Price) AS Total
FROM customers c, receipts r, items i, goods g
WHERE c.CId = r.Customer
    AND r.RNumber = i.Receipt
    AND i.Item = g.GId
GROUP BY c.FirstName, c.LastName, r.RNumber
HAVING SUM(g.Price) >= 25
ORDER BY Total DESC;


-- Query 5
-- For each customer, count the number of times they purchased exactly five items from the bakery on a single receipt. Report last name, first name, and the number of five-item purchases sorted in chronological order by the last purchase made, breaking the ties in alphabetical order of the last name. (note: if you study the database carefully, you will discover that
-- the maximum number of items purchased on the same receipt in is five).
SELECT c.FirstName AS firstname, c.LastName AS lastname, COUNT(r.RNumber) AS Num
FROM customers c,receipts r, items i1, items i2, items i3, items i4, items i5
WHERE c.CId = r.Customer
    AND r.RNumber = i1.Receipt
    AND r.RNumber = i2.Receipt
    AND r.RNumber = i3.Receipt
    AND r.RNumber = i4.Receipt
    AND r.RNumber = i5.Receipt
    AND i1.Ordinal = 1
    AND i2.Ordinal = 2
    AND i3.Ordinal = 3
    AND i4.Ordinal = 4
    AND i5.Ordinal = 5
GROUP BY c.LastName, c.FirstName
ORDER BY MAX(r.SaleDate), c.LastName ASC;


