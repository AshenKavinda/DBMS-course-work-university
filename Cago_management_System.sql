--DSE23.2F COURSEWORK NIBM------------------------------------------------------------------------
/*
Group Members:
GADSE232F-04 - S I A Kongahage
GADSE232F-11 - H A A K Hemarathna
GADSE232F-18 - S C A Jayawardana
GADSE232F-25 - Rifkan Naseen
GADSE232F-32 - D S Pramudith
*/



--Create database-------------------------------
create database Cago_management_System ;




--Create Tables---------------------------------

create table Harbour 
(
	HarbourID varchar(10) primary key check (HarbourID like 'H%') ,
	Harbour_Name varchar(60) not null ,
	H_Location varchar(100) not null
);

create table Department 
(
	DepartmentID varchar(10) primary key check (DepartmentID like 'D%' ) ,
	Department_Name varchar(60) not null ,
	H_ID varchar(10) foreign key (H_ID) references Harbour(HarbourID) 
	
);

create table Employee
(
	EmployeeID varchar(10) primary key check (EmployeeID like 'E%' ) ,
	Employee_Name varchar(60) not null ,
	Email varchar(60) not null check (Email like '%@%' ) ,
	Post varchar(60) not null ,
	Salary decimal(10,2) not null ,
	Dep_ID varchar(10) foreign key references Department(DepartmentID) not null
);

create table Phone
(
	EmpID varchar(10),
	Phone_NO int ,
	foreign key (EmpID) references Employee(EmployeeID) ,
	constraint PK_Phone primary key(EmpID,Phone_NO)
);


create table Dock
(
	DockID varchar(60) primary key check (DockID like 'DO%' ) ,
	D_Location varchar(100) not null ,
	Size int not null ,
	H_ID varchar(10) foreign key references Harbour(HarbourID) not null ,
	D_ID varchar(10) foreign key references Department(DepartmentID) not null

);


create table Cago
(
	CagoID varchar(60) primary key check (CagoID like 'C%' ) ,
	Destination varchar(100) not null ,
	Weigth varchar(10) not null check (Weigth like '%kg' ) ,
	Send_Date date not null ,
	Arival_Date date not null 

);

create table Ship
(
	ShipID varchar(60) primary key check (ShipID like 'S%' ) ,
	Size int not null ,
	Ship_Name varchar(60) not null

);

create table Cago_Operation
(
	DockID varchar(60) foreign key references Dock(DockID) ,	
	CagoID varchar(60) foreign key references Cago(CagoID) ,	
	ShipID varchar(60) foreign key references Ship(ShipID) ,
	Cago_Lord_date_time smalldatetime default getdate() ,
	Cago_Unlord_date_time smalldatetime default getdate() ,
	constraint PK_Cago_Operation
	primary key (DockID,CagoID,ShipID)

);

create table Ship_Operation
(
	ShipID varchar(60) foreign key references Ship(ShipID) , 
	DockID varchar(60) foreign key references Dock(DockID) ,
	Arrival_date_time smalldatetime default getdate() not null ,
	Departure_Date date not null ,
	Departure_time time not null ,
	constraint PK_Ship_Operation
	primary key(ShipID,DockID)

);

create table Sender
(
	SenderID varchar(60) primary key check (SenderID like 'S%' ) ,
	Sender_Name varchar(60) not null ,
	S_Address varchar(100) not null ,
	Phone_Number int not null ,
	Email varchar(60) not null check (Email like '%@%' ) ,
);

create table Recever
(
	ReceverID varchar(60) primary key check (ReceverID like 'R%' ) ,
	Recever_Name varchar(60) not null ,
	R_Address varchar(100) not null ,
	Phone_Number int not null ,
	Email varchar(60) not null check (Email like '%@%' ) ,
);

create table Cago_Item
(
	Tracking_Number varchar(60) primary key check (Tracking_Number like 'I%' ) ,
	Item_Type varchar(60) not null ,
	SenderID varchar(60) foreign key references Sender(SenderID) ,
	ReceverID varchar(60) foreign key references Recever(ReceverID) ,
	CagoID varchar(60) foreign key (CagoID) references Cago(CagoID) 
	
);




-------insert data------------------------------------------------------------

insert into Harbour (HarbourID,Harbour_Name,H_Location) 
values
		('H01',	'Colombo Port','Colombo'),
		('H02',	'Galle Port','Galle'),
		('H03',	'Trincomalee Port','Trincomalee'),
		('H04',	'Hambantota International Port','Hambantota'),
		('H05',	'Kankesanthurai Port','Kankesanthurai'),
		('H06',	'Oluvil Port','Oluvil'),
		('H07',	'Jaffna Port','Jaffna'),
		('H08',	'Pottuvil Port','Pottuvil'),
		('H09',	'kalpitiya Port','kalpitiya'),
		('H10',	'Negombo Port','Negombo');

insert into Department (DepartmentID,Department_Name,H_ID)
values	('D001','Colombo Managment','H01'),
		('D002','Colombo Security','H01'),
		('D003','Colombo Finance','H01'),
		('D004','Galle Managment','H02'),
		('D005','Galle Security','H02'),
		('D006','Galle Finance','H02'),
		('D007','Trincomalee Managment','H03'),
		('D008','Trincomalee Security','H03'),
		('D009','Trincomalee Finance','H03'),
		('D010','Hambantota Managment','H04'),
		('D011','Hambantota Security','H04'),
		('D012','Hambantota Finance','H04'),
		('D013','Kankesanthurai Managment','H05'),
		('D014','Kankesanthurai Security','H05'),
		('D015','Kankesanthurai Finance','H05'),
		('D016','Oluvil Managment','H06'),
		('D017','Oluvil Security','H06'),
		('D018','Oluvil Finance','H06'),
		('D019','Jaffna Managment','H07'),
		('D020','Jaffna Security','H07'),
		('D021','Jaffna Finance','H07'),
		('D022','Pottuvil Managment','H08'),
		('D023','Pottuvil Security','H08'),
		('D024','Pottuvil Finance','H08'),
		('D025','kalpitiya Managment','H09'),
		('D026','kalpitiya Security','H09'),
		('D027','kalpitiya Finance','H09'),
		('D028','Negombo Managment','H10'),
		('D029','Negombo Security','H10'),
		('D030','Negombo Finance','H10');


insert into Employee (EmployeeID,Employee_Name,Email,Post,Salary,Dep_ID) 
values          
		('E001','Sasindu_Chandupa','sasi123@gmail.com','manager','100000','D001'),
		('E002','Shanuka_Pasindu','shanu5683@gmail.com','security','50000','D002'),
		('E003','Shan_Abesingha','saabe555@gmail.com','officer','120000','D003'),
		('E004','Anudi_Ramini','anu5639@gmail.com','manager','100000','D011'),
		('E005','Thumula_Ubesiri','thumula03@gmail.com','cleaner','45000','D012'),
		('E006','niduli_nimesha','nini001@gmail.com','second_officer','90000','D018'),
		('E007','Kamal_Abesekara','kamal780@gmail.com','security','50000','D001'),
		('E008','Umeshi_Siriwardana','umeshi5555@gmail.com','manager','100000','D030'),
		('E009','Chanuka_Pamuda','chanu00@gmail.com','cleaner','45000','D009'),
		('E010','Amith_Lakshan','Amilak22@gmail.com','officer','120000','D010'),
		('E011','Uresha_Kankani','kanka258@gmail.com','cleaner','100000','D002'),
		('E012','Ashen_Pamith','ashen456@gmail.com','cleaner','45000','D028') ;


insert into Dock (DockID,D_Location,Size,H_ID,D_ID) 
values          
		('DOC01','Colombo',25000,'H01','D001'),
		('DOC02','Colombo',20000,'H01','D001'),
		('DOC03','Colombo',35000,'H01','D001'),
		('DOC04','Colombo',25000,'H01','D001'),

		('DOG01','Galle',14000,'H02','D004'),
		('DOG02','Galle',14000,'H02','D004'),
		('DOG03','Galle',14000,'H02','D004'),

		('DOT01','Trincomalee',36000,'H03','D007'),
		('DOT02','Trincomalee',20000,'H03','D007'),

		('DOH01','Hambantota',35000,'H04','D010'),
		('DOH02','Hambantota',35000,'H04','D010'),
		('DOH03','Hambantota',35000,'H04','D010'),

		('DOK01','Kankesanthurai',18000,'H05','D013'),
		('DOK02','Kankesanthurai',18000,'H05','D013'),
		('DOK03','Kankesanthurai',18000,'H05','D013'),

		('DOO01','Oluvil',25000,'H06','D016'),
		('DOO02','Oluvil',35000,'H06','D016'),
		('DOO03','Oluvil',35000,'H06','D016'),

		('DOJ01','Jaffna',33000,'H07','D019'),
		('DOJ02','Jaffna',33000,'H07','D019'),
		('DOJ03','Jaffna',33000,'H07','D019'),

		('DOP01','Pottuvil',50000,'H08','D022'),
		('DOP02','Pottuvil',20000,'H08','D022'),
		('DOP03','Pottuvil',30000,'H08','D022'),

		('DOKAL01','kalpitiya',14000,'H09','D025'),
		('DOKAL02','kalpitiya',20000,'H09','D025'),
		('DOKAL03','kalpitiya',20000,'H09','D025'),

		('DON01','Negombo',20000,'H10','D028'),
		('DON02','Negombo',20000,'H10','D028'),
		('DON03','Negombo',30000,'H10','D028');



insert into Ship (ShipID,Size,Ship_Name) 
values  
		('S001',1250,'Golden Seahorse'),
		('S002',1000,'Jade Jewel'),
		('S003',1230,'Crimson Sand'),
		('S004',850,'Sunset Symphony'),
		('S005',1050,'Blue Horizon'),
		('S006',1000,'Aurora Admiral'),
		('S007',900,'Pacific Dreamer'),
		('S008',7500,'Galactic Explorer'),
		('S009',1700,'Solar Sails'),
		('S010',450,'Titanic Triumph'),
		('S011',850,'Mystic Marlin'),
		('S012',2000,'Coral Compass'),
		('S013',1450,'Crimson Crest') ;


insert into Phone (EmpID, Phone_NO) 
values
    ('E001', 770123456),
    ('E001', 770789012),
    
    ('E002', 770345678),
    ('E002', 770901234),
    
    ('E003', 770567890),
    ('E003', 770123456),
    
    ('E004', 770789012),
    ('E004', 770345678),
    
    ('E005', 770901234),
    ('E005', 770567890),
    
    ('E006', 770123456),
    ('E006', 770789012),
    
    ('E007', 770345678),
    ('E007', 770901234),
    
    ('E008', 770567890),
    ('E008', 770123456),
    
    ('E009', 770789012),
    ('E009', 770345678),
    
    ('E010', 770901234),
    ('E010', 770567890),
    
    ('E011', 770123456),
    ('E011', 770789012),
    
    ('E012', 770345678),
    ('E012', 770901234);

INSERT INTO Ship_Operation (ShipID, DockID, Departure_Date, Departure_time) 
VALUES
    ('S001', 'DOH01', '2023-11-30', '19:35:16'),
    ('S002', 'DOG01', '2023-12-02', '16:55:44'),
    ('S003', 'DOT01', '2023-12-02', '05:05:32'),
    ('S004', 'DOH02', '2023-12-30', '14:20:57'),
    ('S005', 'DOK01', '2023-12-05', '09:35:52'),
    ('S006', 'DOO01', '2023-12-15', '00:21:44'),
    ('S007', 'DOJ01', '2023-12-11', '20:06:30'),
    ('S008', 'DOP01', '2023-12-20', '10:36:10'),
    ('S009', 'DOKAL01', '2023-12-08', '23:01:11'),
    ('S010', 'DON01', '2023-12-15', '09:19:18'),
    ('S011', 'DOH01', '2023-11-30', '12:54:46'),
    ('S012', 'DOG01', '2023-12-09', '04:14:41'),
    ('S013', 'DOT01', '2023-12-06', '04:19:38');

INSERT INTO Cago(CagoID, Destination, Weigth, Send_Date, Arival_Date)
VALUES 
('C001', 'New York', '50kg', '2023-01-15', '2023-01-20'),
('C002', 'London', '100kg', '2023-02-10', '2023-02-15'),
('C003', 'Tokyo', '80kg', '2023-03-05', '2023-03-10'),
('C004', 'Paris', '150kg', '2023-04-20', '2023-04-25'),
('C005', 'Sydney', '120kg', '2023-05-12', '2023-05-17'),
('C006', 'Los Angeles', '70kg', '2023-06-08', '2023-06-13'),
('C007', 'Berlin', '90kg', '2023-07-03', '2023-07-08'),
('C008', 'Beijing', '110kg', '2023-08-18', '2023-08-23'),
('C009', 'Mumbai', '60kg', '2023-09-10', '2023-09-15'),
('C010', 'Rio de Janeiro', '140kg', '2023-10-25', '2023-10-30'),
('C011', 'Toronto', '80kg', '2022-11-12', '2023-11-17'),
('C012', 'Dubai', '100kg', '2022-12-01', '2022-12-06'),
('C013', 'Moscow', '130kg', '2022-01-15', '2023-01-20'),
('C014', 'Cape Town', '70kg', '2022-02-10', '2023-02-15'),
('C015', 'Seoul', '90kg', '2022-03-05', '2023-10-10');

INSERT INTO Sender (SenderID, Sender_Name, S_Address, Phone_Number, Email)
VALUES 
('S001', 'Samantha Perera', '45 Galle Road, Colombo', '0771234567', 'samanthaperera@gmail.com'),
('S002', 'Dinesh Silva', '22 Kandy Street, Kandy', '0777654321', 'dineshsilva@gmail.com'),
('S003', 'Emily Johnson', '789 Oak Street, New York', '1234567890', 'emilyjohnson@yahoo.com'),
('S004', 'Ravi Fernando', '11 Jaffna Road, Jaffna', '0771112223', 'ravifernando@gmail.com'),
('S005', 'Shanika Bandara', '36 Nuwara Eliya Gardens, Nuwara Eliya', '0779998887', 'shanikabandara@gmail.com'),
('S006', 'Malinda Mendis', '15 Gampaha Avenue, Gampaha', '0774445556', 'malindamendis@gmail.com'),
('S007', 'Nimala Gunawardana', '5 Anuradhapura Lane, Anuradhapura', '0777776665', 'nimalagunawardana@gmail.com'),
('S008', 'John Smith', '456 Maple Street, London', '0876543210', 'johnsmith@yahoo.com'),
('S009', 'Geetha Rathnayake', '25 Batticaloa Road, Batticaloa', '0778889990', 'geetharathnayake@gmail.com'),
('S010', 'Harsha Kumara', '14 Kegalle Street, Kegalle', '0773334445', 'harshakumara@gmail.com'),
('S011', 'Ishara Dissanayake', '19 Ratnapura Gardens, Ratnapura', '0776665554', 'isharadissanayake@gmail.com'),
('S012', 'Alice Brown', '101 Elm St, Hamletville', '1112223333', 'alicebrown@yahoo.com'),
('S013', 'Pradeep Wickramasinghe', '32 Polonnaruwa Road, Polonnaruwa', '0779994441', 'pradeepwickrama@gmail.com'),
('S014', 'Kumudu Peiris', '55 Trincomalee Street, Trincomalee', '0771115559', 'kumudupeiris@gmail.com'),
('S015', 'David Green', '404 Cedar St, Uptown', '777666555', 'davidgreen@gmail.com');

INSERT INTO Recever (ReceverID, Recever_Name, R_Address, Phone_Number, Email)
VALUES 
('R001', 'Rebecca Johnson', '123 Main St, Cityville', '0771234567', 'rebeccajohnson@gmail.com'),
('R002', 'Richard Smith', '456 Oak St, Townsville', '0777654321', 'richardsmith@gmail.com'),
('R003', 'Rukmal Perera', '789 Pine St, Villagetown', '0775551234', 'rukmalperera@gmail.com'),
('R004', 'Rachel Fernando', '101 Elm St, Hamletville', '0771112223', 'rachelfernando@gmail.com'),
('R005', 'Rajitha Bandara', '202 Maple St, Countryside', '0779998887', 'rajithabandara@gmail.com'),
('R006', 'Ramani Mendis', '303 Birch St, Suburbia', '0774445556', 'ramanimendis@gmail.com'),
('R007', 'Rohan Gunawardana', '404 Cedar St, Uptown', '0777776665', 'rohangunawardana@gmail.com'),
('R008', 'Rehana Gray', '505 Walnut St, Downtown', '0772223334', 'rehanagray@gmail.com'),
('R009', 'Ruwini Rathnayake', '606 Cherry St, Riverside', '0778889990', 'ruwinirathnayake@gmail.com'),
('R010', 'Roshan Kumara', '707 Sycamore St, Lakeside', '0773334445', 'roshankumara@gmail.com'),
('R011', 'Rita Dissanayake', '808 Pineapple St, Mountainside', '0776665554', 'ritadissanayake@gmail.com'),
('R012', 'Rebecca Orange', '909 Banana St, Beachside', '0775554443', 'rebeccaorange@gmail.com'),
('R013', 'Roshan Wickramasinghe', '1010 Grape St, Hillside', '0779994441', 'roshanwickrama@gmail.com'),
('R014', 'Rukshani Peiris', '1111 Strawberry St, Clifftop', '0771115559', 'rukshanipeiris@gmail.com'),
('R015', 'Rayan Silver', '1212 Silver St, Valley', '0777778889', 'rayansilver@gmail.com');


INSERT INTO Cago_Item (Tracking_Number, Item_Type, SenderID, ReceverID, CagoID)
VALUES 
('I001', 'Electronics', 'S001', 'R001', 'C001'),
('I002', 'Clothing', 'S002', 'R002', 'C002'),
('I003', 'Books', 'S003', 'R003', 'C003'),
('I004', 'Furniture', 'S004', 'R004', 'C004'),
('I005', 'Toys', 'S005', 'R005', 'C005'),
('I006', 'Appliances', 'S006', 'R006', 'C006'),
('I007', 'Jewelry', 'S007', 'R007', 'C007'),
('I008', 'Sports Equipment', 'S008', 'R008', 'C008'),
('I009', 'Accessories', 'S009', 'R009', 'C009'),
('I010', 'Musical Instruments', 'S010', 'R010', 'C010'),
('I011', 'Stationery', 'S011', 'R011', 'C011'),
('I012', 'Shoes', 'S012', 'R012', 'C012'),
('I013', 'Food', 'S013', 'R013', 'C013'),
('I014', 'Artwork', 'S014', 'R014', 'C014'),
('I015', 'Cosmetics', 'S015', 'R015', 'C015'),
('I016', 'Electronics', 'S001', 'R001', 'C001'),
('I017', 'Clothing', 'S002', 'R002', 'C002'),
('I018', 'Books', 'S003', 'R003', 'C003'),
('I019', 'Furniture', 'S004', 'R004', 'C004'),
('I020', 'Toys', 'S005', 'R005', 'C005'),
('I021', 'Appliances', 'S006', 'R006', 'C006'),
('I022', 'Jewelry', 'S007', 'R007', 'C007'),
('I023', 'Sports Equipment', 'S008', 'R008', 'C008'),
('I024', 'Accessories', 'S009', 'R009', 'C009'),
('I025', 'Musical Instruments', 'S010', 'R010', 'C010'),
('I026', 'Stationery', 'S011', 'R011', 'C011'),
('I027', 'Shoes', 'S012', 'R012', 'C012'),
('I028', 'Food', 'S013', 'R013', 'C013'),
('I029', 'Artwork', 'S014', 'R014', 'C014'),
('I030', 'Cosmetics', 'S015', 'R015', 'C015'),
('I031', 'Electronics', 'S001', 'R001', 'C001'),
('I032', 'Clothing', 'S002', 'R002', 'C002'),
('I033', 'Books', 'S003', 'R003', 'C003'),
('I034', 'Furniture', 'S004', 'R004', 'C004'),
('I035', 'Toys', 'S005', 'R005', 'C005'),
('I036', 'Appliances', 'S006', 'R006', 'C006'),
('I037', 'Jewelry', 'S007', 'R007', 'C007'),
('I038', 'Sports Equipment', 'S008', 'R008', 'C008'),
('I039', 'Accessories', 'S009', 'R009', 'C009'),
('I040', 'Musical Instruments', 'S010', 'R010', 'C010'),
('I041', 'Stationery', 'S011', 'R011', 'C011'),
('I042', 'Shoes', 'S012', 'R012', 'C012'),
('I043', 'Food', 'S013', 'R013', 'C013'),
('I044', 'Artwork', 'S014', 'R014', 'C014'),
('I045', 'Cosmetics', 'S015', 'R015', 'C015'),
('I046', 'Electronics', 'S001', 'R001', 'C001'),
('I047', 'Clothing', 'S002', 'R002', 'C002'),
('I048', 'Books', 'S003', 'R003', 'C003'),
('I049', 'Furniture', 'S004', 'R004', 'C004'),
('I050', 'Toys', 'S005', 'R005', 'C005');


INSERT INTO Cago_Operation (DockID, CagoID, ShipID)
VALUES
	('DOH01', 'C001', 'S001'),
	('DOG01', 'C002', 'S002'),
	('DOT01', 'C003', 'S003'),
	('DOH02', 'C004', 'S004'),
	('DOK01', 'C005', 'S005'),
	('DOO01', 'C006', 'S006'),
	('DOJ01', 'C007', 'S007'),
	('DOP01', 'C008', 'S008'),
	('DOKAL01', 'C009', 'S009'),
	('DON01', 'C010', 'S010'),
	('DOH03', 'C011', 'S011'),
	('DOK02', 'C012', 'S012'),
	('DOO02', 'C013', 'S013'),
	('DOH01', 'C014', 'S011'),
	('DOK03', 'C015', 'S012');


--select all data from harbour table
select * 
from Harbour ;

--displaying the data of the ships which the size is greater than 1000m
select * 
from Ship
where Size >1000 ;

--displaying the data of the employees whoes the salary is greater than rs.55000 
select EmployeeID,Employee_Name,Salary
from Employee
where Salary >55000 ;

--displaying the count of items and cargo_type based on each cargo_type where number of item is greater than 3 
select count(Tracking_Number) As Number_of_item,Item_Type
from Cago_Item
group by Item_Type 
having count(Tracking_Number) > 3 ;

--displaying the count of employees working on each department using employee table and department table
select count(E.EmployeeID) , D.Department_Name
from Employee E 
inner join Department D on D.DepartmentID = E.Dep_ID
group by D.Department_Name 
having count(E.EmployeeID) > 1;

--displaying the cagoID,dock and harbour where the respective cargo is placed using Harbour,Dock and Cago_Operation tables
select H.Harbour_Name,D.DockID,CO.CagoID
from Harbour H 
inner join Dock D on H.HarbourID = D.H_ID 
inner join Cago_Operation CO on D.DockID = CO.DockID ;

--To get the details of unloading cargos from a ship to the dock
select D.DockID , D.D_Location , S.Ship_Name , CO.CagoID , CO.Cago_Unlord_date_time
from Cago_Operation CO
inner join Ship S on S.ShipID = CO.ShipID
inner join Dock D on D.DockID = CO.DockID ;

--displaying the shipID,Ship_name and dock location only for Trincomalee dock
select S.ShipID,S.Ship_Name,D.D_Location
from Ship S
inner join Ship_Operation SO on S.ShipID = SO.ShipID 
inner join Dock D on D.DockID = SO.DockID 
where SO.DockID in (select DockID from Ship_Operation where DockID like 'DOT%' );

--To get The tracking numbers and cargo id numbers related to all the food items
select C.CagoID,CI.Tracking_Number
from Cago C
inner join Cago_Item CI on C.CagoID = CI.CagoID 
where CI.Tracking_Number in (select Tracking_Number from Cago_Item where Item_Type = 'Food' );

--To create view table to displaying the data of the employees in management department.
--We use view to make virtual tables, for an example this view displayes the data of the employees in management department.
create view [Manegment_Employee] As
select E.Dep_ID ,D.Department_Name, E.Employee_Name
from Employee E
inner join Department D on E.Dep_ID = D.DepartmentID
where D.Department_Name like '% Managment' ;

select * from [Manegment_Employee] ;


--To create view table to displaying the data of items.
create view [Sri_Lanka_Items] As
select CI.Tracking_Number , CI.Item_Type , S.Sender_Name , S.Phone_Number As Sender_phone_No ,R.Recever_Name , R.Phone_Number As Recever_phone_No
from Cago_Item CI
inner join Sender S on S.SenderID = CI.SenderID
inner join Recever R on R.ReceverID = CI.ReceverID ;

select * from [Sri_Lanka_Items] ;

--pre created query for displaying data of employees.
create procedure select_all_employee as
begin 
	select * 
	from Employee
end ;

exec select_all_employee ;

--pre created query for displaying the data of items.
create procedure select_item_With_owners as
begin 
	select CI.Tracking_Number , CI.Item_Type , S.Sender_Name , S.Phone_Number As Sender_phone_No ,R.Recever_Name , R.Phone_Number As Recever_phone_No
	from Cago_Item CI
	inner join Sender S on S.SenderID = CI.SenderID
	inner join Recever R on R.ReceverID = CI.ReceverID ;
end ;

exec select_item_With_owners ;






