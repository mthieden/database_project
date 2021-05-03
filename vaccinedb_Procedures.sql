USE VaccineDB;
#procedure for monthly report
CREATE PROCEDURE Monthlyreport ()
SELECT vaccine_name AS Vaccine , sum(price) AS Total, count(vaccine_name) AS Amount 
FROM Vaccine NATURAL JOIN Vaccination 
WHERE MONTH(vaccination.vaccination_date)=MONTH(CURRENT_DATE()) 
GROUP BY vaccine_name;
CALL Monthlyreport();
DROP PROCEDURE Monthlyreport;

#procedure for daily report
CREATE PROCEDURE Dailyreport ()
SELECT patient_name, CPR, employee_id, vaccine_name, vaccination_time, vaccination_date, address, city  
FROM (Patient NATURAL JOIN Vaccination) 
NATURAL JOIN Appointment 
WHERE vaccination.vaccination_date=CURRENT_DATE() 
ORDER BY vaccination_time;
CALL Dailyreport();
DROP PROCEDURE Dailyreport;

