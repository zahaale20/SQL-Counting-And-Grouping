-- Lab 6 - MARATHON
-- azaharia@calpoly.edu
-- Jun 1, 2023

-- Query 1
-- For each sex/age group, report total number of runners in the group, the overall
-- place of the best runner in the group and the overall place of the worst runner in the group.
-- Output result sorted by age group and sorted by sex (F followed by M)
-- within each age group.

SELECT AgeGroup, Sex, COUNT(AgeGroup) AS Total, MIN(Place), MAX(Place)
FROM marathon
GROUP BY AgeGroup, Sex
ORDER By AgeGroup, Sex;

-- Query 2
-- Report the total number of sex/age groups for which both the first and the
-- second place runners (within the group) hail from the same state.

SELECT COUNT(DISTINCT m1.AgeGroup)
FROM marathon m1, marathon m2
WHERE (m1.GroupPlace = 2 OR m1.GroupPlace = 1)
    AND (m2.GroupPlace = 1 OR m2.GroupPlace = 2)
    AND m1.AgeGroup = m2.AgeGroup
    AND m1.Sex = m2.Sex
    AND m1.BibNumber != m2.BibNumber
    AND m1.State = m2.State

-- Query 3
-- For each full minute, report the total number of runners whose pace was between that number of minutes and the next. (That is, how many runners ran the marathon at a pace between 5 and 6 mins, how many - at a pace between 6 and 7 mins, and so on).

SELECT LPAD(FLOOR(TIME_TO_SEC(Pace) / 60), 2, '0') AS PaceMinutes, COUNT(*) AS TotalRunners
FROM marathon
GROUP BY LPAD(FLOOR(TIME_TO_SEC(Pace) / 60), 2, '0')

-- Query 4
--  For each state, whose representatives participated in the marathon report the number of runners from it who finished in top 10 in their sex-age group (if a state did not have runners in top 10s, do not output information about the state). Output in descending order by the computed number.
SELECT State, COUNT(*) AS TopTen
FROM marathon
WHERE GroupPlace <= 10
GROUP BY State
ORDER BY TopTen DESC;


