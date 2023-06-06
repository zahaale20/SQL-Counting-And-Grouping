-- Lab 6 - KATZENJAMMER
-- azaharia@calpoly.edu
-- Jun 1, 2023

-- Query 1
-- For each performer (use first name) report how many times she sang lead vocals on a song. Sort output in descending order by the number of leads.

SELECT b.FirstName, COUNT(*) AS '# Leads'
FROM Band b, Vocals v
WHERE b.Id = v.Bandmate
    AND v.VocalType = 'lead'
GROUP BY b.FirstName
ORDER BY COUNT(*) DESC;

-- Query 2
-- Report how many different unique instruments  each performer plays on songs from  'Rockland'. Sort the output by the first name of the performers.

SELECT Band.Firstname, COUNT(DISTINCT Instruments.Instrument) AS '# Instruments'
FROM Instruments, Band, Songs, Tracklists, Albums
WHERE Albums.Title = 'Rockland'
    AND Instruments.Bandmate = Band.Id
    AND Instruments.Song = Songs.SongId
    AND Songs.SongId = Tracklists.Song
    AND Tracklists.Album = Albums.AId
GROUP BY Band.Firstname
ORDER BY Band.Firstname;

-- Query 3
-- Report the number of times Solveig stood at each stage position when
-- performing live. Sort output in ascending order of the number of times
-- she performed in each position.

SELECT p.StagePosition, COUNT(*) AS Performed
FROM Performance p, Band b
WHERE b.Firstname = 'Solveig'
    AND p.Bandmate = b.Id
GROUP BY p.StagePosition
ORDER BY Performed ASC;

-- Query 4
-- Report how many times each of the remaining peformers played the bass balalaika on the songs where Anne-Marit was positioned on the left side of the stage. Sort output alphabetically by the name of the performer.

SELECT b.Firstname, COUNT(*) AS Bass
FROM Instruments i, Band b, Songs s, Performance p, Band AS b2
WHERE i.Bandmate = b.Id
  AND i.Song = s.SongId
  AND s.SongId = p.Song
  AND p.Bandmate = b2.Id
  AND i.Instrument = 'Bass Balalaika'
  AND p.StagePosition = 'Left'
  AND b2.Firstname = 'Anne-Marit'
GROUP BY b.Firstname
ORDER BY b.Firstname;

-- Query 5
-- Report all instruments (in alphabetical order) that were played by all four members of Katzenjammer.

SELECT i.Instrument
FROM Instruments i, Band b
WHERE i.Bandmate = b.Id
  AND b.Firstname IN ('Anne-Marit', 'Marianne', 'Turid', 'Solveig')
GROUP BY i.Instrument
HAVING COUNT(DISTINCT b.Firstname) = 4
ORDER BY i.Instrument;

-- Query 6
-- For each performer, report the number of times they played more than one instrument on the same song. Sort output in alphabetical order by first name of the  performer. (Yes, you can do it without using nested queries!).

SELECT b.Firstname, COUNT(DISTINCT i1.Song) AS SongCount
FROM Band b, Instruments i1, Instruments i2
WHERE b.Id = i1.Bandmate
    AND i1.Song = i2.Song
    AND i1.Bandmate = i2.Bandmate
    AND i1.Instrument <> i2.Instrument
GROUP BY b.Id, b.Firstname
HAVING SongCount >= 1
ORDER BY b.Firstname ASC;


