USE VaccineDB;

DROP TRIGGER IF EXISTS patient_CPR_before_update_check;
DROP TRIGGER IF EXISTS patient_CPR_before_insert_check;
DROP TRIGGER IF EXISTS storage_subtractor;

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

DELIMITER //
CREATE TRIGGER storage_subtractor
AFTER INSERT
ON vaccination FOR EACH ROW
BEGIN
	SELECT city INTO @loc FROM works natural join schedules where employee_id = NEW.employee_id;
	UPDATE storages
		SET amount = amount-1 WHERE storages.vaccine_name = NEW.vaccine_name AND storages.city = @loc;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_certification
AFTER INSERT
ON vaccination FOR EACH ROW
BEGIN
	SELECT city INTO @loc FROM works natural join schedules where employee_id = NEW.employee_id;
	UPDATE storages
		SET amount = amount-1 WHERE storages.vaccine_name = NEW.vaccine_name AND storages.city = @loc;
END //
DELIMITER ;


