USE VaccineDB;

CREATE VIEW Patientview AS SELECT LPAD(CPR, 10, 0) as CPR, patient_name, patient_address FROM Patient;
SELECT * FROM Patientview;
DROP VIEW Patientview;

CREATE VIEW Locationview AS SELECT city, address FROM Location;
SELECT * FROM Locationview;
DROP VIEW Locationview;

CREATE VIEW Vaccineview AS SELECT vaccine_name, price FROM Vaccine;
SELECT * FROM Vaccineview;
DROP VIEW Vaccineview;

CREATE VIEW Employeeview AS SELECT employee_id, employee_name, title, wage FROM Employee;
SELECT * FROM Employeeview;
DROP VIEW Employeeview;

CREATE VIEW Schedulesview AS SELECT schedule_id, schedule_date, schedule_timestart, schedule_timeend FROM Schedules;
SELECT * FROM Schedulesview;
DROP VIEW Schedulesview;

CREATE VIEW Certificationview AS SELECT certification_id, certification_date, certification_time, vaccine_name, employee_id FROM Certification;
SELECT * FROM Certificationview;
DROP VIEW Certificationview;

CREATE VIEW Appointmentview AS SELECT appointment_id, CPR, city, address, appointment_date, appointment_time FROM Appointment;
SELECT * FROM Appointmentview;
DROP VIEW Appointmentview;

CREATE VIEW Vaccinationview AS SELECT vaccination_id, vaccination_date, vaccination_time, CPR, vaccine_name, employee_id FROM Vaccination;
SELECT * FROM Vaccinationview;
DROP VIEW Vaccinationview;

CREATE VIEW Storagesview AS SELECT city, address, vaccine_name, amount FROM Storages;
SELECT * FROM Storagesview;
DROP VIEW Storagesview;

CREATE VIEW Worksview AS SELECT schedule_id, employee_id, city, address FROM Works;
SELECT * FROM Worksview;
DROP VIEW Worksview;

INSERT Patient Values 
('1010801315','Poseidon Water', 'Waterway 3');
CREATE VIEW Patientview AS SELECT LPAD(CPR, 10, 0) as CPR, patient_name, patient_address FROM Patient;
SELECT * FROM Patientview;
DROP VIEW Patientview;

UPDATE Patient 
SET patient_name = 'Poseidon Notwater'
WHERE CPR = '1010801315';
CREATE VIEW Patientview AS SELECT LPAD(CPR, 10, 0) as CPR, patient_name, patient_address FROM Patient;
SELECT * FROM Patientview;
DROP VIEW Patientview;


CREATE VIEW Patientview AS SELECT LPAD(CPR, 10, 0) as CPR, patient_name, patient_address FROM Patient;
SELECT * FROM Patientview;
DROP VIEW Patientview;
