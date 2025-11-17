-- =====================================
-- CREACIÓN DE TABLAS Y CAMPOS
-- =====================================

-- ========================
-- Tabla: Marital_Status
-- ========================
CREATE TABLE Marital_Status (
    marital_status_id SERIAL,
    description VARCHAR(50) NOT NULL
);
COMMENT ON TABLE Marital_Status IS 'Catálogo de estados civiles de los estudiantes';
COMMENT ON COLUMN Marital_Status.marital_status_id IS 'Identificador único del estado civil';
COMMENT ON COLUMN Marital_Status.description IS 'Descripción del estado civil (soltero, casado, etc.)';

-- ========================
-- Tabla: Nationality
-- ========================
CREATE TABLE Nationality (
    nationality_id SERIAL,
    country_name VARCHAR(50) NOT NULL
);
COMMENT ON TABLE Nationality IS 'Catálogo de nacionalidades';
COMMENT ON COLUMN Nationality.nationality_id IS 'Identificador único de la nacionalidad';
COMMENT ON COLUMN Nationality.country_name IS 'Nombre del país de origen';

-- ========================
-- Tabla: Application_Mode
-- ========================
CREATE TABLE Application_Mode (
    application_mode_id SERIAL,
    description VARCHAR(50) NOT NULL
);
COMMENT ON TABLE Application_Mode IS 'Modos de aplicación para el ingreso de estudiantes (en línea, presencial, etc.)';
COMMENT ON COLUMN Application_Mode.application_mode_id IS 'Identificador único del modo de aplicación';
COMMENT ON COLUMN Application_Mode.description IS 'Descripción del modo de aplicación';

-- ========================
-- Tabla: Qualifications
-- ========================
CREATE TABLE Qualifications (
    qualification_id SERIAL,
    description VARCHAR(100) NOT NULL
);
COMMENT ON TABLE Qualifications IS 'Catálogo de niveles educativos o títulos obtenidos';
COMMENT ON COLUMN Qualifications.qualification_id IS 'Identificador del nivel educativo';
COMMENT ON COLUMN Qualifications.description IS 'Descripción del título o nivel académico';

-- ========================
-- Tabla: Occupations
-- ========================
CREATE TABLE Occupations (
    occupation_id SERIAL,
    description VARCHAR(100) NOT NULL
);
COMMENT ON TABLE Occupations IS 'Catálogo de ocupaciones o profesiones';
COMMENT ON COLUMN Occupations.occupation_id IS 'Identificador único de la ocupación';
COMMENT ON COLUMN Occupations.description IS 'Descripción de la ocupación (médico, ingeniero, etc.)';

-- ========================
-- Tabla: Departments
-- ========================
CREATE TABLE Departments (
    department_id SERIAL,
    name VARCHAR(100) NOT NULL,
    building VARCHAR(50)
);
COMMENT ON TABLE Departments IS 'Departamentos académicos de la institución';
COMMENT ON COLUMN Departments.department_id IS 'Identificador único del departamento';
COMMENT ON COLUMN Departments.name IS 'Nombre del departamento (Matemáticas, Historia, etc.)';
COMMENT ON COLUMN Departments.building IS 'Edificio donde se ubica el departamento';

-- ========================
-- Tabla: Students
-- ========================
CREATE TABLE Students (
    student_id SERIAL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    birth_date DATE,
    enrollment_date DATE NOT NULL,
    marital_status_id INT,
    gender CHAR(1),
    nationality_id INT,
    age_at_enrollment INT,
    international BOOLEAN,
    displaced BOOLEAN,
    educational_special_needs BOOLEAN,
    debtor BOOLEAN,
    tuition_fees_up_to_date BOOLEAN,
    scholarship_holder BOOLEAN,
    mother_qualification_id INT,
    father_qualification_id INT,
    mother_occupation_id INT,
    father_occupation_id INT,
    admission_grade NUMERIC(5,2),
    previous_qualification_id INT,
    previous_qualification_grade NUMERIC(5,2),
    application_mode_id INT
);
COMMENT ON TABLE Students IS 'Información general de los estudiantes';
COMMENT ON COLUMN Students.student_id IS 'Identificador único del estudiante';
COMMENT ON COLUMN Students.first_name IS 'Nombre del estudiante';
COMMENT ON COLUMN Students.last_name IS 'Apellido del estudiante';
COMMENT ON COLUMN Students.email IS 'Correo institucional o personal del estudiante';
COMMENT ON COLUMN Students.birth_date IS 'Fecha de nacimiento';
COMMENT ON COLUMN Students.enrollment_date IS 'Fecha de matrícula o ingreso a la institución';
COMMENT ON COLUMN Students.marital_status_id IS 'Estado civil del estudiante';
COMMENT ON COLUMN Students.gender IS 'Género del estudiante (M/F)';
COMMENT ON COLUMN Students.nationality_id IS 'Nacionalidad del estudiante';
COMMENT ON COLUMN Students.age_at_enrollment IS 'Edad al momento de la matrícula';
COMMENT ON COLUMN Students.international IS 'Indica si el estudiante es extranjero';
COMMENT ON COLUMN Students.displaced IS 'Indica si el estudiante fue desplazado';
COMMENT ON COLUMN Students.educational_special_needs IS 'Indica si el estudiante tiene necesidades educativas especiales';
COMMENT ON COLUMN Students.debtor IS 'Indica si el estudiante tiene deudas pendientes';
COMMENT ON COLUMN Students.tuition_fees_up_to_date IS 'Indica si está al día con las matrículas';
COMMENT ON COLUMN Students.scholarship_holder IS 'Indica si el estudiante tiene beca';
COMMENT ON COLUMN Students.mother_qualification_id IS 'Identificador de la calificación educativa de la madre';
COMMENT ON COLUMN Students.father_qualification_id IS 'Identificador de la calificación educativa del padre';
COMMENT ON COLUMN Students.mother_occupation_id IS 'Identificador de la ocupación de la madre';
COMMENT ON COLUMN Students.father_occupation_id IS 'Identificador de la ocupación del padre';
COMMENT ON COLUMN Students.admission_grade IS 'Nota de admisión del estudiante';
COMMENT ON COLUMN Students.previous_qualification_id IS 'Identificador del título o calificación previa';
COMMENT ON COLUMN Students.previous_qualification_grade IS 'Nota obtenida en la calificación previa';
COMMENT ON COLUMN Students.application_mode_id IS 'Modo de aplicación del estudiante (en línea, presencial, etc.)';

-- ========================
-- Tabla: Professors
-- ========================
CREATE TABLE Professors (
    professor_id SERIAL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL
);
COMMENT ON TABLE Professors IS 'Profesores de la institución';
COMMENT ON COLUMN Professors.professor_id IS 'Identificador único del profesor';
COMMENT ON COLUMN Professors.first_name IS 'Nombre del profesor';
COMMENT ON COLUMN Professors.last_name IS 'Apellido del profesor';
COMMENT ON COLUMN Professors.email IS 'Correo institucional del profesor';
COMMENT ON COLUMN Professors.hire_date IS 'Fecha de contratación';

-- ========================
-- Tabla: Courses
-- ========================
CREATE TABLE Courses (
    course_id SERIAL,
    name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    department_id INT
);
COMMENT ON TABLE Courses IS 'Cursos o asignaturas ofrecidas por la institución';
COMMENT ON COLUMN Courses.course_id IS 'Identificador del curso';
COMMENT ON COLUMN Courses.name IS 'Nombre del curso';
COMMENT ON COLUMN Courses.credits IS 'Número de créditos asignados al curso';
COMMENT ON COLUMN Courses.department_id IS 'Departamento académico responsable del curso';

-- ========================
-- Tabla: Enrollments
-- ========================
CREATE TABLE Enrollments (
    enrollment_id SERIAL,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    grade NUMERIC(3,1),
    semester INT
);
COMMENT ON TABLE Enrollments IS 'Matrículas de los estudiantes en los cursos';
COMMENT ON COLUMN Enrollments.enrollment_id IS 'Identificador de la matrícula';
COMMENT ON COLUMN Enrollments.student_id IS 'Referencia al estudiante matriculado';
COMMENT ON COLUMN Enrollments.course_id IS 'Referencia al curso matriculado';
COMMENT ON COLUMN Enrollments.enrollment_date IS 'Fecha en que se realizó la matrícula';
COMMENT ON COLUMN Enrollments.grade IS 'Calificación final obtenida en el curso';
COMMENT ON COLUMN Enrollments.semester IS 'Semestre académico en que se matriculó el estudiante';

-- ========================
-- Tabla: Course_Professors
-- ========================
CREATE TABLE Course_Professors (
    course_id INT,
    professor_id INT
);
COMMENT ON TABLE Course_Professors IS 'Relación entre cursos y profesores asignados';
COMMENT ON COLUMN Course_Professors.course_id IS 'Identificador del curso impartido';
COMMENT ON COLUMN Course_Professors.professor_id IS 'Identificador del profesor asignado';

-- ========================
-- Tabla: Classrooms
-- ========================
CREATE TABLE Classrooms (
    classroom_id SERIAL,
    building VARCHAR(50) NOT NULL,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    capacity INT NOT NULL
);
COMMENT ON TABLE Classrooms IS 'Salones o aulas disponibles para los cursos';
COMMENT ON COLUMN Classrooms.classroom_id IS 'Identificador del aula';
COMMENT ON COLUMN Classrooms.building IS 'Edificio donde se ubica el aula';
COMMENT ON COLUMN Classrooms.room_number IS 'Número del aula';
COMMENT ON COLUMN Classrooms.capacity IS 'Capacidad máxima del aula';

-- ========================
-- Tabla: Course_Schedule
-- ========================
CREATE TABLE Course_Schedule (
    schedule_id SERIAL,
    course_id INT,
    classroom_id INT,
    day_of_week VARCHAR(10) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);
COMMENT ON TABLE Course_Schedule IS 'Horario de los cursos y su asignación en aulas';
COMMENT ON COLUMN Course_Schedule.schedule_id IS 'Identificador del horario';
COMMENT ON COLUMN Course_Schedule.course_id IS 'Identificador del curso programado';
COMMENT ON COLUMN Course_Schedule.classroom_id IS 'Identificador del aula asignada';
COMMENT ON COLUMN Course_Schedule.day_of_week IS 'Día de la semana en que se dicta la clase';
COMMENT ON COLUMN Course_Schedule.start_time IS 'Hora de inicio de la clase';
COMMENT ON COLUMN Course_Schedule.end_time IS 'Hora de finalización de la clase';

-- =====================================
-- ASIGNACIÓN DE LLAVES PRIMARIAS
-- =====================================
ALTER TABLE Marital_Status ADD CONSTRAINT pk_marital_status PRIMARY KEY (marital_status_id);
ALTER TABLE Nationality ADD CONSTRAINT pk_nationality PRIMARY KEY (nationality_id);
ALTER TABLE Application_Mode ADD CONSTRAINT pk_application_mode PRIMARY KEY (application_mode_id);
ALTER TABLE Qualifications ADD CONSTRAINT pk_qualifications PRIMARY KEY (qualification_id);
ALTER TABLE Occupations ADD CONSTRAINT pk_occupations PRIMARY KEY (occupation_id);
ALTER TABLE Departments ADD CONSTRAINT pk_departments PRIMARY KEY (department_id);
ALTER TABLE Students ADD CONSTRAINT pk_students PRIMARY KEY (student_id);
ALTER TABLE Professors ADD CONSTRAINT pk_professors PRIMARY KEY (professor_id);
ALTER TABLE Courses ADD CONSTRAINT pk_courses PRIMARY KEY (course_id);
ALTER TABLE Enrollments ADD CONSTRAINT pk_enrollments PRIMARY KEY (enrollment_id);
ALTER TABLE Classrooms ADD CONSTRAINT pk_classrooms PRIMARY KEY (classroom_id);
ALTER TABLE Course_Schedule ADD CONSTRAINT pk_course_schedule PRIMARY KEY (schedule_id);
ALTER TABLE Course_Professors ADD CONSTRAINT pk_course_professors PRIMARY KEY (course_id, professor_id);

-- =====================================
-- ASIGNACIÓN DE LLAVES FORÁNEAS
-- =====================================
ALTER TABLE Students ADD CONSTRAINT fk_students_marital_status
FOREIGN KEY (marital_status_id) REFERENCES Marital_Status (marital_status_id)
ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Students ADD CONSTRAINT fk_students_nationality
FOREIGN KEY (nationality_id) REFERENCES Nationality (nationality_id)
ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Students ADD CONSTRAINT fk_students_mother_qualification
FOREIGN KEY (mother_qualification_id) REFERENCES Qualifications(qualification_id)
ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Students ADD CONSTRAINT fk_students_father_qualification
FOREIGN KEY (father_qualification_id) REFERENCES Qualifications(qualification_id)
ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Students ADD CONSTRAINT fk_students_mother_occupation
FOREIGN KEY (mother_occupation_id) REFERENCES Occupations(occupation_id)
ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Students ADD CONSTRAINT fk_students_father_occupation
FOREIGN KEY (father_occupation_id) REFERENCES Occupations(occupation_id)
ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Students ADD CONSTRAINT fk_students_previous_qualification
FOREIGN KEY (previous_qualification_id) REFERENCES Qualifications(qualification_id)
ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Students ADD CONSTRAINT fk_students_application_mode
FOREIGN KEY (application_mode_id) REFERENCES Application_Mode(application_mode_id)
ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Courses ADD CONSTRAINT fk_courses_departments
FOREIGN KEY (department_id) REFERENCES Departments (department_id)
ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE Enrollments ADD CONSTRAINT fk_enrollments_students
FOREIGN KEY (student_id) REFERENCES Students(student_id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Enrollments ADD CONSTRAINT fk_enrollments_courses
FOREIGN KEY (course_id) REFERENCES Courses(course_id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Course_Professors ADD CONSTRAINT fk_course_professors_courses
FOREIGN KEY (course_id) REFERENCES Courses(course_id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Course_Professors ADD CONSTRAINT fk_course_professors_professors
FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Course_Schedule ADD CONSTRAINT fk_course_schedule_courses
FOREIGN KEY (course_id) REFERENCES Courses(course_id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Course_Schedule ADD CONSTRAINT fk_course_schedule_classrooms
FOREIGN KEY (classroom_id) REFERENCES Classrooms(classroom_id)
ON UPDATE CASCADE ON DELETE SET NULL;