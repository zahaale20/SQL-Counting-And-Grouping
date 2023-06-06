-- Lab 6 - STUDENTS
-- azaharia@calpoly.edu
-- Jun 1, 2023

-- Query 1
--  Report the names of teachers who have two or three
-- students in their classes. Sort output in alphabetical order
-- by teacher's last name.

SELECT t.Last, t.First
FROM teachers t, list l
WHERE t.Classroom = l.Classroom
GROUP BY t.Classroom
HAVING COUNT(*) = 2 OR COUNT(*) = 3
ORDER BY t.Last;

-- Query 2
-- For each grade, report, in a single row, all classrooms this grade is taught in
-- (classrooms should be in ascending order).

-- output is correct, however, GROUP_CONCAT doesn't add the extra space like in the expected result
SELECT Grade, GROUP_CONCAT(DISTINCT Classroom ORDER BY Classroom) AS Classrooms
FROM list
GROUP BY Grade;

-- Query 3
-- For each kindergarden classroom, report the total number of students. Sort
-- output in the descending order by the number of students.

SELECT Classroom, COUNT(*) AS Students
FROM list
WHERE Grade = 'K'
GROUP BY Classroom
ORDER BY Students DESC;

-- Query 4
-- For each first grade classroom, report the student (last name) who is the
-- first (alphabetically) on the class roster. Sort output by classroom.

SELECT Classroom, MIN(LastName)
FROM list
WHERE grade = 1
GROUP BY Classroom
ORDER BY Classroom;


