USE Vaccinedb;

DELIMITER //
DROP FUNCTION IF EXISTS ValidCPR;
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

DROP FUNCTION ValidCPR;
