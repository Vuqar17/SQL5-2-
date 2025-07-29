Use AcademyDB6


INSERT INTO Faculties (Name) VALUES
('Computer Science'),
('Software Development'),
('Mathematics');


INSERT INTO Departments (Building, Financing, Name, FacultyId) VALUES
(1, 120000, 'Software Development', 2),
(2, 80000, 'Computer Science', 1),
(3, 60000, 'Mathematics', 3),
(1, 30000, 'Data Science', 1),
(1, 40000, 'AI', 2);


INSERT INTO Groups (Name, Year, DepartmentId) VALUES
('D221', 5, 1),
('D222', 5, 1),
('D223', 3, 1),
('C101', 2, 2),
('C102', 3, 2),
('M301', 5, 3);


INSERT INTO Curators (Name, Surname) VALUES
('Elnur', 'Mammadli'),
('Revan', 'Quliyev'),
('Rustam', 'Rustamov');


INSERT INTO GroupsCurators (CuratorId, GroupId) VALUES
(1, 1),
(2, 1),
(3, 2);

INSERT INTO Students (Name, Surname, Rating) VALUES
('Ali', 'Cavadov', 5),
('Aysel', 'Taghizade', 4),
('Rauf', 'Suleymanov', 3),
('Leman', 'Qurbanova', 2),
('Murad', 'Aliyev', 5),
('Ilkin', 'Rahimov', 1),
('Lala', 'Mirzayeva', 2),
('Kamal', 'Mansurov', 3),
('Zaur', 'Huseynov', 2),
('Sevda', 'Guliyeva', 1);


INSERT INTO GroupsStudents (GroupId, StudentId) VALUES
(1,1),(1,2),(1,3),(1,4),
(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),
(3,1),(3,2),
(4,3),(4,4),
(5,5),(5,6),
(6,7),(6,8);

INSERT INTO Subjects (Name) VALUES
('Databases'),
('Algorithms'),
('C++ Programming'),
('Data Structures'),
('AI Systems');


INSERT INTO Teachers (IsProfessor, Name, Surname, Salary) VALUES
(1, 'Elchin', 'Mammadov', 4000),
(0, 'Ramin', 'Aliyev', 3000),
(0, 'Leman', 'Gurbanova', 3200),
(1, 'Tural', 'Rahimli', 4500),
(0, 'Elnur', 'Suleymanov', 2800);


INSERT INTO Lectures (Date, SubjectId, TeacherId) VALUES
('2025-01-05', 1, 1),
('2025-01-06', 1, 2),
('2025-01-07', 1, 3),
('2025-01-08', 2, 2),
('2025-01-09', 3, 1),
('2025-01-10', 3, 1),
('2025-01-11', 4, 3),
('2025-01-12', 5, 4),
('2025-01-13', 1, 1),
('2025-01-14', 1, 1),
('2025-01-15', 1, 1),
('2025-01-16', 1, 1);


INSERT INTO GroupsLectures (GroupId, LectureId) VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),
(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),
(3,1),(3,2),
(4,3),(4,4),
(5,5),(5,6),
(6,7),(6,8);
