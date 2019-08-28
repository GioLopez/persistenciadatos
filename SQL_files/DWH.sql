CREATE DATABASE  IF NOT EXISTS `DWH` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `DWH`;

create table if not exists DIM_Products
(
	productKey int auto_increment
		primary key,
	productCode varchar(15) not null,
	productName varchar(70) not null,
	productLine int not null,
	textDescription varchar(4000) null,
	productScale varchar(10) not null,
	productVendor varchar(50) not null,
	buyPrice decimal(10,2) not null,
	MSRP decimal(10,2) not null
);

create table if not exists DIM_customers
(
	customerKey int not null
		primary key,
	customerNumber int not null,
	customerName varchar(50) not null,
	customerLastName varchar(50) not null,
	customerFirstName varchar(50) not null,
	phone varchar(50) not null,
	addressLine1 varchar(50) not null,
	addressLine2 varchar(50) null,
	city varchar(50) not null,
	estate varchar(50) null,
	postalCode varchar(15) null,
	country varchar(50) not null,
	salesRepEmployeeNumber int null,
	creditLimit decimal(10,2) null
);

create table if not exists DIM_offices
(
	officeKey int auto_increment
		primary key,
	officeCode int not null,
	city varchar(50) not null,
	phone varchar(50) not null,
	addressLine1 varchar(50) not null,
	addressLine2 varchar(50) null,
	state varchar(50) null,
	country varchar(50) not null,
	postalCode varchar(15) not null,
	territory varchar(10) not null
);

create table if not exists DIM_employees
(
	employeeKey int auto_increment
		primary key,
	employeeNumber int not null,
	lastName varchar(50) not null,
	firstName varchar(50) not null,
	email varchar(100) not null,
	officekey int null,
	extension varchar(10) null,
	reportsTo int default 0 null,
	jobTitle varchar(50) default 'salesRep' not null,
	constraint DIM_employees_DIM_offices_officeKey_fk
		foreign key (officekey) references DIM_offices (officeKey)
);

create table if not exists DIM_time
(
	dateKey int not null
		primary key,
	year int not null,
	month varchar(10) not null,
	day varchar(10) not null,
	quarter int not null,
	halfYear int not null,
	FullDateDescription varchar(100) not null
);

create table if not exists FACT_Sales
(
	salesNumber int auto_increment
		primary key,
	orderDateKey int not null,
	requiredDateKey int not null,
	shippedDateKey int null,
	status varchar(15) not null,
	comments text null,
	customerKey int not null,
	productKey int not null,
	quantityOrdered int not null,
	priceEach decimal(10,2) not null,
	constraint FACT_Sales_DIM_Products_productKey_fk
		foreign key (productKey) references DIM_Products (productKey),
	constraint FACT_Sales_DIM_customers_customerKey_fk
		foreign key (customerKey) references DIM_customers (customerKey),
	constraint FACT_Sales_DIM_time_dateKey_fk
		foreign key (orderDateKey) references DIM_time (dateKey),
	constraint FACT_Sales_DIM_time_dateKey_fk_2
		foreign key (requiredDateKey) references DIM_time (dateKey),
	constraint FACT_Sales_DIM_time_dateKey_fk_3
		foreign key (shippedDateKey) references DIM_time (dateKey)
);

create table if not exists FACT_calls
(
	callKey int auto_increment
		primary key,
	employeeKey int not null,
	customerKey int not null,
	productKey int not null,
	dateKey int not null,
	text varchar(200) not null,
	constraint FACT_calls_DIM_Products_productKey_fk
		foreign key (productKey) references DIM_Products (productKey),
	constraint FACT_calls_DIM_customers_customerKey_fk
		foreign key (customerKey) references DIM_customers (customerKey),
	constraint FACT_calls_DIM_employees_employeeKey_fk
		foreign key (employeeKey) references DIM_employees (employeeKey),
	constraint FACT_calls_DIM_time_dateKey_fk
		foreign key (dateKey) references DIM_time (dateKey)
);

