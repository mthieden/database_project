USE VaccineDB;


#The following is a simple transaction that transfers 1000 aspera vaccines from one storage location to another
START TRANSACTION;
SET @transfer_amount = 1000;
SET @vaccine_name = 'aspera';
UPDATE storages
SET amount = amount - @transfer_amount WHERE city = 'Copenhagen' AND address = 'Jagtvej 25' AND vaccine_name = @vaccine_name;
UPDATE storages
SET amount = amount - @transfer_amount WHERE city = 'Naksskov' AND address = 'Frederiksvej 12' AND vaccine_name = @vaccine_name;
COMMIT;