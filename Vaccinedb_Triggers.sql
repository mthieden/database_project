USE VaccineDB;
DROP FUNCTION IF EXISTS ValidCPR;
#function used by some of the triggers
DELIMITER //
CREATE FUNCTION ValidCPR( CPR BIGINT ) RETURNS BOOLEAN
# In this function we  rely on the integrated string to date conversion to catch any illigal dates
# we  try to convert the CPR number into a date, and if that fails we return false else true
BEGIN
    DECLARE dd  INT;  
    DECLARE mm  INT;  
    DECLARE yy  INT;  
    DECLARE ddmmyy  INT ;
    DECLARE date_str  VARCHAR(10) ;
    DECLARE result  BOOLEAN;
    DECLARE date_data  DATE;
	
    # This handler catches the conversion exception and changes the result instead of stopping the program
    DECLARE CONTINUE HANDLER FOR SQLSTATE "22007"
	BEGIN
		SET result = FALSE;
	END;
    SET result = True;
    SET ddmmyy = FLOOR(CPR / 10000);
	SET dd = FLOOR(ddmmyy/ 10000);
	SET mm = MOD(FLOOR(ddmmyy / 100),100);
	SET yy = MOD(ddmmyy,100);
    
	SET date_str = CONVERT(CPR, CHAR);

    # This checks if the cprnumber is too short
    IF NOT(LENGTH(date_str) = 10 OR LENGTH(date_str) = 9) THEN 
		SET result = FALSE;
	END IF;

    # This checks if any of the date is zero
    IF dd = 0 OR mm=0 THEN 
		SET result = FALSE;
	END IF;

    
    SET date_str = concat(CAST(yy AS CHAR),"-",CAST(mm AS CHAR),"-",CAST(dd AS CHAR));
    # Here we convert string to date 
    SET date_data =  CONVERT(date_str,date);
    # If the string is converted to null then result is set to false
    IF date_data = NULL THEN 
		SET result = FALSE;
	END IF;
    RETURN  result;
END; //
DELIMITER ;

#
#   ACTUAL TRIGGERS BELOW
#


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


DROP TRIGGER patient_CPR_before_update_check;
DROP TRIGGER patient_CPR_before_insert_check;
DROP FUNCTION ValidCPR;


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

#Ikke som sådan nødvendigt med en procedure. Når auto increment er slået til, kan der erstattes med:
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
DROP TRIGGER storage_subtractor;
#CALL AddCompletedVaccination (2003721021, 'aspera', '2');

