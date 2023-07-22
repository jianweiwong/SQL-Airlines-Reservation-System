-- create a database named IDB_Group_5_Group_Assignment
create database IDB_Group_5_Group_Assignment;

drop database IDB_Group_5_Group_Assignment;

-- using database IDB_Group_5_Group_Assignment
use IDB_Group_5_Group_Assignment;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Table Creation with Data Types using SQL Statements-----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- creating FlightAttendantCategory table 
create table FlightAttendantCategory(
FlightAttendantPosition nvarchar(50) Primary Key,
FlightAttendantSalary decimal(10,2) not null);

-- creating PilotCategory table 
create table PilotCategory(
PilotPosition nvarchar(50) Primary Key,
PilotSalary decimal(10,2) not null);

-- creating AirlineDetails table 
create table AirlineDetails(
AirlineID nvarchar(10) Primary Key,
AirlineName nvarchar(50) not null);

-- creating PilotDetails table
create table PilotDetails(
PilotID nvarchar(50) Primary Key,
PilotFirstName nvarchar(50) not null,
PilotLastName nvarchar(50) not null,
AirlineID nvarchar(10) not null Foreign Key References AirlineDetails(AirlineID),
PilotPosition nvarchar(50) not null Foreign Key References PilotCategory(PilotPosition),
PilotAge tinyint not null,
PilotYearOfExperience tinyint not null,
PilotFlyingHours int not null);

-- creating FlightAttendantDetails table
create table FlightAttendantDetails(
FlightAttendantID nvarchar(50) Primary Key,
FlightAttendantName nvarchar(100) not null,
FlightAttendantPhoneNo bigint not null,
AirlineID nvarchar(10) not null Foreign Key References AirlineDetails(AirlineID),
FlightAttendantPosition nvarchar(50) not null Foreign Key References FlightAttendantCategory(FlightAttendantPosition),
FlightAttendantAddress nvarchar(255) not null);

-- creating FlightDetails table
create table FlightDetails(
FlightNo nvarchar(50) Primary Key,
AirlineID nvarchar(10) not null Foreign Key References AirlineDetails(AirlineID),
BusinessSeatsTotal tinyint not null,
EconomySeatsTotal tinyint not null,
DepartureDate date not null,
DepartureTime time(0) not null,
ArrivalDate date not null,
ArrivalTime time(0) not null,
OriginState nvarchar(50) not null,
DestinationState nvarchar(50) not null);

-- creating PilotSchedule table (2 PK in one table)
create table PilotSchedule(
FlightNo nvarchar(50),
PilotID nvarchar(50),
Primary Key (FlightNo, PilotID));

-- adding Foreign Key to FlightNo of PilotSchedule table, to assign it as Composite PK 
alter table PilotSchedule
add Foreign Key (FlightNo) References FlightDetails(FlightNo);

-- adding Foreign Key to PilotID of PilotSchedule table, to assign it as Composite PK 
alter table PilotSchedule
add Foreign Key (PilotID) References PilotDetails(PilotID);

-- creating FlightAttendantSchedule table (2 PK in one table)
create table FlightAttendantSchedule(
FlightNo nvarchar(50),
FlightAttendantID nvarchar(50),
Primary Key (FlightNo, FlightAttendantID));

-- adding Foreign Key to FlightNo of FlightAttendantSchedule table, to assign it as Composite PK 
alter table FlightAttendantSchedule
add Foreign Key (FlightNo) References FlightDetails(FlightNo);

-- adding Foreign Key to FlightAttendantID of FlightAttendantSchedule table, to assign it as Composite PK 
alter table FlightAttendantSchedule
add Foreign Key (FlightAttendantID) References FlightAttendantDetails(FlightAttendantID);

-- creating CustomerDetails table
create table CustomerDetails(
CustomerID nvarchar(50) not null Primary Key,
CustomerFirstName nvarchar(50) not null,
CustomerLastName nvarchar(50) not null,
CustomerPhoneNo bigint,
CustomerEmail nvarchar(255),
CustomerAddress nvarchar(255) not null,
CustomerAddressState nvarchar(50) not null);

-- creating BookingDetails table
create table BookingDetails(
BookingNo int Primary Key,
CustomerID nvarchar(50) not null Foreign Key References CustomerDetails(CustomerID),
BookingState nvarchar(50) not null,
BookingDate date not null,
BookingTotal decimal(10,2) not null);

-- creating BookingFlightList table (2 PK in one table)
create table BookingFlightList(
BookingNo int,
FlightNo nvarchar(50),
NoOfSeatsBookedPerFlight tinyint not null,
TotalChargesPerFlight decimal(10,2) not null
Primary Key (BookingNo, FlightNo));

-- adding Foreign Key to BookingNo of BookingFlightList table, to assign it as Composite PK 
alter table BookingFlightList
add Foreign Key (BookingNo) References BookingDetails(BookingNo);

-- adding Foreign Key to FlightNo of BookingFlightList table, to assign it as Composite PK 
alter table BookingFlightList
add Foreign Key (FlightNo) References FlightDetails(FlightNo);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Data Insertion using SQL Statements---------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- insert values into AirlineDetails table
insert into AirlineDetails
(AirlineID, AirlineName) values
('CA8760', 'Core Airways'),
('EA1709', 'Echo Airline'),
('PA2098', 'Peak Airways'),
('SA1865', 'Spark Airways');

-- insert values into PilotCategory table
insert into PilotCategory
(PilotPosition, PilotSalary) values
('Senior Captain', 35000),
('Junior Captain', 20000),
('Senior Co-captain', 13000),
('Junior Co-captain', 9000);

-- insert values into FlightAttendantCategory table
insert into FlightAttendantCategory
(FlightAttendantPosition, FlightAttendantSalary) values
('Chief Flight Attendant', 9000),
('Senior Flight Attendant', 5000),
('Junior Flight Attendant', 3500);

-- insert values into PilotDetails table
insert into PilotDetails
(PilotID, PilotFirstName, PilotLastName, AirlineID, PilotPosition, 
PilotAge, PilotYearOfExperience, PilotFlyingHours) values
('P001','Mikael','Tinnason','CA8760','Senior Captain',41,11,48200),
('P002','Elton','Goh','CA8760','Junior Captain',37,6,19886),
('P003','John','Smith','CA8760','Senior Co-captain',36,6,25000),
('P004','Tonny','Scott','CA8760','Junior Co-captain',36,6,19367),
('P005','Richard','Jones','EA1709','Senior Captain',38,8,33530),
('P006','Paul','Sheldon','EA1709','Senior Co-captain',35,6,24980),
('P007','Adam','Martin','PA2098','Junior Captain',36,6,19023),
('P008','Eric','Hoekstra','PA2098','Junior Co-captain',36,5,14678),
('P009','Robert','William','PA2098','Senior Captain',40,8,34100),
('P010','Charles','Wood','PA2098','Senior Co-captain',37,7,33789),
('P011','Michael','Clarke','SA1865','Senior Captain',39,9,40500),
('P012','Anthony','Yang','SA1865','Junior Co-captain',35,5,14970);

-- insert values into FlightAttendantDetails table
insert into FlightAttendantDetails
(FlightAttendantID,FlightAttendantName,FlightAttendantPhoneNo,AirlineID,FlightAttendantPosition,FlightAttendantAddress) values
('FA001','Razak bin Osman',60182534383,'CA8760','Chief Flight Attendant','10, Jalan Pulai 21, Taman Pulai Utama, 89800 Beaufort, Sabah, Malaysia'),
('FA002','Celeste Foo',60111354566,'CA8760','Senior Flight Attendant','D-28-12, Parkhill Residence, Bukit Jalil,57000 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur, Malaysia'),
('FA003','Alex Tan',60111345687,'CA8760','Senior Flight Attendant','18, Jalan Bakti, Rapat Setia, 31350 Ipoh, Perak, Malaysia'),
('FA004','Cynthia Hannah',60189234666,'CA8760','Junior Flight Attendant','No.44, Jalan Desa Melur 4, Taman Bandar Melur, 56000 Cheras, Selangor, Malaysia'),
('FA005','Emma Ngo',60121983987,'EA1709','Chief Flight Attendant','28, Lorong Tiara 1a, Bandar Baru Klang, 41150 Klang, Selangor, Malaysia'),
('FA006','Charlie Madison',60116564321,'EA1709','Senior Flight Attendant','No.13 Jalan Persiaran Kemajuan, Taman Persiaran Bangi, 43650 Selangor, Malaysia'),
('FA007','Joe Adalyn',60187673123,'EA1709','Junior Flight Attendant','Lot 1682-P, Jalan Hospital, Cabang 4 Cherang, Kampung Dusun Raja, 15200 Kota Bharu, Kelantan, Malaysia'),
('FA008','Chloe Leong',60185565234,'PA2098','Chief Flight Attendant','No.33 Jalan P4/5, Taman Teknologi Kajang, 43500 Semenyih, Selangor, Malaysia'),
('FA009','Sophia Oliver',60189989323,'PA2098','Senior Flight Attendant','55, Jalan Sultan Ahmad Shah,10150 George Town, Pulau Pinang, Malaysia'),
('FA010','James Chou',60111923668,'PA2098','Junior Flight Attendant','3C 1St Floor, Jalan Tebrau, Kampung Wadihana, 80250 Johor Bahru, Johor, Malaysia'),
('FA011','Benjamin Lai',60127654566,'SA1865','Chief Flight Attendant','No.52, Jalan Jejaka, Maluri, 40000 Shah Alam,Selangor, Malaysia'),
('FA012','Henry Tseng',60189523544,'SA1865','Junior Flight Attendant','1, Jalan Margosa 1, Taman Bukit Margosa, 70400 Seremban, Negeri Sembilan, Malaysia'),
('FA013','Lucas Toh',60183456342,'SA1865','Junior Flight Attendant','No.16 Jalan Wawasan 2/15, Taman Sutera, 56000 Cheras, Selangor, Malaysia');

-- insert values into FlightDetails table
insert into FlightDetails
(FlightNo,AirlineID,BusinessSeatsTotal,EconomySeatsTotal,DepartureDate,DepartureTime,ArrivalDate,ArrivalTime,
OriginState,DestinationState) values
('CA001','CA8760',20,65,'2022-10-31','07:25','2022-10-31','10:55','Perak','Sarawak'),
('CA002','CA8760',20,65,'2022-10-31','08:00','2022-10-31','10:30','Sabah','Wilayah Persekutan Kuala Lumpur'),
('CA003','CA8760',25,60,'2022-11-02','12:00','2022-11-02','13:30','Wilayah Persekutan Kuala Lumpur','Negeri Sembilan'),
('CA004','CA8760',25,60,'2022-11-05','21:30','2022-11-05','23:30','Negeri Sembilan','Wilayah Persekutan Kuala Lumpur'),
('EA001','EA1709',20,65,'2022-11-08','10:00','2022-11-08','12:30','Wilayah Persekutan Kuala Lumpur','Sabah'),
('EA002','EA1709',20,65,'2022-11-11','13:30','2022-11-11','17:10','Sarawak','Pahang'),
('EA003','EA1709',25,60,'2022-11-14','14:45','2022-11-14','18:30','Pahang','Sarawak'),
('PA001','PA2098',20,65,'2022-11-17','14:00','2022-11-17','16:30','Wilayah Persekutan Kuala Lumpur','Sabah'),
('PA002','PA2098',30,60,'2022-11-20','21:00','2022-11-20','23:30','Sabah','Wilayah Persekutan Kuala Lumpur'),
('SA001','SA1865',20,65,'2022-11-23','04:00','2022-11-23','06:00','Wilayah Persekutan Kuala Lumpur','Sarawak'),
('SA002','SA1865',25,60,'2022-11-26','16:00','2022-11-26','18:00','Sarawak','Wilayah Persekutan Kuala Lumpur');

-- insert values into PilotSchedule table
insert into PilotSchedule
(FlightNo,PilotID) values
('CA001','P001'),
('CA001','P003'),
('CA002','P001'),
('CA002','P004'),
('CA003','P002'),
('CA003','P003'),
('CA004','P001'),
('CA004','P004'),
('EA001','P005'),
('EA001','P006'),
('EA002','P006'),
('EA002','P005'),
('EA003','P006'),
('EA003','P005'),
('PA001','P008'),
('PA001','P009'),
('PA002','P009'),
('PA002','P010'),
('SA001','P011'),
('SA001','P012'),
('SA002','P012'),
('SA002','P011');

-- insert values into FlightAttendantSchedule table
insert into FlightAttendantSchedule
(FlightNo,FlightAttendantID) values
('CA001','FA001'),
('CA001','FA002'),
('CA001','FA004'),
('CA002','FA001'),
('CA002','FA003'),
('CA002','FA004'),
('CA003','FA001'),
('CA003','FA002'),
('CA003','FA003'),
('CA004','FA001'),
('CA004','FA002'),
('CA004','FA003'),
('EA001','FA005'),
('EA001','FA006'),
('EA001','FA007'),
('EA002','FA005'),
('EA002','FA006'),
('EA002','FA007'),
('EA003','FA005'),
('EA003','FA006'),
('EA003','FA007'),
('PA001','FA008'),
('PA001','FA009'),
('PA001','FA010'),
('PA002','FA008'),
('PA002','FA009'),
('PA002','FA010'),
('SA001','FA011'),
('SA001','FA012'),
('SA001','FA013'),
('SA002','FA011'),
('SA002','FA012'),
('SA002','FA013');

-- insert values into CustomerDetails table
insert into CustomerDetails
(CustomerID, CustomerFirstName, CustomerLastName, CustomerPhoneNo, CustomerEmail, CustomerAddress, CustomerAddressState) values
('C30001','John','Smith',60126567757,'johnsmith@gmail.com','76, Jalan 8/3, Seksyen 8, 43650 Bandar Baru, Selangor, Malaysia','Selangor'),
('C30002','Melvin','Forbis',60187564841,'melvinforbis@gmail.com','45, Jalan Indah 61/25, Taman Bukit Indah, 81200 Johor Bahru, Johor, Malaysia','Johor'),
('C30003','Tom','Taylor',60165892475,'tomtaylor@yahoo.com','60, Jalan Keruing 66, Sejingkat, 93050 Kuching, Sarawak, Malaysia','Sarawak'),
('C30004','Olivia','Perry',60178473256,'oliviap@gmail.com','21, Jalan Bukit Tinggi, Bukit Tinggi, 28750 Bentong, Pahang, Malaysia','Pahang'),
('C30005','Susan','Lim',60191758063,'susanlim@outlook.my','56,Jalan SJ 3/6,Taman Seremban Jaya, 71450, Negeri Sembilan,Malaysia','Negeri Sembilan'),
('C30006','Joey','Tan',60124506480,'joeytan@gmail.com','75,Jalan Puncak Menara Gading 5,Taman Connaught, 56000 KL,Wilayah Persekutuan Kuala Lumpur, Malaysia','Wilayah Persekutuan Kuala Lumpur'),
('C30007','Nicole','Miller',60181563045,'nicolemiller@outlook.my','45,Jalan Bukit Jambul,Bukit Jambul,11900 Bayan Lepas,Pulau Pinang,Malaysia','Pulau Pinang'),
('C30008','Ernest','Hall',60191478500,'ernesthall@gmail.com','15,Jalan D1,Bukit Beruang,75450 Melaka,Malaysia','Melaka'),
('C30009','Jason','Wong',60116835452,'jasonwong@yahoo.com','1, Lebuh Kurau 5, Taman Chai Leng, 13700 Perai, Pulau Pinang, Malaysia','Pulau Pinang'),
('C30010','Natasha','Grey',60186845151,'natashagrey@gmail.com','10, Lorong Sungai Puloh 13c, Taman Sungai Puloh, 41200 Klang, Selangor, Malaysia','Selangor'),
('C30011','Alfred','Redfield',60195645522,'alfredredfield@gmail.com','77, Jalan Kampung, Cherating Lama, 26080 Balok, Pahang, Malaysia','Pahang');

-- insert values into BookingDetails table
insert into BookingDetails			
(BookingNo, CustomerID, BookingState, BookingDate, BookingTotal) values
(201,'C30001','Wilayah Persekutuan Kuala Lumpur','2022-10-10',720),
(202,'C30002','Selangor','2022-10-10',110),
(203,'C30003','Kedah','2022-10-10',80),
(204,'C30004','Johor','2022-10-10',890),
(205,'C30005','Johor','2022-10-10',100),
(206,'C30006','Sarawak','2022-10-18',110),
(207,'C30007','Pahang','2022-10-21',150),
(208,'C30001','Wilayah Persekutuan Kuala Lumpur','2022-10-21',110),
(209,'C30001','Wilayah Persekutuan Kuala Lumpur','2022-10-21',80),
(210,'C30002','Selangor','2022-10-21',70),
(211,'C30002','Selangor','2022-10-22',40),
(212,'C30003','Kedah','2022-10-23',110),
(213,'C30002','Selangor','2022-10-24',180),
(214,'C30003','Kedah','2022-10-24',70);

-- insert values into BookingFlightList table
insert into BookingFlightList
(BookingNo, FlightNo, NoOfSeatsBookedPerFlight, TotalChargesPerFlight) values
(201,'CA001',4,280),
(201,'SA001',4,160),
(201,'PA001',4,280),
(202,'SA001',1,40),
(202,'PA001',1,70),
(203,'CA002',2,80),
(204,'SA001',5,200),
(204,'EA003',5,200),
(204,'PA001',5,200),
(204,'CA004',5,290),
(205,'EA003',2,100),
(206,'CA004',2,110),
(207,'EA003',2,110),
(207,'EA001',1,40),
(208,'SA002',2,110),
(209,'EA002',2,80),
(210,'PA002',1,70),
(211,'SA002',1,40),
(212,'EA001',1,70),
(212,'EA002',1,40),
(213,'PA002',1,40),
(213,'SA002',2,140),
(214,'CA003',1,70);



select * from AirlineDetails;          -- AD
select * from PilotCategory;           -- PC
select * from FlightAttendantCategory; -- FAC
select * from PilotDetails;            -- PD
select * from FlightAttendantDetails;  -- FAD
select * from FlightDetails;           -- FD
select * from PilotSchedule;           -- PS
select * from FlightAttendantSchedule; -- FAS
select * from CustomerDetails;         -- CD
select * from BookingDetails;          -- BD
select * from BookingFlightList;       -- BFL


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SQL-Data Manipulation Language (DML)-------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Student 1 (Eunice)


-- 1.	Display the average of salary for pilots who have reached or exceeded 20,000 flying hours.
select 
	cast(avg(PC.PilotSalary) as decimal(10,2)) as 'Average Salary for Pilots (RM)'
from PilotCategory PC 
join PilotDetails PD 
on PC.PilotPosition = PD.PilotPosition
where PD.PilotFlyingHours >= 20000;

select * from PilotCategory



-- 2.	List the first name, last name, age, and experience of pilots who have piloted the flight for Spark Airways.
select 
	PD.PilotFirstName, PD.PilotLastName, 
	PD.PilotAge, PD.PilotYearOfExperience, AD.AirlineName
from PilotDetails PD 
join AirlineDetails AD 
on PD.AirlineID = AD.AirlineID
where AD.AirlineName = 'Spark Airways';



-- 3.	Find the Airline with the most number of flights. 

select 
	AirlineID, count(AirlineID) as NumberOfFlight 
from FlightDetails
group by AirlineID
having count(AirlineID) =
(
	select max(FlightsPerAirline) as MaxNumberOfFlight
	from
	(
		select AirlineID, count(AirlineID) as FlightsPerAirline from FlightDetails
		group by AirlineID
	) as AirlineNumberOfFlights
);


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Student 2 (Joo Cheng)


-- 1.	Display customer’s first name and last name who have made more than two bookings.
select 
	CustomerDetails.CustomerFirstName, CustomerDetails.CustomerLastName, count(CustomerDetails.CustomerID) as 'NoOfBookings'
from CustomerDetails 
join BookingDetails 
on CustomerDetails.CustomerID = BookingDetails.CustomerID
group by CustomerDetails.CustomerFirstName, CustomerDetails.CustomerLastName
having count(BookingDetails.CustomerID) > 2;


--no subquery
select 
	CustomerDetails.CustomerID, CustomerDetails.CustomerFirstName, CustomerDetails.CustomerLastName, count(BookingDetails.CustomerID)
from CustomerDetails 
inner join 
BookingDetails 
on CustomerDetails.CustomerID = BookingDetails.CustomerID
group by CustomerDetails.CustomerID, CustomerDetails.CustomerFirstName, CustomerDetails.CustomerLastName
having count(BookingDetails.CustomerID) > 2;


-- got subquery
select 
	CustomerDetails.CustomerID, CustomerDetails.CustomerFirstName, CustomerDetails.CustomerLastName, count(BookingDetails.CustomerID)
from CustomerDetails 
inner join 
BookingDetails 
on CustomerDetails.CustomerID = BookingDetails.CustomerID
where BookingDetails.CustomerID in
(
	select CustomerID from BookingDetails
	group by CustomerID
	
)
group by CustomerDetails.CustomerID, CustomerDetails.CustomerFirstName, CustomerDetails.CustomerLastName
having count(BookingDetails.CustomerID) > 2
;




-- 2.	List flight attendant’s full name and position who have worked in the same flight as a pilot named ‘Mikael Tinnason’.
select 
	FlightAttendantDetails.FlightAttendantID, FlightAttendantDetails.FlightAttendantName, 
	FlightAttendantDetails.FlightAttendantPosition, PilotDetails.PilotID, 
	PilotDetails.PilotFirstName, PilotDetails.PilotLastName
from FlightAttendantDetails 
join FlightAttendantSchedule
on FlightAttendantDetails.FlightAttendantID = FlightAttendantSchedule.FlightAttendantID
join PilotSchedule
on PilotSchedule.FlightNo = FlightAttendantSchedule.FlightNo
join PilotDetails
on PilotDetails.PilotID = PilotSchedule.PilotID
where PilotDetails.PilotFirstName = 'Mikael' and PilotDetails.PilotLastName = 'Tinnason'
group by FlightAttendantDetails.FlightAttendantName, FlightAttendantDetails.FlightAttendantPosition, FlightAttendantDetails.FlightAttendantID, 
PilotDetails.PilotID, PilotDetails.PilotFirstName, PilotDetails.PilotLastName




-- 3.	List all customers who did not live in any of the airline offices located. Please display the customer first name, last name, and customer’s state.
-- search in CustomerAddressState
select 
	CustomerDetails.CustomerFirstName, CustomerDetails.CustomerLastName,CustomerDetails.CustomerAddressState as 'CustomerState'
from CustomerDetails
where CustomerAddressState not in ('Perak', 'Negeri Sembilan', 'Pahang', 'Sabah', 'Sarawak' , 'Wilayah Persekutuan Kuala Lumpur');

-- search in CustomerAddress using not like '%__%'
select 
	CustomerDetails.CustomerFirstName, CustomerDetails.CustomerLastName,CustomerDetails.CustomerAddressState as 'CustomerState'
from CustomerDetails
where not (CustomerAddress like '%Perak%' or 
CustomerAddress like '%Negeri Sembilan%'or
CustomerAddress like '%Pahang%'or 
CustomerAddress like '%Sabah%'or 
CustomerAddress like '%Sarawak%' or
CustomerAddress like '%Wilayah Persekutuan Kuala Lumpur%')
;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Student 3 (Ru Ern)


-- 1.	Display the flight with the most number of seats for business class.

Select FlightNo, BusinessSeatsTotal from FlightDetails 
Group By FlightNo, BusinessSeatsTotal
Having BusinessSeatsTotal = 
(
Select max(BusinessSeatsTotal) as MaxBusinessSeats From FlightDetails
);


-- Detailed version
select *
from FlightDetails
group by FlightNo, AirlineID, BusinessSeatsTotal, EconomySeatsTotal, DepartureDate, 
DepartureTime, ArrivalDate, ArrivalTime, OriginState, DestinationState
having BusinessSeatsTotal in
(select max(BusinessSeatsTotal) as MaxBusinessSeatsTotal from FlightDetails);

-- Less-Detailed version
select FlightNo, BusinessSeatsTotal 
from FlightDetails 
group by FlightNo, BusinessSeatsTotal 
having BusinessSeatsTotal in 
(select max(BusinessSeatsTotal) as MaxBusinessSeatsTotal from FlightDetails);



-- 2.	List all customer’s first name and last name who did not place any booking. Sort the records by customer id in descending order.
Select * From CustomerDetails
Where CustomerDetails.CustomerID Not In
(
Select CustomerDetails.CustomerID From CustomerDetails
Inner Join 
BookingDetails On CustomerDetails.CustomerID = 
BookingDetails.CustomerID
)
Order By CustomerDetails.CustomerID DESC;


-- 3.	Show the AirlineID, AirlineName and the total number of flights for each Airline
Select 
AirlineDetails.AirlineID, AirlineDetails.AirlineName, COUNT(FlightDetails.AirlineID) as 'Total Number Of Flights For Each Airline'
From FlightDetails
Join
AirlineDetails
On FlightDetails.AirlineID = AirlineDetails.AirlineID
Group By AirlineDetails.AirlineID, AirlineDetails.AirlineName;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Student 4 (Jian Wei)


-- 1.	Find the highest salary of flight attendants.
select 
	FlightAttendantPosition, FlightAttendantSalary 
from FlightAttendantCategory
group by FlightAttendantPosition, FlightAttendantSalary
having FlightAttendantSalary =
(
	select
		max(FlightAttendantSalary) as HighestSalaryFlightAttendant 
	from FlightAttendantCategory
);



-- 2.	List the name and the position of flight attendants whose salary is neither 2,800 nor 3,500.
select 
	FAD.FlightAttendantName, FAD.FlightAttendantPosition, 
	FAC.FlightAttendantSalary  as  'Salary (RM)'
from FlightAttendantDetails as FAD 
join FlightAttendantCategory as FAC
on FAD.FlightAttendantPosition = FAC.FlightAttendantPosition
where FAC.FlightAttendantSalary not in (2800,3500);



-- 3.	Display customer’s first name and last name who have made the most number of booking.

select
	CD.CustomerID, CD.CustomerFirstName, CD.CustomerLastName, 
	count(BD.CustomerID) as NumOfBookingsMade
from BookingDetails as BD
inner join
CustomerDetails as CD
on BD.CustomerID = CD.CustomerID
group by CD.CustomerID, CD.CustomerFirstName, CD.CustomerLastName
having count(BD.CustomerID) in 
( 
	select MAX(NumOfBookingsMade1) as NumOfBookingsMade2
	from 
	( 
		select BD.CustomerID, count(BD.CustomerID) as NumOfBookingsMade1
		from BookingDetails as BD
		group by BD.CustomerID
	) as BookingDetailsSubQuery1
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Test Runs

select * from AirlineDetails;          -- AD
select * from PilotCategory;           -- PC
select * from FlightAttendantCategory; -- FAC
select * from PilotDetails;            -- PD
select * from FlightAttendantDetails;  -- FAD
select * from FlightDetails;           -- FD
select * from PilotSchedule;           -- PS
select * from FlightAttendantSchedule; -- FAS
select * from CustomerDetails;         -- CD
select * from BookingDetails;          -- BD
select * from BookingFlightList;       -- BFL

with abchabch as
(
select BFL1.*
from BookingFlightList as BFL1
group by BFL1.BookingNo, BFL1.FlightNo, BFL1.NoOfSeatsBookedPerFlight, BFL1.TotalChargesPerFlight
),

vfvfvf as
(
select BFL2.BookingNo, sum(TotalChargesPerFlight) as BookingTotalNewColumn
from BookingFlightList as BFL2
group by BFL2.BookingNo
)

select vfvfvf.BookingNo, abchabch.FlightNo, abchabch.NoOfSeatsBookedPerFlight, abchabch.TotalChargesPerFlight, BookingTotalNewColumn from abchabch inner join vfvfvf
on abchabch.BookingNo = vfvfvf.BookingNo;



select BookingFlightList.* , BookingTotal2
from BookingFlightList
where BookingTotal2 = (select sum(TotalChargesPerFlight) as BookingTotal2 from BookingFlightList group by BookingNo)
group by BookingFlightList.BookingNo, BookingFlightList.FlightNo, BookingFlightList.NoOfSeatsBookedPerFlight, BookingFlightList.TotalChargesPerFlight;

-- BookingNo and BookingTotal(calculated) column shown from BookingFlightList
select BookingFlightList.BookingNo , sum(TotalChargesPerFlight) as BookingTotal
from BookingFlightList
group by BookingFlightList.BookingNo;

-- show all columns from BookingFlightList and BookingTotal(not calculated)
select BookingFlightList.* , BookingDetails.BookingTotal
from BookingFlightList join BookingDetails on BookingFlightList.BookingNo = BookingDetails.BookingNo;


--show Flights between time1 and time2
select * from FlightDetails where DepartureTime between '10:00' and '22:00';
select * from FlightDetails;

-- 1.	Display the flight with the most number of seats for business class.
select 
	FlightNo, AirlineID, BusinessSeatsTotal, EconomySeatsTotal, DepartureDate, 
	cast(DepartureTime) as , ArrivalDate, ArrivalTime, OriginState, DestinationState
from FlightDetails
group by FlightNo, AirlineID, BusinessSeatsTotal, EconomySeatsTotal, DepartureDate, 
DepartureTime, ArrivalDate, ArrivalTime, OriginState, DestinationState
having BusinessSeatsTotal in
(select max(BusinessSeatsTotal) as MaxBusinessSeatsTotal from FlightDetails);  

-- format time output into hh:mm
select format(cast(DepartureTime as datetime), 'hh:mm') from FlightDetails;
select convert(char(5), DepartureTime , 108) from FlightDetails;






