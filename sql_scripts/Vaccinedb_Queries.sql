USE VaccineDB;

#Daily report of vaccinations made at a given location with vaccine type, employee id, patient name and CPR
SELECT DISTINCT patient_name, CPR, employee_id, vaccine_name, vaccination_time, vaccination_date, address, city  
FROM (Patient NATURAL JOIN Vaccination) 
NATURAL JOIN Appointment 
WHERE vaccination.vaccination_date=CURRENT_DATE()
ORDER BY vaccination_time;

#Monthly report of vaccines used and what the cost of that was
SELECT vaccine_name AS Vaccine , sum(price) AS Total, count(vaccine_name) AS Amount 
FROM Vaccine NATURAL JOIN Vaccination 
WHERE MONTH(vaccination.vaccination_date)=MONTH(CURRENT_DATE()) 
GROUP BY vaccine_name;

#Hours worked by each employee with salary per hour
SELECT employee_name AS Employee, 
FORMAT(SUM(TIME_TO_SEC(TIMEDIFF(schedule_timeend,schedule_timestart  ))/ 3600),2) AS Hours , 
FORMAT(SUM(TIME_TO_SEC(TIMEDIFF(schedule_timeend,schedule_timestart  ))/ 3600)*wage,0) AS Payout, 
wage AS Wage
FROM  Schedules NATURAL JOIN  Employee 
NATURAL JOIN Works GROUP BY employee_id;

#Employees per location
SELECT  count(DISTINCT employee_id) AS Workers, city, address 
FROM Works GROUP BY city ORDER BY Workers DESC;

#Number of vaccinations recieved
SELECT CPR, patient_name AS Name, count(vaccine_name) AS Doses, vaccine_name AS Vaccine 
FROM Patient NATURAL LEFT JOIN Vaccination 
GROUP BY CPR ORDER BY patient_name;
