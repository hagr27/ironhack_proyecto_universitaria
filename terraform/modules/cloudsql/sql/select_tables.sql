TRUNCATE TABLE Course_Schedule CASCADE;
TRUNCATE TABLE Course_Professors CASCADE;
TRUNCATE TABLE Enrollments CASCADE;
TRUNCATE TABLE Students CASCADE;
TRUNCATE TABLE Courses CASCADE;
TRUNCATE TABLE Professors CASCADE;
TRUNCATE TABLE Classrooms CASCADE;
TRUNCATE TABLE Departments CASCADE;
TRUNCATE TABLE Occupations CASCADE;
TRUNCATE TABLE Qualifications CASCADE;
TRUNCATE TABLE Application_Mode CASCADE;
TRUNCATE TABLE Nationality CASCADE;
TRUNCATE TABLE Marital_Status CASCADE;

-- ============================
-- Eliminar tablas en orden correcto
-- ============================

-- Tablas dependientes de otras
DROP TABLE IF EXISTS Enrollments CASCADE;
DROP TABLE IF EXISTS Course_Professors CASCADE;
DROP TABLE IF EXISTS Course_Schedule CASCADE;

-- Tabla Students depende de catálogos
DROP TABLE IF EXISTS Students CASCADE;

-- Tablas principales
DROP TABLE IF EXISTS Courses CASCADE;
DROP TABLE IF EXISTS Professors CASCADE;
DROP TABLE IF EXISTS Classrooms CASCADE;
DROP TABLE IF EXISTS Departments CASCADE;

-- Tablas de catálogos
DROP TABLE IF EXISTS Marital_Status CASCADE;
DROP TABLE IF EXISTS Nationality CASCADE;
DROP TABLE IF EXISTS Application_Mode CASCADE;
DROP TABLE IF EXISTS Qualifications CASCADE;
DROP TABLE IF EXISTS Occupations CASCADE;


-- ============================
-- Select Dataset
-- ============================

WITH student_courses AS (
    SELECT
        s.student_id,
        s.first_name,
        s.last_name,
        s.marital_status_id,
        s.application_mode_id,
        s.previous_qualification_id,
        s.previous_qualification_grade,
        s.nationality_id,
        s.mother_qualification_id,
        s.father_qualification_id,
        s.mother_occupation_id,
        s.father_occupation_id,
        s.admission_grade,
        s.displaced,
        s.educational_special_needs,
        s.debtor,
        s.tuition_fees_up_to_date,
        s.gender,
        s.scholarship_holder,
        s.age_at_enrollment,
        s.international,
        e.course_id,
        e.grade AS course_grade,
        e.semester,
        c.credits AS course_credits
    FROM Students s
    LEFT JOIN Enrollments e ON s.student_id = e.student_id
    LEFT JOIN Courses c ON e.course_id = c.course_id
)
SELECT
    ms.description AS "Marital Status",
    am.description AS "Application mode",
    ROW_NUMBER() OVER (PARTITION BY s.student_id ORDER BY s.enrollment_date) AS "Application order",
    c.name AS "Course",
    CASE WHEN cs.start_time < '12:00' THEN 'Daytime' ELSE 'Evening' END AS "Daytime/evening attendance",
    pq.description AS "Previous qualification",
    s.previous_qualification_grade AS "Previous qualification (grade)",
    n.country_name AS "Nationality",
    mq.description AS "Mother's qualification",
    fq.description AS "Father's qualification",
    mo.description AS "Mother's occupation",
    fo.description AS "Father's occupation",
    s.admission_grade AS "Admission grade",
    s.displaced AS "Displaced",
    s.educational_special_needs AS "Educational special needs",
    s.debtor AS "Debtor",
    s.tuition_fees_up_to_date AS "Tuition fees up to date",
    s.gender AS "Gender",
    s.scholarship_holder AS "Scholarship holder",
    s.age_at_enrollment AS "Age at enrollment",
    s.international AS "International",
    
    -- 1st semester
    SUM(CASE WHEN e.semester = 1 THEN c.credits ELSE 0 END) AS "Curricular units 1st sem (credited)",
    COUNT(CASE WHEN e.semester = 1 THEN e.course_id END) AS "Curricular units 1st sem (enrolled)",
    COUNT(CASE WHEN e.semester = 1 AND e.grade IS NOT NULL THEN e.course_id END) AS "Curricular units 1st sem (evaluations)",
    COUNT(CASE WHEN e.semester = 1 AND e.grade >= 60 THEN e.course_id END) AS "Curricular units 1st sem (approved)",
    ROUND(AVG(CASE WHEN e.semester = 1 AND e.grade IS NOT NULL THEN e.grade END), 2) AS "Curricular units 1st sem (grade)",
    COUNT(CASE WHEN e.semester = 1 AND e.grade IS NULL THEN e.course_id END) AS "Curricular units 1st sem (without evaluations)",

    -- 2nd semester
    SUM(CASE WHEN e.semester = 2 THEN c.credits ELSE 0 END) AS "Curricular units 2nd sem (credited)",
    COUNT(CASE WHEN e.semester = 2 THEN e.course_id END) AS "Curricular units 2nd sem (enrolled)",
    COUNT(CASE WHEN e.semester = 2 AND e.grade IS NOT NULL THEN e.course_id END) AS "Curricular units 2nd sem (evaluations)",
    COUNT(CASE WHEN e.semester = 2 AND e.grade >= 60 THEN e.course_id END) AS "Curricular units 2nd sem (approved)",
    ROUND(AVG(CASE WHEN e.semester = 2 AND e.grade IS NOT NULL THEN e.grade END), 2) AS "Curricular units 2nd sem (grade)",
    COUNT(CASE WHEN e.semester = 2 AND e.grade IS NULL THEN e.course_id END) AS "Curricular units 2nd sem (without evaluations)",
    
    -- Indicadores externos (placeholders)
    NULL::NUMERIC AS "Unemployment rate",
    NULL::NUMERIC AS "Inflation rate",
    NULL::NUMERIC AS "GDP",
    NULL::TEXT AS "target"
FROM Students s
LEFT JOIN Marital_Status ms ON s.marital_status_id = ms.marital_status_id
LEFT JOIN Application_Mode am ON s.application_mode_id = am.application_mode_id
LEFT JOIN Nationality n ON s.nationality_id = n.nationality_id
LEFT JOIN Qualifications pq ON s.previous_qualification_id = pq.qualification_id
LEFT JOIN Qualifications mq ON s.mother_qualification_id = mq.qualification_id
LEFT JOIN Qualifications fq ON s.father_qualification_id = fq.qualification_id
LEFT JOIN Occupations mo ON s.mother_occupation_id = mo.occupation_id
LEFT JOIN Occupations fo ON s.father_occupation_id = fo.occupation_id
LEFT JOIN Enrollments e ON s.student_id = e.student_id
LEFT JOIN Courses c ON e.course_id = c.course_id
LEFT JOIN Course_Schedule cs ON c.course_id = cs.course_id
GROUP BY
    s.student_id, ms.description, am.description, c.name, cs.start_time,
    pq.description, n.country_name, mq.description, fq.description,
    mo.description, fo.description, s.admission_grade, s.displaced,
    s.educational_special_needs, s.debtor, s.tuition_fees_up_to_date,
    s.gender, s.scholarship_holder, s.age_at_enrollment, s.international, s.previous_qualification_grade
ORDER BY s.student_id;
