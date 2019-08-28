# DWH

## Facts

Base on the DWH recommendation some fields of the source database tables where mix in a single fact table  
Base on the information got in source databases the team define that two facts will be used calls and sales.

### Calls

It has the following colums:

1. callKey
2. employeeKey
3. customerKey
4. productKey
5. dateKey
6. text

Wich will be related as show in picture with name DWH.png

#### Calls DIMs

1. DIM_employees
1.1 DIM_offices
2. DIM_Customers
3. DIM_Products
4. DIM_time

### Sales

This table contain the following colums:

1. salesNumber
2. orderDateKey
3. requiredDateKey
4. shippedDateKey
5. status
6. comments
7. customerKey
8. productKey
9. quantityOrdered
10. priceEach

#### Sales DIMS

1. DIM_employees
1.1 DIM_offices
2. DIM_Customers
3. DIM_Products
4. DIM_time
