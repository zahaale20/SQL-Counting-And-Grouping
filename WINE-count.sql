-- Lab 6 - WINE
-- azaharia@calpoly.edu
-- Jun 1, 2023

-- Query 1
-- For each wine score value above 88, report average price, the cheapest price
-- and the most expensive price for a bottle of wine 
-- with that score (for all vintage years combined), the total number of wines with
-- that score and the total number of cases produced. Sort by the wine score.

SELECT Score, AVG(Price) AS Avg, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice, COUNT(*) AS TotalWines, SUM(Cases) AS Total
FROM wine
WHERE Score > 88
GROUP BY Score
ORDER BY Score;

-- Query 2
-- For each red grape varietal for which there are more than 10 wines in the database, report the highest price of a case of wine. Report in descending order of the case price.

SELECT g.Grape, MAX(w.Price * 12) AS HighestPrice
FROM wine w, grapes g
WHERE g.Color = 'red'
    and w.Grape = g.Grape
GROUP BY g.Grape
HAVING COUNT(*) > 10
ORDER BY HighestPrice DESC;

-- Query 3
-- Report the list of wineries that produced Zinfandel wines from Sonoma Valley grapes and the names of the Sonoma Valley Zinfandel wines they produce; use one row for each winery, report each unique name of wine exactly once, sort output in alphabetical order by winery name.

SELECT w.Winery, GROUP_CONCAT(DISTINCT w.Name ORDER BY w.Name) AS Names -- group_concat eliminates a space between w.Names, thus the actual output differs from expected output by one space
FROM wine w, appellations a, grapes g
WHERE g.Grape = 'Zinfandel' 
    AND a.Appellation = 'Sonoma Valley'
    AND w.Appellation = a.Appellation
    AND w.Grape = g.Grape
GROUP BY w.Winery
ORDER BY w.Winery;

-- Query 4
-- For each county in the database, report the score of the highest ranked
-- 2009 red wine. Exclude wines that do not have a county of origin ('N/A').
-- Sort output in descending order by the best score.

SELECT a.County, MAX(w.Score) AS Score
FROM wine w, appellations a, grapes g
WHERE g.Color = 'red' 
    AND w.Vintage = 2009 
    AND a.County != 'N/a'
    AND w.Appellation = a.Appellation
    AND w.Grape = g.Grape
GROUP BY a.County
ORDER BY Score DESC;


