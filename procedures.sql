/* Stored Procedure that prints the groups to which a certain blood type (passed by 
parameter), you can donate */

DELIMITER || 
CREATE PROCEDURE bloodType (v_type varchar(3)) 
BEGIN 
DECLARE info varchar(45); 
IF (v_type = 'A+') THEN 
SET info = 'A+, AB+'; 
SELECT info AS 'Groups to which you can donate'; 
END IF; 
IF (v_type = 'A-') THEN 
SET info = 'A+, A-, AB+, AB-';
SELECT info AS 'Groups to which you can donate'; 
END IF; 
 
IF (v_type = 'B+') THEN 
SET info = 'B+, AB+'; 
SELECT info AS 'Groups to which you can donate'; 
END IF; 
IF (v_type = 'B-') THEN 
SET info = 'B+, B-, AB+, AB-';
SELECT info AS 'Groups to which you can donate'; 
END IF; 
IF (v_type = 'AB+') THEN 
SET info = 'AB+'; 
SELECT info AS 'Groups to which you can donate'; 
END IF; 
IF (v_tipo = 'AB-') THEN 
SET info = 'A+, AB+'; 
SELECT info AS 'Groups to which you can donate';
END IF; 
IF (v_type = 'O+') THEN 
SET info = 'A+, B+, AB+, O+'; 
SELECT info AS 'Groups to which you can donate'; 
END IF; 
IF (v_type = 'O-') THEN 
SET info = 'Todos os grupos sanguineos'; 
SELECT info AS 'Groups to which you can donate'; 
END IF; 
END || 
DELIMITER; 


/*Stored Procedure that lists donor belonging to a blood group and who can donate blood.*/

 
DELIMITER //

CREATE PROCEDURE donors (v_type varchar (3)) BEGIN 
SELECT idDonor, nameD, surnameD, gender, bloodGroup FROM donor 
WHERE v_type = bloodGroup AND disease = 0; 
END// 
DELIMITER;


/*Stored Procedure for entering donor data. BAKI ASE */


DELIMITER || 
CREATE PROCEDURE insert_donor (idD integer(10), name varchar(30), surname varchar(30), gender char(1), group varchar(3), contact varchar(9), avenue varchar(30), 
nr integer(4), hood varchar(30),city varchar(30), age integer(3), disease int(1), RT int, dateRegisters date) 
BEGIN 
INSERT INSERT donor (idDonor,nameD, surnameD, gender, bloodGroup, contact, avenue_street, 
building_number, neighborhood,city, age, disease, idRT, dateRegisters) VALUES (idD,name, surname, gender, group, contact, avenue, nr, hood,city, age, disease, RT, dateRegisters);
END|| 
DELIMITER; 



/* Stored Procedure for entering patient data.  BAKI ASE*/ 

DELIMITER || 
CREATE PROCEDURE insert_patient (idP integer(10),name varchar(30), surname varchar(30), gender char(1), group varchar(3), contact varchar(9), avenue varchar(30), 
nr int, hood varchar(30),city varchar(30) ,RT int, dateRegisters date) 
BEGIN 
INSERT INSERT patient (nameP, surnameP, gender, bloodGroup, contact, avenida_rua, 
building_number, neighborhood, dateRegisters, idRT) VALUES 
(name, surname, gender, group, contact, avenue, nr, hood, RT, dateRegisters);
END|| 
DELIMITER; 



/*Stored Procedure for making a new donation from an already registered donor (through 
 iD), if it has the necessary requirements for this. */


DELIMITER // 
CREATE PROCEDURE donation (iD int) 
BEGIN 
DECLARE group varchar(3); 
DECLARE age, disease_d, rt_resgistration int; 
IF (EXISTS (SELECT idDonor FROM donor where idDonor = iD)) THEN 
 SET group = (SELECT bloodGroup FROM donor WHERE idDonor = iD); 
 SET age_a = (SELECT age FROM donor WHERE idDonor = iD); 
 SET disease_d = (SELECT disease FROM donor WHERE idDonor = iD); 
SET rt_resgistration = (SELECT idRT FROM donor WHERE idDonor = iD); 
 
 IF ( ((age >= 18) AND (age <= 60)) AND (disease = 0) ) THEN 
INSERT INTO blood ( bloodGroup, idManager) VALUES (group, (SELECT 
mb.idManager FROM manager_bloodbank mb, registration_team rt
 WHERE rt.idRT = rt_resgistration 
 AND rt.idBloodBank = mb.idBloodBank)); 
 ELSE 
 SIGNAL SQLSTATE '45000' 
 SET MESSAGE_TEXT = 'The donor doesn't have the minimum requirements to 
make the donation';
 END IF; 
ELSE 
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'There's no registered donor with the referenced iD';
END IF; 
END// 
DELIMITER ; 

/*Stored Procedure for viewing the stock of donated blood. */


DELIMITER // 
CREATE PROCEDURE stock() 
BEGIN 
 CREATE TEMPORARY TABLE stock_blood ( 
 iD int PRIMARY KEY AUTO_INCREMENT, 
 quantity int, 
 group varchar(3)); 
 
 INSERT INTO stock_blood (quantity,) VALUES 
 ((SELECT COUNT(*) FROM blood WHERE bloodGroup = 'A+'), 'A+'), 
 ((SELECT COUNT(*) FROM blood WHERE bloodGroup = 'A-'), 'A-'), 
 ((SELECT COUNT(*) FROM blood WHERE bloodGroup = 'B+'), 'B+'), 
 ((SELECT COUNT(*) FROM blood WHERE bloodGroup = 'B-'), 'B-'), 
 ((SELECT COUNT(*) FROM blood WHERE bloodGroup = 'AB+'), 'AB+'), 
 ((SELECT COUNT(*) FROM blood WHERE bloodGroup = 'AB-'), 'AB-'), 
 ((SELECT COUNT(*) FROM blood WHERE bloodGroup = 'O+'), 'O+'), 
 ((SELECT COUNT(*) FROM blood WHERE bloodGroup = 'O-'), 'O-'); 
 SELECT quantity AS 'Quantity in Stock (bags)' group AS 'Blood Group'
 FROM stock_blood; 
 DROP TEMPORARY TABLE stock_blood; 
END// 
DELIMITER ; 
