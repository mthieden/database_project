USE Vaccinedb;

DROP USER IF EXISTS 'JavaUser'@localhost;
CREATE USER 'JavaUser'@localhost IDENTIFIED BY 'password1';
GRANT SELECT ON VaccineDB.Patient TO 'JavaUser'@localhost IDENTIFIED BY 'password1';
GRANT INSERT ON VaccineDB.Patient TO 'JavaUser'@localhost IDENTIFIED BY 'password1';
GRANT SELECT ON VaccineDB.Appointment TO 'JavaUser'@localhost IDENTIFIED BY 'password1';
GRANT INSERT ON VaccineDB.Appointment TO 'JavaUser'@localhost IDENTIFIED BY 'password1';
