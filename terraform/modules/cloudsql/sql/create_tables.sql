-- ===============================
-- 1. CREACIÓN DE TABLAS (SIN RELACIONES)
-- ===============================

-- Students
CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    birth_date DATE,
    enrollment_date DATE NOT NULL
);

-- Professors
CREATE TABLE Professors (
    professor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL
);

-- Departments
CREATE TABLE Departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    building VARCHAR(50)
);

-- Courses
CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    department_id INT  -- Relación se añade después
);

-- Enrollments
CREATE TABLE Enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,   -- Relación se añade después
    course_id INT,    -- Relación se añade después
    enrollment_date DATE NOT NULL,
    grade NUMERIC(3,1) CHECK (grade >= 0 AND grade <= 10)
);

-- Course_Professors
CREATE TABLE Course_Professors (
    course_id INT,    -- Relación se añade después
    professor_id INT, -- Relación se añade después
    PRIMARY KEY(course_id, professor_id)
);

-- Classrooms
CREATE TABLE Classrooms (
    classroom_id SERIAL PRIMARY KEY,
    building VARCHAR(50) NOT NULL,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    capacity INT NOT NULL
);

-- Course_Schedule
CREATE TABLE Course_Schedule (
    schedule_id SERIAL PRIMARY KEY,
    course_id INT,       -- Relación se añade después
    classroom_id INT,    -- Relación se añade después
    day_of_week VARCHAR(10) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

-- ===============================
-- 2. CREACIÓN DE RELACIONES (FOREIGN KEYS)
-- ===============================

-- Courses → Departments
ALTER TABLE Courses
ADD CONSTRAINT fk_courses_departments
FOREIGN KEY (department_id)
REFERENCES Departments(department_id)
ON DELETE SET NULL;

-- Enrollments → Students
ALTER TABLE Enrollments
ADD CONSTRAINT fk_enrollments_students
FOREIGN KEY (student_id)
REFERENCES Students(student_id)
ON DELETE CASCADE;

-- Enrollments → Courses
ALTER TABLE Enrollments
ADD CONSTRAINT fk_enrollments_courses
FOREIGN KEY (course_id)
REFERENCES Courses(course_id)
ON DELETE CASCADE;

-- Course_Professors → Courses
ALTER TABLE Course_Professors
ADD CONSTRAINT fk_course_professors_courses
FOREIGN KEY (course_id)
REFERENCES Courses(course_id)
ON DELETE CASCADE;

-- Course_Professors → Professors
ALTER TABLE Course_Professors
ADD CONSTRAINT fk_course_professors_professors
FOREIGN KEY (professor_id)
REFERENCES Professors(professor_id)
ON DELETE CASCADE;

-- Course_Schedule → Courses
ALTER TABLE Course_Schedule
ADD CONSTRAINT fk_course_schedule_courses
FOREIGN KEY (course_id)
REFERENCES Courses(course_id)
ON DELETE CASCADE;

-- Course_Schedule → Classrooms
ALTER TABLE Course_Schedule
ADD CONSTRAINT fk_course_schedule_classrooms
FOREIGN KEY (classroom_id)
REFERENCES Classrooms(classroom_id)
ON DELETE SET NULL;
