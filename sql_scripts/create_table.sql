USE VaccineDB;

DROP TABLE IF EXISTS Certification;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Vaccination;
DROP TABLE IF EXISTS Works;
DROP TABLE IF EXISTS Storages;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Vaccine;
DROP TABLE IF EXISTS Schedules;

CREATE TABLE Patient
	(CPR		    	INT(10),
	 patient_name		VARCHAR(128),
	 address			VARCHAR(128),
	 PRIMARY KEY(CPR)
	);

CREATE TABLE Location
	(
	 city  				VARCHAR(128),
     address  			VARCHAR(128),
     PRIMARY KEY(city, address)
	);

CREATE TABLE Vaccine
	(
	 vaccine_name  		VARCHAR(128),
     price  			DECIMAL(4,2),
     PRIMARY KEY(vaccine_name)
	);

CREATE TABLE Employee
	(
	 employee_id  		INT(10),
     employee_name  	VARCHAR(128),
	 title  			VARCHAR(128),
	 wage  				INT(10),
     PRIMARY KEY(employee_id)
	);

CREATE TABLE Schedules
	(
	 schedule_id  				INT(10),
     schedule_date  			DATE,
     schedule_timestart  	TIME,
     schedule_timeend		TIME,
     PRIMARY KEY(schedule_id)
	);



CREATE TABLE Certification
	(
	 certification_id  	INT(10),
     certification_date DATE,
     certification_time TIME,
     vaccine_name  		VARCHAR(128),
     employee_id  		INT(10),
     PRIMARY KEY(certification_id),
	 FOREIGN KEY(vaccine_name) REFERENCES Vaccine(vaccine_name) ,
	 FOREIGN KEY(employee_id) REFERENCES Employee(employee_id)
	);



CREATE TABLE Appointment
	(appointment_id		INT(10),
     CPR              INT(10),
     city  				VARCHAR(128),
     address  			VARCHAR(128),
     appointment_date  	DATE,
     appointment_time  	TIME,
	 PRIMARY KEY(appointment_id),
     FOREIGN KEY(CPR) REFERENCES Patient(CPR),
	 FOREIGN KEY(city, address) REFERENCES Location(city, address)
	);

CREATE TABLE Vaccination
	(
	 vaccination_id     	INT(10),
	 vaccination_date  	DATE,
     vaccination_time  	TIME,
     CPR		    	        INT(10),
	 vaccine_name  		VARCHAR(128),
     employee_id  		    INT(10),
     PRIMARY KEY(vaccination_id),
	 FOREIGN KEY(CPR) REFERENCES Patient(CPR),
	 FOREIGN KEY(vaccine_name) REFERENCES Vaccine(vaccine_name),
	 FOREIGN KEY(employee_id) REFERENCES Employee(employee_id)
	);

CREATE TABLE Storages
	(
	 city  				VARCHAR(128),
     address  			VARCHAR(128),
     vaccine_name  		VARCHAR(128),
     amount  			INT(10),
     PRIMARY KEY(city, address, vaccine_name),
	 FOREIGN KEY(city, address) REFERENCES Location(city, address) ,
	 FOREIGN KEY(vaccine_name) REFERENCES Vaccine(vaccine_name)
	);

CREATE TABLE Works
	(
	 schedule_id  		INT(10),
	 employee_id  		INT(10),
	 city  				VARCHAR(128),
     address  			VARCHAR(128),
     PRIMARY KEY(schedule_id, employee_id, city, address),
	 FOREIGN KEY(schedule_id) REFERENCES Schedules(schedule_id) ,
	 FOREIGN KEY(employee_id) REFERENCES Employee(employee_id),
	 FOREIGN KEY(city, address) REFERENCES Location(city, address)
	);

