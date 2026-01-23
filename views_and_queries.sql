USE spas;
-- 1. Consolidated student report view (total, average, rank)
DROP VIEW IF EXISTS student_report_view;
CREATE VIEW student_report_view AS
SELECT
s.student_id,
s.name,
s.class,
COUNT(m.course_id) AS subjects_taken,
SUM(m.marks) AS total_marks,
ROUND(AVG(m.marks),2) AS average_marks
FROM Students s
LEFT JOIN Marks m ON s.student_id = m.student_id
GROUP BY s.student_id;

-- 2. Ranking using window function
SELECT
student_id,
name,
total_marks,
average_marks,
RANK() OVER (ORDER BY total_marks DESC) AS class_rank
FROM student_report_view
ORDER BY class_rank;

-- 3. Subject-wise toppers (top 3 per course)
SELECT
c.course_name,
s.name,
m.marks,
RANK() OVER (PARTITION BY m.course_id ORDER BY m.marks DESC) AS
rank_in_subject
FROM Marks m
JOIN Students s ON m.student_id = s.student_id
JOIN Courses c ON m.course_id = c.course_id
ORDER BY c.course_id, rank_in_subject
LIMIT 50;

-- 4. Pass/Fail per student (pass if avg >= 40)
SELECT
student_id,
name,
average_marks,
CASE WHEN average_marks >= 40 THEN 'Pass' ELSE 'Fail' END AS status
FROM student_report_view;

-- 5. Attendance vs average marks
SELECT
s.name,
ROUND(AVG(a.attendance_percentage),2) AS avg_attendance,
rr.average_marks
FROM Attendance a
JOIN Students s ON a.student_id = s.student_id
JOIN (
SELECT student_id, ROUND(AVG(marks),2) AS average_marks FROM Marks GROUP
BY student_id
) rr ON rr.student_id = s.student_id
GROUP BY s.student_id, rr.average_marks
ORDER BY rr.average_marks DESC;

