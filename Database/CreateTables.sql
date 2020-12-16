/********************************
CPSC 4910 PROJECT DATABASE
CREATED BY: NOAH RIGSBY
TEACHER: ROGER VAN SCOY
GROUP 4
DESCRIPTION: THIS SECTION CREATES
THE DATABASE TABLES
********************************/
SET FOREIGN_KEY_CHECKS=0;

/*DBUSER TABLE*/
CREATE TABLE DBUSER
(
DBuser_ID int NOT NULL,
User_Password varchar(100) NOT NULL,
Created_Date varchar(100) NOT NULL,
Updated_Date varchar(100) NOT NULL,
PRIMARY KEY (DBuser_ID)
);

/*SPONSOR TABLE*/
CREATE TABLE SPONSOR
(
id int NOT NULL,
Company_Name varchar(100) NOT NULL,
Comp_Address varchar(100) NOT NULL,
Point_Value DOUBLE NOT NULL,
Payment_Method varchar(100) NOT NULL,
Payment_Numb bigint NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES DBUSER(DBuser_ID)
);

/*DRIVER TABLE*/
CREATE TABLE DRIVER
(
id int NOT NULL,
Driver_Name varchar(100) NOT NULL,
Employee_Number int NOT NULL,
Driver_Address varchar(100) NOT NULL,
Driver_Points DOUBLE NOT NULL,
Driver_Rate DOUBLE NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (id) REFERENCES DBUSER(DBuser_ID)
);

/*ADMINISTRATOR TABLE*/
CREATE TABLE ADMINISTRATOR
(
Auser_ID int NOT NULL,
Admin_Name varchar(100) NOT NULL,
Admin_Email varchar(100) NOT NULL,
Admin_Phone BIGINT(10) unsigned  NOT NULL,
PRIMARY KEY (Auser_ID),
FOREIGN KEY (Auser_ID) REFERENCES DBUSER(DBuser_ID)
);

/*AWARDED TABLE*/
CREATE TABLE AWARDED
(
Point_Total int NOT NULL,
Date_Added varchar(100) NOT NULL,
Suser_ID int NOT NULL,
Duser_ID int NOT NULL,
PRIMARY KEY (Suser_ID,Duser_ID),
FOREIGN KEY (Duser_ID) REFERENCES DRIVER(id),
FOREIGN KEY (Suser_ID) REFERENCES SPONSOR(id)
);

/*PURCHASE TABLE*/
CREATE TABLE PURCHASE
(
Purchase_ID int NOT NULL,
Purchase_Total DOUBLE NOT NULL,
Status varchar(100) NOT NULL,
Created_Date varchar(100) NOT NULL,
Updated_Date varchar(100) NOT NULL,
PRIMARY KEY (Purchase_ID)
);

/*APPLICATION TABLE*/
CREATE TABLE APPLICATION
(
Application_ID int NOT NULL,
Status varchar(100) NOT NULL,
User_Number int NOT NULL,
PRIMARY KEY (Application_ID)
);

/*CATALOG TABLE*/
CREATE TABLE CATALOG
(
Catalog_Name varchar(100) NOT NULL,
Spon_ID INT NOT NULL,
PRIMARY KEY (Catalog_Name)
/*FOREIGN KEY (Spon_ID) REFERENCES SPONSOR(id)*/
);

/*CATEGORIES TABLE*/
CREATE TABLE CATEGORIES
(
Category_Name varchar(100) NOT NULL,
Cat_Name varchar(100) NOT NULL,
PRIMARY KEY (Category_Name),
FOREIGN KEY(Cat_Name) REFERENCES CATALOG(Catalog_Name)
);

/*GOODBEHAVIORAPP TABLE*/
CREATE TABLE GOODBEHAVIORAPP
(
App_Name varchar(100) NOT NULL,
PRIMARY KEY (App_Name)
);

/*PRODUCTS TABLE*/
CREATE TABLE PRODUCTS
(
Product_Name varchar(100) NOT NULL,
Price_Total DOUBLE NOT NULL,
Description varchar(100) NOT NULL,
Availability varchar(100) NOT NULL,
Image varchar(100) NOT NULL, /*MAY NEED TO CHANGE THIS LATER*/
Point_Value int NOT NULL,
Cate_Name varchar(100) NOT NULL,
Product_ID int NOT NULL,
PRIMARY KEY (Product_ID),
FOREIGN KEY(Cate_Name) REFERENCES CATEGORIES(Category_Name)
);

/*USERTYPE TABLE*/
CREATE TABLE USERTYPE
(
Users_Type varchar(100) NOT NULL,
Tuser_ID int NOT NULL,
PRIMARY KEY(Users_Type, Tuser_ID),
FOREIGN KEY(Tuser_ID) REFERENCES DBUSER(DBuser_ID)
);

/*OPERATION TABLE*/
CREATE TABLE OPERATION
(
Operation_ID varchar(100) NOT NULL,
Description varchar(500) NOT NULL,
PRIMARY KEY (Operation_ID)
);

/*CONTAINS TABLE*/
CREATE TABLE CONTAINS
(
Quantity int NOT NULL,
Prod_ID int NOT NULL,
Purchase_ID int NOT NULL,
PRIMARY KEY (Prod_ID, Purchase_ID),
FOREIGN KEY (Prod_ID) REFERENCES PRODUCTS(Product_ID),
FOREIGN KEY (Purchase_ID) REFERENCES PURCHASE(Purchase_ID)
);

/*SELECTRULES TABLE*/
CREATE TABLE SELECTRULES
(
Rule_ID int NOT NULL,
PRIMARY KEY (Rule_ID)
);

CREATE TABLE OLDPRICES
(
  Product_Name VARCHAR(100) NOT NULL,
  Price_Total DOUBLE NOT NULL,
  PRIMARY key (Product_Name)
);

CREATE TABLE OLDSTATUS
(
  Product_Name VARCHAR(100) NOT NULL,
  Availability VARCHAR(100) NOT NULL,
  PRIMARY key (Product_Name)
);

/*PRODUCTS TABLE*/
CREATE TABLE OLDADMIN
(
  Auser_ID int NOT NULL,
  Admin_Name varchar(100) NOT NULL,
  Admin_Email varchar(100) NOT NULL,
  Admin_Phone BIGINT(10) unsigned  NOT NULL,
  PRIMARY KEY (Auser_ID),
  FOREIGN KEY (Auser_ID) REFERENCES DBUSER(DBuser_ID)
);

CREATE TABLE CREATES
(
  P_ID int NOT NULL,
  D_ID int NOT NULL,
  PRIMARY KEY (P_ID, D_ID),
  FOREIGN KEY (P_ID) REFERENCES PURCHASE(Purchase_ID),
  FOREIGN KEY (D_ID) REFERENCES DRIVER(id)
);

CREATE TABLE SECUREDFOR
(
  Users_Type varchar(100) NOT NULL,
  OP_ID varchar(100) NOT NULL,
  PRIMARY KEY (Users_Type, OP_ID),
  FOREIGN KEY (Users_Type) REFERENCES USERTYPE(Users_Type),
  FOREIGN KEY (OP_ID) REFERENCES OPERATION(Operation_ID)
);

CREATE TABLE REVIEWS
(
  S_ID int NOT NULL,
  App_ID int NOT NULL,
  PRIMARY KEY (S_ID, App_ID),
  FOREIGN KEY (S_ID) REFERENCES SPONSOR(id),
  FOREIGN KEY (App_ID) REFERENCES APPLICATION(Application_ID)
);

CREATE TABLE QUALIFIESFOR
(
  R_ID int NOT NULL,
  Prod_ID int NOT NULL,
  PRIMARY KEY (R_ID, Prod_ID),
  FOREIGN KEY (R_ID) REFERENCES SELECTRULES(Rule_ID),
  FOREIGN KEY (Prod_ID) REFERENCES PRODUCTS(Product_ID)
);

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE EMPLOYS
(
  Employs_ID int NOT NULL AUTO_INCREMENT,
  Sponsors_ID int NOT NULL,
  Drivers_ID int NOT NULL,
  DRIVER_POINTS DOUBLE NOT NULL,
  PRIMARY KEY(Employs_ID),
  FOREIGN KEY (Sponsors_ID) REFERENCES SPONSOR(id),
  FOREIGN KEY (Drivers_ID) REFERENCES DRIVER(id)
);

CREATE TABLE ASSIGNS
(
  Spon_ID INT NOT NULL,
  Driv_ID INT NOT NULL,
  AD_ID INT NOT NULL,
  PRIMARY KEY(Spon_ID, Driv_ID, AD_ID),
  FOREIGN KEY (Spon_ID) REFERENCES SPONSOR(id),
  FOREIGN KEY(Driv_ID) REFERENCES DRIVER(id),
  FOREIGN KEY(Ad_ID) REFERENCES ADMINISTRATOR(Auser_ID)

);

CREATE TABLE SWITCHES
(
    Sponsors_ID int NOT NULL,
    Drivers_ID int NOT NULL,
    PRIMARY KEY(Sponsors_ID, Drivers_ID),
    FOREIGN KEY (Sponsors_ID) REFERENCES SPONSOR(id),
    FOREIGN KEY (Drivers_ID) REFERENCES DRIVER(id)
);

CREATE TABLE OWNS
(
    Prod_ID int NOT NULL,
    Sponsor_ID int NOT NULL,
    PRIMARY KEY(Sponsor_ID, Prod_ID),
    FOREIGN KEY (Sponsor_ID) REFERENCES SPONSOR(id),
    FOREIGN KEY (Prod_ID) REFERENCES PRODUCTS(Product_ID)
);
