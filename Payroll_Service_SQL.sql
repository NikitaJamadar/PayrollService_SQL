--UC1-Creating databse
create database Payroll_Service;

--UC2-Create table
create table Employee_Payroll
(
EmployeeId INT IDENTITY(1,1),
EmployeeName VARCHAR(30) NOT NULL,
Salary float Not null,
StartDate DATE NOT NULL
);

--UC3 Inserting Values into Table
INSERT INTO Employee_Payroll(EmployeeName,Salary,StartDate)
VALUES
('Bill',1000000,'2018/01/01'),
('Terisa',2000000,'2019/01/01'),
('Charlie',3000000,'2020/01/01');

--UC4-Retrievieving employee payroll data
select * from Employee_Payroll

--UC5-Retrive data for particular table
select Salary from Employee_Payroll where EmployeeName='Bill';
select * from Employee_Payroll where  StartDate BETWEEN CAST('2018/01/01' AS DATE) AND GETDATE();

--UC6-Add gender in employee payroll table
alter table Employee_Payroll add Gender char(1);
update Employee_Payroll set Gender='M' where EmployeeName='Bill' or EmployeeName='Charlie';
update Employee_Payroll set Gender='F' where EmployeeName='Terisa';

--UC7-Find sum,avg, min, max,number of male and female employees
select SUM(Salary) as Sumofsalary from Employee_Payroll;
select Avg(Salary) as Avgofsalary from Employee_Payroll;
select MIN(Salary) as Minofsalary from Employee_Payroll;
select MAX(Salary) as Maxofsalary from Employee_Payroll;
select count(EmployeeId) from Employee_Payroll;
select count(EmployeeId) as NoOfPeople,Gender from Employee_Payroll group by Gender;

select * from Employee_Payroll;

--UC8- Extend table to store information like employee phone, address and department
ALTER TABLE Employee_Payroll ADD PhoneNo int  ;
ALTER TABLE Employee_Payroll ADD Address varchar(250) not null default 'India';
ALTER TABLE Employee_Payroll ADD Department varchar(250) not null default 'Developer';
select * from Employee_Payroll;

--UC9-extend employee payroll table to have basic pay, deductions,taxable pay,income tax,net pay
ALTER TABLE Employee_PayRoll ADD Deduction bigint,Taxable_Pay float,Income_Tax float,Net_Pay float;

--UC10-Adding Department of Terisa as Sales & Marketing Both
update Employee_Payroll SET Department = 'Sales' Where EmployeeName = 'Terisa';
insert into Employee_Payroll
values
('Terisa',2000000,'2022-03-21','F','1234567890','INDIA','Marketing',0.00,0.00,0.00,4000000)
 
