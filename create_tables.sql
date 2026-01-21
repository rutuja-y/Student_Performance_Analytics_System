CREATE DATABASE IF NOT EXISTS spas;
USE spas;
CREATE TABLE Students (
student_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
class VARCHAR(20),
gender VARCHAR(10),
dob DATE
);

CREATE TABLE Courses (
course_id INT PRIMARY KEY AUTO_INCREMENT,
course_name VARCHAR(100) NOT NULL,
max_marks INT DEFAULT 100
);
CREATE TABLE Enrollments (
enroll_id INT PRIMARY KEY AUTO_INCREMENT,
student_id INT NOT NULL,
course_id INT NOT NULL,
semester VARCHAR(20),
FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE
CASCADE,
FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);
CREATE TABLE Marks (
mark_id INT PRIMARY KEY AUTO_INCREMENT,
student_id INT NOT NULL,
course_id INT NOT NULL,
marks INT CHECK (marks >= 0 AND marks <= 100),
exam_date DATE,
FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE
CASCADE,
FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);
CREATE TABLE Attendance (
att_id INT PRIMARY KEY AUTO_INCREMENT,
student_id INT NOT NULL,
course_id INT NOT NULL,
attendance_percentage DECIMAL(5,2) CHECK (attendance_percentage >= 0 AND
attendance_percentage <= 100),
FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE
CASCADE,
FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

CREATE INDEX idx_marks_student ON Marks(student_id);
CREATE INDEX idx_marks_course ON Marks(course_id);
CREATE INDEX idx_att_student ON Attendance(student_id);
CREATE INDEX idx_att_course ON Attendance(course_id);