USE VaccineDB;

INSERT Patient Values
('1010801315','Poseidon Water', 'Waterway 3');
CREATE VIEW Patientview AS SELECT CPR, patient_name, address FROM Patient;
SELECT * FROM Patientview;
DROP VIEW Patientview;

UPDATE Patient
SET patient_name = 'Poseidon Notwater'
WHERE CPR = '1010801315';
CREATE VIEW Patientview AS SELECT CPR, patient_name, address FROM Patient;
SELECT * FROM Patientview;
DROP VIEW Patientview;


DELETE FROM Patient WHERE patient_name = 'Poseidon Notwater';
CREATE VIEW Patientview AS SELECT CPR, patient_name, address FROM Patient;
SELECT * FROM Patientview;
DROP VIEW Patientview;
