-- Lab 6 - AIRLINES
-- azaharia@calpoly.edu
-- Jun 1, 2023

-- Query 1
-- Find all airports with exactly 19 outgoing flights. Report airport code and the
--full name of the airport sorted in alphabetical order by the code.

SELECT a.Code, a.Name
FROM airports a
INNER JOIN flights ON a.Code = flights.Source
GROUP BY a.Code, a.Name
HAVING COUNT(*) = 19
ORDER BY a.Code;

-- Query 2
-- Find the number of airports from which airport LTS can be reached with exactly one transfer. (make sure to exclude LTS itself from the count). Report just the number.

SELECT COUNT(DISTINCT f1.Source)-1 AS NumAirports
FROM flights f1, flights f2
WHERE f1.Destination <> 'LTS' 
    AND f1.Destination = f2.Source
    AND f2.Destination = 'LTS';

-- Query 3
--  Find the number of airports from which airport LTS can be reached with AT MOST  one transfer. (make sure to exclude LTS itself from the count).
-- Report just the number.

SELECT COUNT(DISTINCT f1.Source)-1 AS NumAirports
FROM flights f1, flights f2
WHERE f1.Destination = f2.Source
    AND (f1.Destination= 'LTS' OR f2.Destination = 'LTS');

-- Query 4
-- For each airline report the total number of airports from which it has at least two different outgoing flights. 
-- Report the full name of the airline and the number of airports computed.  Report the results sorted by the number of airports in descending order.

SELECT a.Name, COUNT(DISTINCT ap.Code) AS AirportCount
FROM flights f, airlines a, airports ap
WHERE f.Airline = a.Id
    AND (ap.Code = f.Destination AND f.Destination != f.Source)
GROUP BY a.Name
HAVING COUNT(DISTINCT f.Source) >= 2
ORDER BY AirportCount DESC;
-- wrong --> don't know how to fix this one

