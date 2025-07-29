-- 1
SELECT Building
FROM Departments
GROUP BY Building
HAVING SUM(Financing) > 100000;

-- 2
SELECT g.Name
FROM Groups g
JOIN Departments d ON g.DepartmentId = d.Id
JOIN GroupsLectures gl ON g.Id = gl.GroupId
JOIN Lectures l ON gl.LectureId = l.Id
WHERE d.Name = 'Software Development'
  AND g.Year = 5
  AND l.Date BETWEEN '2025-01-01' AND DATEADD(DAY, 6, '2025-01-01')
GROUP BY g.Name
HAVING COUNT(*) > 10;

-- 3
WITH GroupRatings AS (
    SELECT g.Id, g.Name, AVG(s.Rating) AS AvgRating
    FROM Groups g
    JOIN GroupsStudents gs ON g.Id = gs.GroupId
    JOIN Students s ON gs.StudentId = s.Id
    GROUP BY g.Id, g.Name
),
D221Rating AS (
    SELECT AvgRating FROM GroupRatings WHERE Name = 'D221'
)
SELECT gr.Name
FROM GroupRatings gr, D221Rating d
WHERE gr.AvgRating > d.AvgRating;

-- 4
SELECT CONCAT(Name, ' ', Surname) AS FullName
FROM Teachers
WHERE Salary > (SELECT AVG(Salary) FROM Teachers WHERE IsProfessor = 1);

-- 5
SELECT g.Name
FROM Groups g
JOIN GroupsCurators gc ON g.Id = gc.GroupId
GROUP BY g.Name
HAVING COUNT(gc.CuratorId) > 1;

-- 6
WITH FifthYearRatings AS (
    SELECT g.Id, AVG(s.Rating) AS AvgRating
    FROM Groups g
    JOIN GroupsStudents gs ON g.Id = gs.GroupId
    JOIN Students s ON gs.StudentId = s.Id
    WHERE g.Year = 5
    GROUP BY g.Id
),
MinFifthYearRating AS (
    SELECT MIN(AvgRating) AS MinRating FROM FifthYearRatings
),
AllGroupRatings AS (
    SELECT g.Name, AVG(s.Rating) AS AvgRating
    FROM Groups g
    JOIN GroupsStudents gs ON g.Id = gs.GroupId
    JOIN Students s ON gs.StudentId = s.Id
    GROUP BY g.Name
)
SELECT agr.Name
FROM AllGroupRatings agr, MinFifthYearRating mfy
WHERE agr.AvgRating < mfy.MinRating;

-- 7
WITH DeptFinances AS (
    SELECT FacultyId, SUM(Financing) AS TotalFinancing
    FROM Departments
    GROUP BY FacultyId
),
CSDeptFinancing AS (
    SELECT SUM(Financing) AS CSFinancing
    FROM Departments d
    WHERE d.Name = 'Computer Science'
)
SELECT f.Name
FROM Faculties f
JOIN DeptFinances df ON f.Id = df.FacultyId
CROSS JOIN CSDeptFinancing cs
WHERE df.TotalFinancing > cs.CSFinancing;

-- 8
WITH SubjectLectureCounts AS (
    SELECT SubjectId, COUNT(*) AS LectureCount
    FROM Lectures
    GROUP BY SubjectId
),
MaxLectureCount AS (
    SELECT MAX(LectureCount) AS MaxCount FROM SubjectLectureCounts
),
TopSubjects AS (
    SELECT SubjectId
    FROM SubjectLectureCounts
    WHERE LectureCount = (SELECT MaxCount FROM MaxLectureCount)
)
SELECT sub.Name AS SubjectName, CONCAT(t.Name, ' ', t.Surname) AS TeacherFullName, COUNT(*) AS LectureCount
FROM Lectures l
JOIN Teachers t ON l.TeacherId = t.Id
JOIN Subjects sub ON l.SubjectId = sub.Id
WHERE l.SubjectId IN (SELECT SubjectId FROM TopSubjects)
GROUP BY sub.Name, t.Name, t.Surname
ORDER BY LectureCount DESC;

-- 9
WITH SubjectLectureCounts AS (
    SELECT SubjectId, COUNT(*) AS LectureCount
    FROM Lectures
    GROUP BY SubjectId
),
MinLectureCount AS (
    SELECT MIN(LectureCount) AS MinCount FROM SubjectLectureCounts
)
SELECT sub.Name
FROM Subjects sub
JOIN SubjectLectureCounts slc ON sub.Id = slc.SubjectId
JOIN MinLectureCount mlc ON slc.LectureCount = mlc.MinCount;

-- 10
SELECT
    (SELECT COUNT(DISTINCT gs.StudentId)
     FROM GroupsStudents gs
     JOIN Groups g ON gs.GroupId = g.Id
     JOIN Departments d ON g.DepartmentId = d.Id
     WHERE d.Name = 'Software Development') AS StudentCount,

    (SELECT COUNT(DISTINCT s.Id)
     FROM Subjects s
     JOIN Lectures l ON s.Id = l.SubjectId
     JOIN GroupsLectures gl ON l.Id = gl.LectureId
     JOIN Groups g ON gl.GroupId = g.Id
     JOIN Departments d ON g.DepartmentId = d.Id
     WHERE d.Name = 'Software Development') AS SubjectCount;
