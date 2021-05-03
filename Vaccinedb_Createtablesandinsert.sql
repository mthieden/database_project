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
	(CPR		    	BIGINT(10),
	 patient_name		VARCHAR(128),
	 patient_address			VARCHAR(128),
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
     CPR              BIGINT(10),
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
     CPR		    	        BIGINT(10),
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

INSERT Patient VALUES
('2003721021','Mars Aries','Mars Lane 1'),
('2007959041','Thor Hammer','Mjollnir Parken 420'),
('1901201213','Diogenes Plankton','Olympensvej 3'),
('1512931519','Spongebob Squarepants', 'Godtgemt 52'),
('1808851214','Afrodite Love', 'Spurgt 12'),
('1912992238','Artemis Omega', 'Australiensvej 13'),
('1111961219','Ares Warsaw', 'Selenitgade 98'),
('1302770209','Apollo Message', 'Krystalvej 7'),
('2003923132','Nike Victorious', 'Sylviavej 22'),
('1208981414','Nemesis Noname', 'Langgade 14'),
('1703880266','Hera Goddess', 'Pepperonivej 63'),
('1711992232','Demeter Harvest', 'Modern Italian Vej 10'),
('1503001111','Poseidon Light', 'Delfingade 233'),
('1207692318','Athena Flower', 'Eden Grdens 111');

INSERT Location VALUES
('Copenhagen','Jagtvej 25'),
('Naksskov','Frederiksvej 12'),
('Odense','Fedgade 15'),
('Aarhus','Langtvæk 123'),
('Horsens','Dabdabvej 69');

INSERT Vaccine VALUES
('divoc',50.00),
('blast3000',22.50),
('aspera',99.50),
('covaxx',25.00);

INSERT Employee VALUES
('1','Dwight Schute','Doctor','350'),
('2','Jim Halpert','Nurse','200'),
('3','Michael Scott','Laborant','250'),
('4','Pam Beasly','Surgeon','400'),
('5','Andy Bernard','Doctor','380'),
('6','Michael Anderson','Doctor','360'),
('7','Robert California','Doctor','300'),
('8','Angela Martin','Paramedic','400');

INSERT Schedules VALUES
('1','2021-01-25','120000','190000'),
('2','2021-03-06','080000','220000'),
('3','2021-05-28','090000','150000'),
('4','2021-12-08','100000','160000'),
('5','2021-08-10','120000','220000'),
('6','2021-03-25','090000','160000'),
('7','2021-05-06','080000','160000'),
('8','2021-07-28','100000','200000'),
('9','2022-02-08','110000','190000'),
('10','2021-10-10','120000','180000');

INSERT Certification VALUES
('1','2020-03-22','120000','divoc','4'),
('2','2020-04-02','080000','blast3000','3'),
('3','2020-12-07','090000','aspera','2'),
('4','2020-05-03','100000','aspera','1'),
('5','2020-08-17','120000','covaxx','5'),
('6','2020-01-10','100000','aspera','6'),
('7','2020-01-10','120000','blast3000','7'),
('8','2020-04-09','110000','divoc','8'),
('9','2020-04-20','100000','covaxx','3');

INSERT Appointment VALUES
('1','2003721021','Copenhagen','Jagtvej 25','2021-01-25','150000'),
('2','2007959041','Naksskov','Frederiksvej 12','2021-03-06','120000'),
('3','1901201213','Odense','Fedgade 15','2021-05-28','133000'),
('4','1512931519','Aarhus','Langtvæk 123','2021-12-08','140000'),
('5','1808851214','Horsens','Dabdabvej 69','2021-08-10','151500'),
('6','1912992238','Copenhagen','Jagtvej 25','2021-01-25','121500'),
('7','1111961219','Copenhagen','Jagtvej 25','2021-01-25','131500'),
('8','1302770209','Aarhus','Langtvæk 123','2021-12-08','113000'),
('9','2003923132','Odense','Fedgade 15','2021-05-28','151000'),
('10','1208981414','Copenhagen','Jagtvej 25','2021-01-25','140000'),
('11','1703880266','Copenhagen','Jagtvej 25','2021-01-25','143000'),
('12','1711992232','Aarhus','Langtvæk 123','2021-12-08','120000'),
('13','1503001111','Horsens','Dabdabvej 69','2021-08-10','133000'),
('14','1207692318','Odense','Fedgade 15','2021-05-28','143000'),
('15','2003721021','Copenhagen','Jagtvej 25','2021-03-25','103000'),
('16','2007959041','Naksskov','Frederiksvej 12','2021-05-06','090000'),
('17','1901201213','Odense','Fedgade 15','2021-07-28','120000'),
('18','1512931519','Aarhus','Langtvæk 123','2022-02-08','150000'),
('19','1808851214','Horsens','Dabdabvej 69','2021-10-10','150000'),
('20','1912992238','Copenhagen','Jagtvej 25','2021-03-25','130000'),
('21','1111961219','Copenhagen','Jagtvej 25','2021-03-25','140000');

INSERT Vaccination VALUES
('1','2021-01-25','153000','2003721021','aspera','1'),
('2','2021-03-06','130000','2007959041','aspera','2'),
('3','2021-05-28','140000','1901201213','blast3000','3'),
('4','2021-12-08','143000','1512931519','divoc','4'),
('5','2021-08-10','160000','1808851214','covaxx','5'),
('6','2021-01-25','130000','1912992238','aspera','6'),
('7','2021-01-25','140000','1111961219','blast3000','7'),
('8','2021-12-08','120000','1302770209','divoc','8'),
('9','2021-05-28','160000','2003923132','covaxx','3'),
('10','2021-01-25','143000','1208981414','blast3000','7'),
('11','2021-01-25','150000','1703880266','aspera','6'),
('12','2021-12-08','123000','1711992232','divoc','4'),
('13','2021-08-10','140000','1503001111','covaxx','5'),
('14','2021-05-28','150000','1207692318','blast3000','3'),
('15','2021-03-25','110000','2003721021','aspera','1'),
('16','2021-05-06','093000','2007959041','aspera','2'),
('17','2021-07-28','123000','1901201213','blast3000','3'),
('18','2021-02-08','153000','1512931519','divoc','4'),
('19','2021-10-10','160000','1808851214','covaxx','5'),
('20','2021-03-25','133000','1912992238','aspera','6'),
('21','2021-03-25','143000','1111961219','blast3000','7');

INSERT Storages VALUES
('Copenhagen','Jagtvej 25','aspera','10000'),
('Naksskov','Frederiksvej 12','aspera','50000'),
('Odense','Fedgade 15','blast3000','100000'),
('Aarhus','Langtvæk 123','divoc','5000'),
('Horsens','Dabdabvej 69','covaxx','15050');

INSERT Works VALUES
('1','1','Copenhagen','Jagtvej 25'),
('2','2','Naksskov','Frederiksvej 12'),
('3','3','Odense','Fedgade 15'),
('4','4','Aarhus','Langtvæk 123'),
('5','5','Horsens','Dabdabvej 69'),
('6','1','Copenhagen','Jagtvej 25'),
('7','2','Naksskov','Frederiksvej 12'),
('8','3','Odense','Fedgade 15'),
('9','4','Aarhus','Langtvæk 123'),
('10','5','Horsens','Dabdabvej 69'),
('1','6','Copenhagen','Jagtvej 25'),
('1','7','Copenhagen','Jagtvej 25'),
('4','8','Aarhus','Langtvæk 123'),
('6','6','Copenhagen','Jagtvej 25'),
('6','7','Copenhagen','Jagtvej 25'),
('9','8','Aarhus','Langtvæk 123');
