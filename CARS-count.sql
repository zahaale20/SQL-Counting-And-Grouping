-- Lab 6 - CARS
-- azaharia@calpoly.edu
-- Jun 1, 2023

-- Query 1
-- For each European car maker (reported by their short name) report the average
-- mileage per gallon of a car produced by and the corresponding standard deviation (feel free to use STD() for all standard deviations in this lab). 
-- Sort output in ascending order by the BEST MILEAGE of a car produced by the car maker. Exclude any NULL values.

SELECT cm.Maker, AVG(cd.MPG), STD(cd.MPG)
FROM continents co, countries c, carmakers cm, models mo, makes ma, cardata cd
WHERE co.Name = 'europe'
    AND co.id = c.continent
    AND cm.Country = c.Id
    AND mo.Maker = cm.Id
    AND ma.Model = mo.Model
    AND cd.Id = ma.Id
    AND cd.MPG IS NOT NULL
GROUP BY cm.Maker
ORDER BY MAX(cd.MPG) ASC;

-- Query 2
-- For each US car maker (reported by their short name),  report the number of 4-cylinder cars that are lighter than 4000 lbs , with 0 to 60 mph acceleration better than 14 seconds. Sort the output in descending order by the number of cars reported.

SELECT cm.Maker, COUNT(*)
FROM countries c, carmakers cm, models mo, makes ma, cardata cd
WHERE c.Name = 'usa'
    AND cm.Country = c.Id
    AND mo.Maker = cm.Id
    AND ma.Model = mo.Model
    AND cd.Id = ma.Id
    AND cd.Cylinders = 4
  AND cd.Weight < 4000
  AND cd.Accelerate < 14
GROUP BY cm.Maker
ORDER BY COUNT(*) DESC;

-- Query 3
-- For each year in which honda produced more than 2 models, report the  best, the worst and the average gas mileage of  toyota  (this is NOT a typo!) vehicles produced that year. Report results in chronological order. 
-- NOTE: Solve this query WITHOUT using NESTED QUERIES/Subqueries!

-- use this query: 
SELECT cd.Year, MAX(cd2.MPG), MIN(cd2.MPG), AVG(cd2.MPG)
FROM carmakers cm, models mo, makes ma, cardata cd, carmakers cm2, models mo2, makes ma2, cardata cd2
WHERE cm.Maker =  'honda'
    AND mo.Maker = cm.Id
    AND ma.Model = mo.Model
    AND cd.Id = ma.Id
    AND cm2.Maker =  'toyota'
    AND mo2.Maker = cm2.Id
    AND ma2.Model = mo2.Model
    AND cd2.Id = ma2.Id
    AND cd.Year = cd2.Year
GROUP BY cd.Year
HAVING COUNT(mo.Model) > 2 -- I think the issue is here with the counting
ORDER BY cd.Year DESC

-- my attempt to break it down and figure out why I can't get just the 1982 to show up
SELECT cd.Year, COUNT(*)
FROM carmakers cm, models mo, makes ma, cardata cd
WHERE cm.Maker =  'honda'
    AND mo.Maker = cm.Id
    AND ma.Model = mo.Model
    AND cd.Id = ma.Id
GROUP BY cd.Year
HAVING count(*) > 2

SELECT *
FROM carmakers cm2, models mo2, makes ma2, cardata cd2
WHERE cm2.Maker =  'toyota'
    AND mo2.Maker = cm2.Id
    AND ma2.Model = mo2.Model
    AND cd2.Id = ma2.Id
    
SELECT *
FROM carmakers cm, models mo, makes ma, cardata cd, carmakers cm2, models mo2, makes ma2, cardata cd2
WHERE cm.Maker =  'honda'
    AND mo.Maker = cm.Id
    AND ma.Model = mo.Model
    AND cd.Id = ma.Id
    AND cm2.Maker =  'toyota'
    AND mo2.Maker = cm2.Id
    AND ma2.Model = mo2.Model
    AND cd2.Id = ma2.Id
    AND cd.Year = cd2.Year;

-- Query 4
-- For each year from 1975 to 1979 (inclusive) report the number of Japanese 
-- cars with less than 150 horsepowers.  Sort output in chronological order.

SELECT cd.Year, count(*)
FROM countries c, carmakers cm, models mo, makes ma, cardata cd
WHERE c.Name = 'japan'
    AND cm.Country = c.Id
    AND mo.Maker = cm.Id
    AND ma.Model = mo.Model
    AND cd.Id = ma.Id
    AND cd.Horsepower < 150
    AND (cd.Year >= 1975 AND cd.Year <= 1979)
GROUP BY cd.Year;


