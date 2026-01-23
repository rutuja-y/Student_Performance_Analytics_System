USE spas;

-- 1. Trigger: after inserting marks, update a summary table
DROP TABLE IF EXISTS marks_log;
CREATE TABLE marks_log (
log_id INT PRIMARY KEY AUTO_INCREMENT,
mark_id INT,
student_id INT,
course_id INT,
marks INT,
logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TRIGGER IF EXISTS trg_after_mark_insert;

DELIMITER $$
CREATE TRIGGER trg_after_mark_insert
AFTER INSERT ON Marks
FOR EACH ROW
BEGIN
INSERT INTO marks_log (mark_id, student_id, course_id, marks)
VALUES (NEW.mark_id, NEW.student_id, NEW.course_id, NEW.marks);
END
$$ DELIMITER ;

-- 2. Procedure: Calculate and return student report

DROP PROCEDURE IF EXISTS get_student_report;

DELIMITER $$
CREATE PROCEDURE get_student_report(IN p_student_id INT)
BEGIN
SELECT s.student_id, s.name, c.course_name, m.marks
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
JOIN Courses c ON m.course_id = c.course_id
WHERE s.student_id = p_student_id;
END
$$ DELIMITER ;

-- 3. Procedure: Auto-flag low attendance students)

DROP TABLE IF EXISTS low_attendance;
CREATE TABLE low_attendance (
id INT PRIMARY KEY AUTO_INCREMENT,
student_id INT,
avg_att DECIMAL(5,2),
flagged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DROP PROCEDURE IF EXISTS flag_low_attendance;

DELIMITER $$
CREATE PROCEDURE flag_low_attendance(IN threshold DECIMAL(5,2))
BEGIN
INSERT INTO low_attendance (student_id, avg_att)
SELECT student_id, ROUND(AVG(attendance_percentage),2) as av
FROM Attendance
GROUP BY student_id
HAVING av < threshold;
END
$$ DELIMITER ;
