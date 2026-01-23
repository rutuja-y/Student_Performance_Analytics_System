USE spas;

INSERT INTO Students (name, class, gender, dob) VALUES
('Asha Kulkarni', 'B.Tech CSE', 'Female', '2003-03-15'),
('Rohit Sharma', 'B.Tech CSE', 'Male', '2002-08-01'),
('Meera Desai', 'B.Tech CSE', 'Female', '2003-06-20'),
('Aditya Rao', 'B.Tech CSE', 'Male', '2002-12-05'),
('Nisha Patil', 'B.Tech CSE', 'Female', '2003-01-11');

INSERT INTO Courses (course_name, max_marks) VALUES
('Data Structures', 100),
('Database Systems', 100),
('Operating Systems', 100),
('Computer Networks', 100),
('Software Engineering', 100);

INSERT INTO Enrollments (student_id, course_id, semester)
SELECT s.student_id, c.course_id, 'Sem 4'
FROM Students s CROSS JOIN Courses c;

INSERT INTO Marks (student_id, course_id, marks, exam_date) VALUES
(1, 1, 88, '2025-04-10'),
(1, 2, 92, '2025-04-12'),
(1, 3, 79, '2025-04-15'),
(1, 4, 85, '2025-04-18'),
(1, 5, 90, '2025-04-20'),
(2, 1, 75, '2025-04-10'),
(2, 2, 68, '2025-04-12'),
(2, 3, 72, '2025-04-15'),
(2, 4, 70, '2025-04-18'),
(2, 5, 74, '2025-04-20'),
(3, 1, 95, '2025-04-10'),
(3, 2, 89, '2025-04-12'),
(3, 3, 94, '2025-04-15'),
(3, 4, 91, '2025-04-18'),
(3, 5, 88, '2025-04-20'),
(4, 1, 60, '2025-04-10'),
(4, 2, 55, '2025-04-12'),
(4, 3, 65, '2025-04-15'),
(4, 4, 58, '2025-04-18'),
(4, 5, 62, '2025-04-20'),
(5, 1, 82, '2025-04-10'),
(5, 2, 80, '2025-04-12'),
(5, 3, 78, '2025-04-15'),
(5, 4, 85, '2025-04-18'),
(5, 5, 83, '2025-04-20');

INSERT INTO Attendance (student_id, course_id, attendance_percentage) VALUES
(1,1,92.5),(1,2,95.0),(1,3,88.0),(1,4,90.0),(1,5,93.0),
(2,1,70.0),(2,2,65.0),(2,3,72.0),(2,4,68.0),(2,5,75.0),
(3,1,98.0),(3,2,96.0),(3,3,97.0),(3,4,95.0),(3,5,94.5),
(4,1,55.0),(4,2,60.0),(4,3,58.0),(4,4,52.0),(4,5,57.0),
(5,1,88.0),(5,2,85.0),(5,3,82.0),(5,4,90.0),(5,5,87.0);
