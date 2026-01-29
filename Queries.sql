use school_db;

select * from attendance;
select * from classes;
select * from students;
select * from subjects;
select * from teachers;

-- SIMPLE QUERIES
-- 1.Display the student_name, and gender of all students.
select student_name,gender from students;

-- 2.List all classes ordered by class_name.
select * from classes order by class_name;

-- 3.Display the names of teachers who teach a Maths.
select teacher_name,subject from teachers where subject =  'Maths';

-- 4.Show all students who belong to a class_id is 7.
select * from students where class_id = 7;

-- 5.Retrieve all attendance records for a after january.
select * from attendance where attend_date > '2025-01-31';


-- Intermediate Queries
-- 1.Count the total number of students in each class.
select class_id,count(student_name) from students group by class_id;

-- 2.Display the number of students by gender.
select gender,count(student_name) from students group by gender;

-- 3.Find the subjects that are taught by more than 5 teacher.
select subject,count(teacher_id) from teachers group by subject having count(teacher_id) > 5;

-- 4.Find the number of students present on each date.
select attend_date,count(attendance_id) from attendance where status = 'Present' group by attend_date;

-- 5.Display class IDs having more than 10 students.
select class_id,count(student_id) from students group by class_id having count(student_id) > 10;


-- Intermediate Queries
-- 1.Display student names along with their class name and section.
select s.student_name,c.class_name,c.section from students s left join classes c 
on s.class_id = c.class_id;

-- 2.List subjects along with the teacher name who teaches them, sorted by teacher name in ascending order.
select s.subject_name,t.teacher_name from subjects s left join teachers t 
on s.teacher_id = t.teacher_id order by teacher_name asc;

-- 3.Display student names and their attendance status for each date, sorted by attendance date in ascending order.
select s.student_name,a.attend_date,a.status from students s right join attendance a 
on a.student_id = s.student_id order by attend_date asc;

-- 4.Find the class name that has the highest number of students.
with CTE_1 as(select class_id,count(student_id) from students group by class_id order by count(student_id) desc limit 1)
select c.class_name from CTE_1 s left join classes c
on s.class_id = c.class_id;

-- 5.List students who were marked Absent at least once.
with cte_1 as(select * from students),
cte_2 as(select student_id,status from attendance where status = 'Absent')
select s.*,a.status from cte_2 a right join cte_1 s 
on a.student_id = s.student_id where a.status = 'Absent';