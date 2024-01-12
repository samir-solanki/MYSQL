################page-7#########################


# 1. display all information in the table EMP & DEPT
select *
from hr.employees, hr.departments;

# 2. display only hire date & emp name for each employee
select hire_date, first_name, last_name
from hr.employees;

# 3. display ename with concatenated with job id, seperated by coma & space and name the column employee & title
select concat(first_name, "_", job_id) as EmployeeandTitle
from hr.employees;

# 4. hire date, name & dep number of all clerks
select hire_date, first_name, last_name, department_id, job_id
from hr.employees
where job_id like "%CLERK";

# 5. Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT
select concat(first_name,"_",last_name,"_",email,"_",phone_number,"_",hire_date,"_",job_id,"_",salary)
from hr.employees;

# 6. name & salary of all emp with salary > 2000
select first_name, last_name, salary
from hr.employees
where salary > 2000
order by salary asc;

# 7. Display the names and dates of employees with the column headers "Name" and "Start Date"
select concat(first_name, " ", last_name) as Name, hire_date as Start_Date
from hr.employees;

# 8. Display the names and hire dates of all employees in the order they were hired. 
select first_name, hire_date
from hr.employees
order by hire_date;

# 9. Display the names and salaries of all employees in reverse salary order.
select first_name, salary
from hr.employees
order by salary desc;

# 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order. 
select concat(first_name,"_",last_name)as ename, department_id,salary
from hr.employees
where commission_pct is not null
order by salary desc;

# 11. Display the last name and job title of all employees who do not have a manager 
select last_name,job_id
from hr.employees
where manager_id is null;

# 12. Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000
select last_name, job_id, salary
from hr.employees
where job_id = "SA_REP" or job_id = "ST_CLERK" and salary not in (2500,3500,5000)
order by salary;

---------------------------------------------------------------------------------------------------------------------------------------------------
################page-8#########################


# 1) Display the maximum, minimum and average salary and commission earned.
select max(salary), min(salary),avg(salary)
from hr.employees;

select max(commission_pct), min(commission_pct),avg(commission_pct)
from hr.employees;

# 2) Display the department number, total salary payout and total commission payout for each department.
select department_id, sum(salary), sum(commission_pct)
from hr.employees
group by department_id;

# 3) Display the department number and number of employees in each department.
select department_id,count(employee_id)
from hr.employees
group by department_id;

# 4) Display the department number and total salary of employees in each department.
select department_id, sum(salary)
from hr.employees
group by department_id;

# 5) Display the employee's name who doesn't earn a commission. Order the result set without using the column name
select first_name
from hr.employees
where commission_pct is null;


# 6) Display the employees name, department id and commission. If an Employee doesn't earn the commission, then display as 'No commission'. Name the columns appropriately
select first_name,department_id,
case when commission_pct is null then 'No Commission'
else commission_pct
end 'commission_PCT'
from hr.employees;

# 7) Display the employee's name, salary and commission multiplied by 2. If an Employee 
# doesn't earn the commission, then display as 'No commission. Name the columns appropriately
select concat(first_name,"_",last_name) as employee_name, salary,
case when commission_pct is null then "No Commission"
else (commission_pct*2)
end COMMISSION
from hr.employees;

# 8) Display the employee's name, department id who have the first name same as another employee in the same department
select first_name, department_id, count(*)
from hr.employees
group by first_name,department_id
having count(*) > 1;

# 9) Display the sum of salaries of the employees working under each Manager. 
select manager_id,sum(salary)
from hr.employees
group by manager_id;

# 10) Select the Managers name, the count of employees working under and the department ID of the manager.
select man.employee_id, man.department_id, count(emp.employee_id)
from hr.employees as man join hr.employees as emp on man.employee_id = emp.manager_id
group by man.employee_id;

# 11) Select the employee name, department id, and the salary. Group the result with the 
# manager name(correction-employee name) and the employee last name should have second letter 'a! 
select concat(first_name,"_", last_name) as employee_name, department_id, salary
from hr.employees
where last_name like"_a%";

# 12) Display the average of the salaries and group the result with the department id. 
# Order the result with the department id - ???
select avg(salary)
from hr.employees
group by department_id
union
select sum(salary)
from hr.employees
group by department_id;

# 13) Select the maximum salary of each department along with the department id.
select departments.department_name,departments.department_id,max(salary)
from hr.employees join hr.departments
using (department_id)
group by employees.department_id;

# 14) Display the commission, if not null display 10% of salary, if null display a default value 1.
select first_name,
case when commission_pct is not null then (salary*10/100)
else '1'
end COMMISSION
from hr.employees;

----------------------------------------------------------------------------------------------------------------------------------------------
################page-9#########################


# 1. Write a query that displays the employee's last names only from the string's 2-5th 
# position with the first letter capitalized and all other letters lowercase, Give each column an appropriate label.
select concat(upper(substring(last_name,2,1)),"",substring(last_name,3,length(last_name))) as Last_name
from hr.employees;

#2. Write a query that displays the employee's first name and last name along with a " in 
# between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the 
# month on which the employee has joined.
select concat(first_name,"_", last_name), hire_date
from hr.employees
where first_name like "%_a_%" and last_name like "%_a_%";

# 3. Write a query to display the employee's last name and if half of the salary is greater than 
# ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of 
# 1500 each. Provide each column an appropriate label. 
select last_name, salary,
case when (salary/2 > 10000) then (salary+(salary*10/100)+1500)
else (salary+(salary*11.5/100)+1500)
end Gross_Salary
from hr.employees;

# 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, 
# department id, salary and the manager name all in Upper case, if the Manager name 
# consists of 'z' replace it with '$!
select concat(rpad(substring(e.employee_id,1,2), 4,'00'), rpad(substring(e.employee_id,3,3),2,'E')) as E_ID, e.department_id, 
e.salary,replace(upper(m.first_name), 'Z', '$')
from hr.employees as e join hr.employees as m on m.employee_id = e.manager_id;

# 5. Write a query that displays the employee's last names with the first letter capitalized and 
# all other letters lowercase, and the length of the names, for all employees whose name 
# starts with J, A, or M. Give each column an appropriate label. Sort the results by the employees' last names 
select first_name, concat(upper(substring(last_name,1,1)), lower(substr(last_name,2,length(last_name)))) as Last_Name, length(last_name)
from hr.employees
where first_name like "J%" or first_name like "A%" or first_name like "M%"
order by last_name;

# 6. Create a query to display the last name and salary for all employees. Format the salary to 
# be 15 characters long, left-padded with $. Label the column SALARY 
select last_name, lpad(round(salary),15, '$') as SALARY
from hr.employees;

# 7. Display the employee's name if it is a palindrome
select first_name,
case when first_name = reverse(first_name) then 'palindrome'
else null
end Palindrome
from hr.employees;

# 8. Display First names of all employees with initcaps
select concat(upper(substring(first_name,1,1)),lower(substring(first_name,2,length(first_name)))) as First_Name
from hr.employees;

# 9. From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column.
select substring_index(substring_index(street_address," ",2)," ",-1)
from hr.locations;

# 10. Extract first letter from First Name column and append it with the Last Name. Also add 
# "@systechusa.com" at the end. Name the column as e-mail address. All characters should 
# be in lower case. Display this along with their First Name.
select first_name, concat(lower(substring(first_name,1,1)),lower(last_name),"@systechusa.com") as Email_Address
from hr.employees;

# 11. Display the names and job titles of all employees with the same job as Trenna(correction-Southlake).
select emp.first_name, jobs.job_title
from hr.jobs join hr.employees as emp using(job_id) join hr.departments using(department_id) join hr.locations using(location_id)
where city like "Southlake";

# 12. Display the names and department name of all employees working in the same city as Trenna(correction-Toronto). 
select emp.first_name, departments.department_name
from hr.employees as emp join hr.departments using(department_id) join hr.locations using(location_id)
where city like "Toronto";

# 13. Display the name of the employee whose salary is the lowest.
select first_name, last_name, salary
from hr.employees
where salary = (select min(salary) from hr.employees);

# 14. Display the names of all employees except the lowest paid.
select first_name, last_name, salary
from hr.employees
where salary > (select min(salary) from hr.employees)
order by salary;

----------------------------------------------------------------------------------------------------------------------------------------------
################page-10#########################


# 1. Write a query to display the last name, department number, department name for all employees. 
select employees.last_name, employees.department_id, departments.department_name
from hr.employees join hr.departments
using (department_id);

# 2. Create a unique list of all jobs that are in department 4(correction-40). Include the location of the department in the output. 
select employees.job_id, employees.department_id, locations.*
from hr.employees join hr.departments using (department_id) right join hr.locations using (location_id)
where department_id = 40;

# 3. Write a query to display the employee last name,department name,location id and city of all employees who earn commission. 
select employees.last_name, departments.department_name, locations.location_id, locations.city
from hr.employees join hr.departments using(department_id) join hr.locations using(location_id)
where commission_pct is not null
order by last_name;

# 4. Display the employee last name and department name of all employees who have an 'a' in their last name
select employees.last_name, departments.department_name
from hr.employees join hr.departments using (department_id)
where last_name like "%a%";

# 5. Write a query to display the last name,job,department number and department name for all employees who work in ATLANTA(correction-London).
select employees.last_name, employees.department_id, departments.department_name
from hr.employees join hr.departments using(department_id) join hr.locations using(location_id)
where city like "London";

# 6. Display the employee last name and employee number along with their manager's last name and manager number.
select man.last_name as employee_name, man.employee_id, man.manager_id, emp.last_name as manager_name
from hr.employees as emp join hr.employees as man on emp.employee_id = man.manager_id;

# 7. Display the employee last name and employee number along with their manager's last 
# name and manager number (including the employees who have no manager)
select man.last_name as employee_name, man.employee_id, man.manager_id, emp.last_name as manager_name
from hr.employees as emp right join hr.employees as man on emp.employee_id = man.manager_id;

# 8. Create a query that displays employees last name,department number,and all the employees who work in the same department as a given employee. 
select last_name, department_id
from hr.employees
order by department_id;

# 9. Create a query that displays the name,job,department name,salary,grade for all 
# employees. Derive grade based on salary(>=50000=A, >=30000=B,<30000=C)  
select emp.first_name, emp.last_name, emp.job_id, departments.department_name, emp.salary,
case when salary >= 50000 then "A"
when salary >=30000 then "B"
else "C"
end Salary_Grade
from hr.employees as emp join hr.departments using (department_id)
order by salary desc;

# 10. Display the names and hire date for all employees who were hired before their 
# managers along withe their manager names and hire date. Label the columns as Employee 
# name, emp_hire_date,manager name,man_hire_date
select concat(man.first_name,"_", man.last_name) as Employee_name, man.hire_date as emp_hire_date, concat(emp.first_name,"_", emp.last_name) as manager_name, emp.hire_date as man_hire_date
from hr.employees as emp join hr.employees man on emp.employee_id = man.manager_id
where man.hire_date < emp.hire_date;

----------------------------------------------------------------------------------------------------------------------------------------------
################page-12#########################


# 1. Write a query to display the last name and hire date of any employee in the same department as SALES. 
select emp.last_name, emp.hire_date
from hr.employees as emp join hr.departments using (department_id)
where department_name like "sales";

# 2. Create a query to display the employee numbers and last names of all employees who 
# earn more than the average salary. Sort the results in ascending order of salary. 
select employee_id, last_name, salary
from hr.employees
where salary > (select avg(salary) from hr.employees)
order by salary;

#3. Write a query that displays the employee numbers and last names of all employees who 
# work in a department with any, employee whose last name contains a' u 
select employee_id, last_name
from hr.employees
where department_id is not null and last_name like"%u%";

# 4. Display the last name, department number, and job ID of all employees whose department location is ATLANTA(correction-Seatlle).
select employees.last_name, employees.department_id,employees.job_id
from hr.employees join hr.departments using(department_id) join hr.locations using(location_id)
where city like "Seattle";

# 5. Display the last name and salary of every employee who reports to FILLMORE(correction-Toronto).
select emp.last_name, emp.salary
from hr.employees as emp join hr.departments using(department_id) join hr.locations using(location_id)
where city like "Toronto";

# 6. Display the department number, last name, and job ID for every employee in the OPERATIONS department(correction-Sales). 
select emp.department_id, emp.last_name, emp.job_id
from hr.employees as emp join hr.departments using (department_id)
where department_name like "Sales";
### no employees are working in this department ###

# 7. Modify the above query to display the employee numbers, last names, and salaries of all 
# employees who earn more than the average salary and who work in a department with any employee with a 'u'in their name. 
select emp.employee_id, emp.last_name, emp.salary
from hr.employees as emp join hr.departments using (department_id)
where department_id is not null and salary > (select avg(salary) from hr.employees) and first_name like"%u%";

# 8. Display the names of all employees whose job title is the same as anyone in the sales dept. 
select first_name, last_name
from hr.employees
where job_id like "SA%";

# 9. Write a compound query to produce a list of employees showing raise percentages, 
# employee IDs, and salaries. Employees in department 10 and 30 are given a 5% raise, 
# employees in department 20 are given a 10% raise, employees in departments 40 and 50 are 
# given a 15% raise, and employees in department 60 are not given a raise. 
select employee_id, salary, department_id,
case when department_id = 10 and 30 then '5%'
when department_id = 20 then '10%'
when department_id = 40 and 50 then '15%'
when department_id = 60 then 'none'
end raise_persantage
from hr.employees
order by department_id;

# 10. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries. 
select last_name, salary
from hr.employees
order by salary desc
limit 3;

# 11. Display the names of all employees with their salary and commission earned. Employees 
# with a null commission should have O in the commission column 
select first_name, last_name, salary,
case when commission_pct is null then '0'
else commission_pct
end COMMISSION
from hr.employees;

# 12. Display the Managers (name) with top three salaries along with their salaries and department information.
select emp.manager_id, man.salary, man.department_id, man.first_name
from hr.employees as emp join hr.employees as man on man.employee_id = emp.manager_id
group by man.employee_id
order by salary desc
limit 3;

----------------------------------------------------------------------------------------------------------------------------------------------
################page-13#########################


# 1) Find the date difference between the hire date and resignation_date for all the 
# employees. Display in no. of days, months and year(1 year 3 months 5 days).
# Emp_ID Hire Date Resignation_Date
# 1 1/1/2000 7/10/2013
# 2 4/12/2003 3/8/2017
# 3 22/9/2012 21/6/2015
# 4 13/4/2015 NULL
# 5 03/06/2016 NULL
# 6 08/08/2017 NULL
# 7 13/11/2016 NULL 

create table empdata
(
emp_id int,
hire_date date,
resignation_date date
);

insert into empdata value (1, '2000-01-01', '2013-10-07');
insert into empdata value (2, '2003-12-04', '2017-08-03');
insert into empdata value (3, '2012-09-22', '2015-06-21');
insert into empdata value (4, '2015-04-13', Null);
insert into empdata value (5, '2016-06-03', Null);
insert into empdata value (6, '2017-08-08', Null);
insert into empdata value (7, '2016-11-13', Null);

select floor(datediff(resignation_date, hire_date)/365) as "Years",
floor(datediff(resignation_date, hire_date)%365/30) as "Months",
datediff(resignation_date, hire_date)%365%30 as "Days"
from hr.empdata;

# 2) Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd, 
# yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900) 
select date_format(hire_date, "%m-%d-%Y")as Hire_Date, 
case when resignation_date is not null then  date_format(resignation_date, "%M-%D-%Y") 
else 'DEC, 01th 1900'
end Resignation_date
from hr.empdata;

# 3) Calcuate experience of the employee till date in Years and months(example 1 year and 3 months) 
select emp_id,
case when resignation_date is not null then concat(floor(datediff(resignation_date, hire_date)/365), "Years","_",
floor(datediff(resignation_date, hire_date)%365/30), "Months","_",
datediff(resignation_date, hire_date)%365%30, "Days")
else concat(floor(datediff(curdate(), hire_date)/365), "Years","_",
floor(datediff(curdate(), hire_date)%365/30), "Months","_",
datediff(curdate(), hire_date)%365%30, "Days")
end as Experience_Duration
from hr.empdata;


