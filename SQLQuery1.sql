

--What grades are stored in the database?

SELECT DISTINCT *
FROM Grade;

--What emotions may be associated with a poem?

SELECT *
FROM Emotion;

--How many poems are in the database?

SELECT COUNT(Id) AS 'Number of Poems'
FROM Poem;

--Sort authors alphabetically by name. What are the names of the top 76 authors?

SELECT TOP 76 * 
FROM Author
ORDER BY Name;

--Starting with the above query, add the grade of each of the authors.

SELECT TOP 76 * 
FROM Author a
LEFT JOIN Grade g ON g.Id = a.GradeId
ORDER BY a.Name;

--Starting with the above query, add the recorded gender of each of the authors.

SELECT TOP 76 * 
FROM Author a
LEFT JOIN Grade g ON g.Id = a.GradeId
LEFT JOIN Gender gen ON gen.Id = a.GenderId
ORDER BY a.Name;

--What is the total number of words in all poems in the database?

SELECT SUM(WordCount) AS 'All the Words'
FROM Poem;

--Which poem has the fewest characters?

SELECT TOP 1 *
FROM Poem
ORDER BY CharCount;

--How many authors are in the third grade?

SELECT COUNT(a.Id) AS 'Number of 3 graders'
FROM Author a
LEFT JOIN Grade g ON g.Id = a.GradeId
WHERE g.Name = '3rd Grade';

--How many total authors are in the first through third grades?
SELECT COUNT(a.Id) AS 'Students in 1st through 3rd'
FROM Author a
LEFT JOIN Grade g ON g.Id = a.GradeId
WHERE g.Name = '3rd Grade' OR g.Name = '1st Grade' OR g.Name = '2nd Grade';

--What is the total number of poems written by fourth graders?
SELECT COUNT(p.Id) as 'Fourth Grade Poems'
FROM Poem p
LEFT JOIN Author a ON a.Id = p.AuthorId
LEFT JOIN Grade g ON g.Id = a.GradeId
Where g.Name = '4th Grade';

--How many poems are there per grade?
SELECT COUNT(p.Id) AS 'Poems per Grade', g.Name
FROM Poem p
LEFT JOIN Author a ON a.Id = p.AuthorId
LEFT JOIN Grade g ON g.Id = a.GradeId
GROUP BY g.Id, g.Name;

--How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT COUNT(a.Id) AS 'Authors per grade', g.Name
FROM AUTHOR a
LEFT JOIN Grade g ON g.Id = a.GradeId
GROUP BY g.Id, g.Name
ORDER BY g.Id;

--What is the title of the poem that has the most words?
SELECT TOP 1 Title
FROM Poem
ORDER BY WordCount DESC;

--Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT COUNT(p.Id) AS 'Poems per Author', a.Name
FROM Author a
JOIN Poem p ON p.AuthorId = a.Id
Group By a.Id, a.Name
ORDER BY 'Poems per Author' DESC;

--How many poems have an emotion of sadness?
SELECT COUNT(p.Id) AS 'Number of Sad Poems'
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
WHERE e.Name = 'Sadness';

--How many poems are not associated with any emotion?
SELECT COUNT(p.Id) AS 'Number of Emotionless Poems'
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
WHERE e.Name IS NULL;

--Which emotion is associated with the least number of poems?
SELECT COUNT(p.Id) AS 'Poems by Emotion', e.Name
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
GROUP BY e.Id, e.Name
ORDER BY 'Poems by Emotion';


--Which grade has the largest number of poems with an emotion of joy?

SELECT COUNT(p.Id) AS 'Joyful Poems by Grade', g.Name, e.Name
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
LEFT JOIN Author a ON a.Id = p.AuthorId
LEFT JOIN Grade g ON g.Id = a.GradeId
GROUP BY g.Id, g.Name, e.Name
HAVING e.Name = 'Joy';

SELECT TOP 1 COUNT(p.Id) AS 'JoyPoemsByGrade', g.Name, e.Name /*Group answer*/
FROM Poem as p
	LEFT JOIN PoemEmotion as pe ON pe.PoemId = p.Id
	LEFT JOIN Emotion as e ON e.Id = pe.EmotionId
	LEFT JOIN Author as a ON a.Id = p.AuthorId
	LEFT JOIN Grade as g ON g.Id = a.GradeId
GROUP BY g.Id, g.Name, e.Name 
HAVING e.Name LIKE 'Joy'
ORDER BY JoyPoemsByGrade DESC;


--Which gender has the least number of poems with an emotion of fear?
SELECT COUNT(p.Id) AS 'Poems by Gender', e.Name, g.Name
FROM Poem p
LEFT JOIN PoemEmotion as pe ON pe.PoemId = p.Id
LEFT JOIN Emotion as e ON e.Id = pe.EmotionId
LEFT JOIN Author a ON a.Id = p.AuthorId
LEFT JOIN Gender g ON g.Id = a.GenderId
GROUP BY g.Id, g.Name, e.Name
HAVING e.Name = 'Fear'
ORDER BY 'Poems by Gender';

/*Lightning exercise*/
SELECT * 
FROM Author
WHERE Name LIKE '%Alice%';

SELECT COUNT(Id) AS 'Poems include horse'
FROM Poem
WHERE Text LIKE '%horse%';