--Create Database AcademyDB6
--USE AcademyDB6
-- 1
CREATE TABLE Curators (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(MAX) NOT NULL CHECK (Name <> ''),
    Surname NVARCHAR(MAX) NOT NULL CHECK (Surname <> '')
);

-- 2
CREATE TABLE Faculties (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK (Name <> '')
);

-- 3
CREATE TABLE Departments (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Financing MONEY NOT NULL CHECK (Financing >= 0) DEFAULT 0,
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK (Name <> ''),
    FacultyId INT NOT NULL,
    FOREIGN KEY (FacultyId) REFERENCES Faculties(Id)
);

-- 4
CREATE TABLE Groups (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(10) NOT NULL UNIQUE CHECK (Name <> ''),
    Year INT NOT NULL CHECK (Year BETWEEN 1 AND 5),
    DepartmentId INT NOT NULL,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);

-- 5
CREATE TABLE Students (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(MAX) NOT NULL CHECK (Name <> ''),
    Surname NVARCHAR(MAX) NOT NULL CHECK (Surname <> ''),
    Rating INT NOT NULL CHECK (Rating BETWEEN 0 AND 5)
);

-- 6
CREATE TABLE Subjects (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK (Name <> '')
);

-- 7
CREATE TABLE Teachers (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    IsProfessor BIT NOT NULL DEFAULT 0,
    Name NVARCHAR(MAX) NOT NULL CHECK (Name <> ''),
    Surname NVARCHAR(MAX) NOT NULL CHECK (Surname <> ''),
    Salary MONEY NOT NULL CHECK (Salary > 0)
);

-- 8
CREATE TABLE Lectures (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Date DATE NOT NULL CHECK (Date <= GETDATE()),
    SubjectId INT NOT NULL,
    TeacherId INT NOT NULL,
    FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);

-- 9
CREATE TABLE GroupsCurators (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    CuratorId INT NOT NULL,
    GroupId INT NOT NULL,
    FOREIGN KEY (CuratorId) REFERENCES Curators(Id),
    FOREIGN KEY (GroupId) REFERENCES Groups(Id)
);

-- 10
CREATE TABLE GroupsLectures (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    GroupId INT NOT NULL,
    LectureId INT NOT NULL,
    FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    FOREIGN KEY (LectureId) REFERENCES Lectures(Id)
);

-- 11
CREATE TABLE GroupsStudents (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    GroupId INT NOT NULL,
    StudentId INT NOT NULL,
    FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    FOREIGN KEY (StudentId) REFERENCES Students(Id)
);
