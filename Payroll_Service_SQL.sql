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
 
 --UC11-Create ER diagram
 drop table Employee_Payroll;

 create table Company
 (
  CompanyID int identity primary key,
  CompanyName VARCHAR(100)
 );
 insert into Company values('WIPRO'),('TCS');
 select * from Company;

 create table Employee
(
EmployeeID INT IDENTITY (1,1) PRIMARY KEY,
CompanySelect INT,
EmployeeName VARCHAR(20) NOT NULL,
Gender CHAR(1) NOT NULL,
PhoneNo BIGINT,
EmployeeAddress VARCHAR(150),
StartDate DATE NOT NULL,
FOREIGN KEY (CompanySelect) REFERENCES Company(CompanyID)
 )

 SELECT * FROM Employee;

 INSERT INTO Employee
VALUES
(1,'Nikita','F',1234567890,'Mulaj','2022/01/01'),
(1,'Mahi','F',7777777777,'pune','2022-02-02'),
(2,'Ashish','M',9999999999,'solapur','2022-03-03'),
(2,'Amit','M',8888888888,'omerga','2022-04-04');

SELECT * FROM Employee;

CREATE TABLE Payroll
(
BasicPay FLOAT, 
Deductions FLOAT, 
TaxablePay FLOAT,
IncomeTax FLOAT,
NetPay FLOAT,
EmployeeSelect INT,
FOREIGN KEY (EmployeeSelect) REFERENCES Employee(EmployeeID)
);
SELECT * FROM Payroll


INSERT INTO Payroll(BasicPay,Deductions,IncomeTax,EmployeeSelect)
VALUES
(4000000,10000,2000,1),
(5000000,20000,3000,2),
(6000000,30000,2500,3),
(7000000,40000,5000,4);

UPDATE Payroll SET TaxablePay = (BasicPay - Deductions);
UPDATE Payroll SET NetPay = (TaxablePay - IncomeTax);
SELECT * FROM Payroll

CREATE TABLE Department
(
DepartmentID INT IDENTITY (1,1) PRIMARY KEY,
DepartmentName VARCHAR(30)
);

INSERT INTO Department(DepartmentName) VALUES ('Sales'),('Marketing');
SELECT * FROM Department;

CREATE TABLE EmployeeDepartment
(
EmployeeSelect INT,
DepartmentSelect INT,
FOREIGN KEY (EmployeeSelect) REFERENCES Employee(EmployeeID),
FOREIGN KEY (DepartmentSelect) REFERENCES Department(DepartmentID)
);
SELECT * FROM EmployeeDepartment

--UC12 Retrieving data for Previous UC
SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,Gender,PhoneNo,EmployeeAddress,StartDate,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,DepartmentName
FROM Company
INNER JOIN Employee ON Company.CompanyID = Employee.CompanySelect
INNER JOIN Payroll ON Payroll.EmployeeSelect = Employee.EmployeeID
INNER JOIN EmployeeDepartment ON EmployeeDepartment.EmployeeSelect = Employee.EmployeeID
INNER JOIN Department ON Department.DepartmentID = EmployeeDepartment.DepartmentSelect

--Retrieving Payroll Data with Specific Employee Name
SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,Gender,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay
FROM Company
INNER JOIN Employee ON Employee.CompanySelect = Company.CompanyID AND Employee.EmployeeName = 'Nikita'
INNER JOIN Payroll ON Payroll.EmployeeSelect = Employee.EmployeeID

--Retrieving Data from a range of Date
SELECT CompanyID,CompanyName,EmployeeID,EmployeeName,Gender,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay
FROM Company
INNER JOIN Employee ON Company.CompanyID = Employee.CompanySelect AND StartDate BETWEEN CAST('2022-01-01' AS DATE) AND GETDATE()
INNER JOIN Payroll ON Payroll.EmployeeSelect = Employee.EmployeeID;