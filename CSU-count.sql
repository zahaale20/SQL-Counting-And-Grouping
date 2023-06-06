-- Lab 6 - CSU
-- azaharia@calpoly.edu
-- Jun 1, 2023

-- Query 1
--  For each campus that averaged more than $2300 in fees between 2000 and 2004 (inclusive),  report the average FTE undergraduate 
-- enrollment over those years. Sort output in descending order of average enrollment.

SELECT c.Campus, AVG(e.FTE) AS AvgEnrollment
FROM campuses AS c
JOIN fees AS f ON c.Id = f.CampusId
JOIN enrollments AS e ON c.Id = e.CampusId AND f.Year = e.Year
WHERE f.Year BETWEEN 2000 AND 2004
GROUP BY c.Campus
HAVING AVG(f.fee) > 2300
ORDER BY AvgEnrollment DESC;

-- Query 2
--  For each campus for which data exists for more than 60 years, report the average, the maximum and the minimum enrollment (for all years), 
-- and the standard deviation. Sort your output in descending order by average enrollment.

SELECT c.Campus, MIN(e.Enrolled) AS MinEnrollment, AVG(e.Enrolled) AS AvgEnrollment, MAX(e.Enrolled) AS MaxEnrollment,  STDDEV(e.Enrolled) AS EnrollmentSTD
FROM campuses AS c
JOIN enrollments AS e ON c.Id = e.CampusId
GROUP BY c.Campus
HAVING COUNT(DISTINCT e.Year) > 60
ORDER BY AvgEnrollment DESC;

-- Query 3
--  For each campus in LA and Orange counties
-- compute the overall revenue received from students starting the year 2001 (i.e., in the 21st century).
-- Use "warm body" enrollment numbers (not FTEs) for your computations\footnote{The number you 
-- compute technically is not quite the full revenue, but it's a good approximation.}. Sort output in descending order by the revenue.

SELECT c.Campus, SUM(e.Enrolled * f.fee) AS Revenue
FROM campuses c, enrollments e, fees f
WHERE c.Id = e.CampusId 
    AND c.County IN ('Los Angeles', 'Orange') 
    AND e.Year >= 2001
    AND c.Id = f.CampusId
    AND e.Year = f.Year
GROUP BY c.Campus
ORDER BY Revenue DESC;

-- Query 4
-- For each campus that had more than 20000 enrolled students in 2004
-- report the number of disciplines for which the campus had non-zero graduate enrollment. Sort the output in alphabetical order by the name
-- of the campus. (This query should exclude campuses that had no graduate enrollment at all).

SELECT c.Campus, COUNT(DISTINCT de.Discipline) AS Disciplines
FROM campuses c, enrollments e, discEnr de
WHERE c.Id = e.CampusId 
    AND e.Year = 2004 
    AND e.Enrolled > 20000 
    AND de.Gr > 0
    AND c.Id = de.CampusId 
    AND e.Year = de.Year
GROUP BY c.Campus
ORDER BY c.Campus ASC;


