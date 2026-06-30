# Write your MySQL query statement below
select s.student_id, s.student_name, b.subject_name,
count(e.subject_name) as attended_exams
from Students s
cross join Subjects b
left join Examinations e
on e.student_id = s.student_id
and b.subject_name = e.subject_name
group by s.student_id, s.student_name, b.subject_name
order by s.student_id, b.subject_name; 