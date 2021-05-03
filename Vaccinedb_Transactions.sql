USE VaccineDB;

#The following code inserts values that is already in the database it is just here to show how a transaction could be used
START TRANSACTION;
INSERT INTO Patient
VALUES ('2003721021','Mars Aries','Mars Lane 1');

INSERT INTO vaccine
VALUES ('divoc',50.00);
COMMIT;

