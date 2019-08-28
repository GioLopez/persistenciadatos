CREATE DATABASE  IF NOT EXISTS `ODS` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ODS`;

create table customers
(
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
	creditLimit decimal(10,2) null,
	constraint customers_customerNumber_uindex
		unique (customerNumber)
);

alter table customers
	add primary key (customerNumber);

create table offices
(
	officeCode int not null
		primary key,
	city varchar(50) not null,
	phone varchar(50) not null,
	addressLine1 varchar(50) not null,
	addressLine2 varchar(50) null,
	state varchar(50) null,
	country varchar(50) not null,
	postalCode varchar(15) not null,
	territory varchar(10) not null
);

create table employees
(
	employeeNumber int not null,
	lastName varchar(50) not null,
	firstName varchar(50) not null,
	email varchar(100) not null,
	officeCode int null,
	extension varchar(10) null,
	reportsTo int default 0 null,
	jobTitle varchar(50) default 'salesRep' not null,
	constraint employees_employeeNumber_uindex
		unique (employeeNumber),
	constraint fk_employees_offices
		foreign key (officeCode) references offices (officeCode)
);

alter table employees
	add primary key (employeeNumber);

create table orders
(
	orderNumber int not null
		primary key,
	orderDate date not null,
	requiredDate date not null,
	shippedDate date null,
	status varchar(15) not null,
	comments text null,
	customerNumber int not null,
	constraint orders_ibfk_1
		foreign key (customerNumber) references customers (customerNumber)
);

create index customerNumber
	on orders (customerNumber);

create table payments
(
	customerNumber int not null,
	checkNumber varchar(50) not null,
	paymentDate date not null,
	amount decimal(10,2) not null,
	primary key (customerNumber, checkNumber),
	constraint payments_ibfk_1
		foreign key (customerNumber) references customers (customerNumber)
);

create table productlines
(
	productLineNumber int not null
		primary key,
	productLine varchar(50) not null,
	textDescription varchar(4000) null,
	htmlDescription mediumtext null,
	image mediumblob null
);

create table products
(
	productCode varchar(15) not null,
	productName varchar(70) not null,
	productLineNumber int not null,
	productScale varchar(10) not null,
	productVendor varchar(50) not null,
	productDescription text not null,
	quantityInStock smallint(6) not null,
	buyPrice decimal(10,2) not null,
	MSRP decimal(10,2) not null,
	constraint products_productCode_uindex
		unique (productCode),
	constraint products_productlines_productLineNumber_fk
		foreign key (productLineNumber) references productlines (productLineNumber)
);

alter table products
	add primary key (productCode);

create table customers_products
(
	customerNumber int not null,
	productCode varchar(15) not null,
	primary key (customerNumber, productCode),
	constraint fk_customers_has_products_customers1
		foreign key (customerNumber) references customers (customerNumber),
	constraint fk_customers_has_products_products1
		foreign key (productCode) references products (productCode)
);

create table customer_calls
(
	employeeNumber int not null,
	customerNumber int not null,
	productCode varchar(15) not null,
	text varchar(200) not null,
	date datetime not null,
	primary key (employeeNumber, customerNumber, productCode),
	constraint fk_customer_calls_customers_products1
		foreign key (customerNumber, productCode) references customers_products (customerNumber, productCode),
	constraint fk_customer_calls_employees1
		foreign key (employeeNumber) references employees (employeeNumber)
);

create index fk_customer_calls_customers_products1_idx
	on customer_calls (customerNumber, productCode);

create index fk_customer_calls_employees1_idx
	on customer_calls (employeeNumber);

create index fk_customers_has_products_customers1_idx
	on customers_products (customerNumber);

create index fk_customers_has_products_products1_idx
	on customers_products (productCode);

create table orderdetails
(
	orderNumber int not null,
	productCode varchar(15) not null,
	quantityOrdered int not null,
	priceEach decimal(10,2) not null,
	orderLineNumber smallint(6) not null,
	primary key (orderNumber, productCode),
	constraint orderdetails_ibfk_1
		foreign key (orderNumber) references orders (orderNumber),
	constraint orderdetails_ibfk_2
		foreign key (productCode) references products (productCode)
);

create index productCode
	on orderdetails (productCode);

