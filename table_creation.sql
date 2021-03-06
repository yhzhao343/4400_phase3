CREATE TABLE USER
(
Email           VARCHAR(40)         NOT NULL,
Username        VARCHAR(30)         NOT NULL,
Password        VARCHAR(30),
PRIMARY KEY(Username),
UNIQUE(Email));

CREATE TABLE CUSTOMER
(
Username        VARCHAR(30)      NOT NULL,
PRIMARY KEY (Username),
FOREIGN KEY (Username) REFERENCES USER(Username));

CREATE TABLE MANAGER
(
Username        VARCHAR(30)         NOT NULL,
PRIMARY KEY (Username),
FOREIGN KEY (Username) REFERENCES USER(Username));

CREATE TABLE SYSTEM_INFO
(
Cancellation_fee        DECIMAL(5,2)     NOT NULL,
Manager_password        VARCHAR(30),
Child_discount          DECIMAL(2,2),
Senior_discount     DECIMAL(2,2),
PRIMARY KEY (Cancellation_fee));

CREATE TABLE THEATER
(
Theater_id      INT         NOT NULL,
Name            VARCHAR(30),
Steet           VARCHAR(30),
City            VARCHAR(20),
State           VARCHAR(20),
Zip         VARCHAR(9),
PRIMARY KEY (Theater_id));

CREATE TABLE PREFERS
(
User            VARCHAR(30)     NOT NULL,
Tid             INT             NOT NULL,
PRIMARY KEY (User, Tid),
FOREIGN KEY (User) REFERENCES USER(Username),
FOREIGN KEY (Tid) REFERENCES THEATER(Theater_id));

CREATE TABLE MOVIE
(
Title           VARCHAR(50)     NOT NULL,
Release_date        DATE,
Rating          VARCHAR(5),
Length          DECIMAL(4,1),
Synopsis        TEXT,
Cast            TEXT,
PRIMARY KEY (Title));

CREATE TABLE REVIEW
(
Review_id       INT             NOT NULL,
Mtitle          VARCHAR(50)     NOT NULL,
User            VARCHAR(30)     NOT NULL,
Title           VARCHAR(255)        NOT NULL,
Rating          INT             NOT NULL,
Comment     TEXT,
PRIMARY KEY (Review_id),
FOREIGN KEY (User) REFERENCES USER(Username));

CREATE TABLE PLAYS_AT
(
Mtitle          VARCHAR(50) NOT NULL,
Tid         INT             NOT NULL,
Playing         BOOLEAN     NOT NULL,
PRIMARY KEY (Mtitle, Tid),
FOREIGN KEY (Mtitle) REFERENCES MOVIE(Title),
FOREIGN KEY (Tid) REFERENCES THEATER(Theater_id));

CREATE TABLE SHOWTIME
(
Tid         INT         NOT NULL,
Mtitle          VARCHAR(50)     NOT NULL,
Showtime        TIMESTAMP       NOT NULL,
PRIMARY KEY (Tid, Mtitle, Showtime),
FOREIGN KEY (Tid) REFERENCES THEATER(Theater_id),
FOREIGN KEY (Mtitle) REFERENCES MOVIE(Title));

CREATE TABLE PAYMENT_INFO
(
Card_number     CHAR(12)        NOT NULL,
User            VARCHAR(30)         NOT NULL,
Saved           BOOLEAN     NOT NULL,
Cvv         VARCHAR(4)      NOT NULL,
Expiration_date DATE            NOT NULL,
Name_on_card    VARCHAR(40) NOT NULL,
PRIMARY KEY (Card_number),
FOREIGN KEY (User) REFERENCES USER(Username));

CREATE TABLE ORDERS
(
Order_id        INT             NOT NULL,
User            VARCHAR(30)     NOT NULL,
Cno             CHAR(12)        NOT NULL,
Mtitle          VARCHAR(50)     NOT NULL,
Tid             INT             NOT NULL,
Date            DATE            NOT NULL,
Time            TIME            NOT NULL,
Status          VARCHAR(9)      NOT NULL,
Adult_tickets       INT             NOT NULL,
Child_tickets       INT         NOT NULL,
Senior_tickets      INT         NOT NULL,
PRIMARY KEY (Order_id),
FOREIGN KEY (User) REFERENCES USER(Username),
FOREIGN KEY (Cno) REFERENCES PAYMENT_INFO(Card_number),
FOREIGN KEY (Mtitle) REFERENCES MOVIE(Title),
FOREIGN KEY (Tid) REFERENCES THEATER(Theater_id));