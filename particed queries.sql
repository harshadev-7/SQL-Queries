create database Kanki;
use Kanki;
create table Students(
Sid int primary key,
Sname varchar(50),
Age int,
Grade char);

insert into Students
values(1,'Ravi',20,'A'),
(2,'Anil',21,'B'),
(3,'Sita',19,'A'),
(4,'Kiran',22,'C');

create table Courses(
Cid int primary key,
Cname varchar(50),
Credits int
);
drop table Courses;

insert into Courses 
values(101,'DBMS',4),
(102,'OS',3),
(103,'Java',4),
(104,'AI',2);

create table Enrollments(
Sid int,
Cid int,
Semester int,
foreign key(Sid) references Students(Sid),
foreign key(Cid) references Courses(Cid)
);

insert into Enrollments
values(1,101,2),
(1,102,2),
(2,103,3),
(3,101,1),
(3,104,2),
(4,102,3);

-- Basic Queries.
-- Find the names and ages of all Students
select Sname,age from Students;

-- Find students whose age is greater than 20
select * from Students where age >20;

--  Find all courses with credits greater than 3
select * from Courses where credits > 3;

-- find students who belongs to grade A
select * from Students where grade='A';

-- Join Queries.
-- find the names of students who enrolled in any course
select S.Sid, S.Sname,C.Cname from Students S inner join Enrollments E on S.Sid=E.Sid inner join Courses C on E.Cid = C.Cid;

-- Find the names of students who enrolled in course 101
select S.Sname,C.Cid from Students S join Enrollments E on S.sid = E.Sid join Courses C on E.Cid = C.Cid where C.Cid =101;

-- Find the course names taken bu student Ravi
Select C.Cname from Courses C join Enrollments E on C.Cid = E.Cid join Students S on E.Sid = S.Sid where S.Sname= 'Ravi';
-- or
select C.Cname from Students S join Enrollments E on S.Sid = E.Sid join Courses C on E.Cid = C.Cid where S.Sname = 'Ravi';

-- find the names of Students who enrolled in DBMS
select S.Sname from Students S join Enrollments E on S.Sid = E.Sid join Courses C  on E.Cid = C.Cid where C.Cname = 'DBMS';

-- Advanced Queries 
-- find students who enrolled in both DBMS and OS
select S.Sname from Students S join Enrollments E on S.Sid = E.Sid join Courses C on E.Cid = C.Cid group by S.Sname having count(distinct C.Cname)=2;
-- or
select S.Sname from Students S join Enrollments E1 on S.Sid = E1.Sid join Courses C1 on E1.Cid = C1.Cid 
join Enrollments E2 on S.Sid = E2.Sid join Courses C2 on C2.Cid = E2.Cid where C1.Cname ='DBMS' and C2.Cname = 'OS';






