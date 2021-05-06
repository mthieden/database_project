USE VaccineDB;

DROP TRIGGER IF EXISTS patient_CPR_before_update_check;
DROP TRIGGER IF EXISTS patient_CPR_before_insert_check;
DROP TRIGGER IF EXISTS storage_subtractor;
DROP TRIGGER IF EXISTS check_certification;

DELIMITER //
CREATE TRIGGER patient_CPR_before_update_check BEFORE UPDATE ON Patient
FOR EACH ROW
	BEGIN
		IF NOT VALIDCPR(NEW.CPR)  THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Invalid CPR number updated";
	END IF;
END; //
DELIMITER ;

DELIMITER //
CREATE TRIGGER patient_CPR_before_insert_check BEFORE INSERT ON Patient
FOR EACH ROW
	BEGIN
		IF NOT(VALIDCPR(NEW.CPR)) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "Invalid CPR number inserted";
	END IF;
END; //
DELIMITER ;

# Look up where the vaccination is given and update the storage for that location
DELIMITER //
CREATE TRIGGER storage_subtractor
BEFORE INSERT ON vaccination FOR EACH ROW
BEGIN
	SELECT city, address, COUNT(*) INTO @city, @address, @count 
    FROM works NATURAL JOIN schedules 
    WHERE employee_id = NEW.employee_id AND schedule_date = NEW.vaccination_date AND NEW.vaccination_time BETWEEN schedule_timestart AND schedule_timeend;
	IF NOT(@count > 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "Employee not registered to work at that time";
	ELSE
		UPDATE storages
			SET amount = amount-1 WHERE storages.city = @city AND storages.address = @address AND storages.vaccine_name = NEW.vaccine_name;
	END IF;
END //
DELIMITER ;

#Reject an entry if the employee is not certified to give the vaccination
DELIMITER //
CREATE TRIGGER check_certification
BEFORE INSERT ON vaccination FOR EACH ROW
BEGIN
	SELECT COUNT(*) INTO @cert FROM Certification where employee_id = NEW.employee_id AND vaccine_name = NEW.vaccine_name;
	IF NOT(@cert > 0) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "Employee not certified";
	END IF;
END //
DELIMITER ;


