USE VaccineDB;

DROP PROCEDURE IF EXISTS Monthlyreport;
DROP PROCEDURE IF EXISTS Dailyreport;
DROP PROCEDURE IF EXISTS AddCompletedVaccination;

#procedure for monthly report
CREATE PROCEDURE Monthlyreport ()
SELECT vaccine_name AS Vaccine , sum(price) AS Total, count(vaccine_name) AS Amount 
FROM Vaccine NATURAL JOIN Vaccination 
WHERE MONTH(vaccination.vaccination_date)=MONTH(CURRENT_DATE()) 
GROUP BY vaccine_name;
CALL Monthlyreport();

#procedure for daily report
CREATE PROCEDURE Dailyreport ()
SELECT patient_name, CPR, employee_id, vaccine_name, vaccination_time, vaccination_date, address, city  
FROM (Patient NATURAL JOIN Vaccination) 
NATURAL JOIN Appointment 
WHERE vaccination.vaccination_date=CURRENT_DATE() 
ORDER BY vaccination_time;
CALL Dailyreport();

#Ikke som sådan nødvendigt med en procedure her. Hvisauto increment er slået til, kan der erstattes med:
#INSERT Vaccination (vaccination_date, vaccination_time, CPR, vaccine_name, employee_id) VALUES (CURRENT_DATE(), CURRENT_TIME(), cprnummerher, vaccinenavnher, medarbejderidher);
DELIMITER //
CREATE PROCEDURE AddCompletedVaccination
(IN vCPR BIGINT, IN vVaccine_name VARCHAR(128), IN vEmployee_id int)
BEGIN
    select MAX(vaccination_id) + 1 INTO @newID from vaccination;
	INSERT Vaccination (vaccination_id, vaccination_date, vaccination_time, CPR, vaccine_name, employee_id)
		VALUES (@newID,  CURRENT_DATE(), CURRENT_TIME(), vCPR, vVaccine_name, vEmployee_id);
END //
DELIMITER ;

#CALL AddCompletedVaccination (2003721021, 'aspera', '2');