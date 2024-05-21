/*Trigger for donor data entry, where it checks if the donor has any disease and if the 
donor has an age betweern 18-60. If it does not contain it and has the age in the range 
above, the donor proceeeds with the donation, and the record of the donated blood is 
inserted in the blood table; if not, no record will be inserted in the blood table, and in the 
donor table, the id and blood group of the donated blood will be canceled. */


DELIMITER // 
CREATE TRIGGER tr_donor BEFORE INSERT 
ON donor FOR EACH ROW
BEGIN 
DECLARE id INT; 
IF ( ((NEW.age >= 18) AND (NEW. age <= 60)) AND (NEW.disease = 0) ) THEN 
INSERT INTO blood ( bloodGroup, idManager) VALUES ( NEW. bloodGroup, 
(SELECT mb.idManager FROM manager_bloodbank mb, registration_team rt
WHERE rt.idRT = NEW.idRT AND rt.idBloodBank = mb. idBloodBank)); 

SET id = (SELECT max(idBloodBank) FROM blood);
SET NEW. idBloodBank = id; 
SET NEW.bloodGroupBlood = NEW. bloodGroup; 
ELSE 
SET NEW.idBlood = NULL; 
SET NEW. bloodGroupBlood = NULL; 
END IF; 
END// 
DELIMITER ; 







/*Trigger for entering patient data, where the managers iD (in the patient table) will 
match the managers iD that generates the Blood Bank, on which the registration team 
member, who registered the patient works. */


DELIMITER //
CREATE TRIGGER tr_patient BEFORE INSERT 
ON patient FOR EACH ROW 
BEGIN 
SET new.idManager = (SELECT mb.idManager 
 FROM manager_bloodbank gb, registration_team rt
 WHERE rt.idRT = new.idRT
 AND rt.idBloodBank = mb.idBloodBank);
END// 
DELIMITER ;









/*It counts the donors, after insertion, by their gender and by the fact that they contain or 
not any disease. */


DELIMITER // 
CREATE TRIGGER count_donor BEFORE INSERT 
ON donor FOR EACH ROW 
BEGIN 
DECLARE total_D, cont INT; 
IF (NEW.gender = 'M' AND NEW.disease = 0) THEN 
SET cont = (SELECT Donor_Male FROM cont_donor WHERE idCont = 1); 
SET total_D = (SELECT Total_Donors FROM cont_donor WHERE idCont = 1); 
UPDATE cont_doador SET Donor_Male = (cont + 1), Total_Donors = (total_D + 1) 
WHERE idCont = 1; 
END IF; 
IF (NEW.gender = 'M' AND NEW.disease = 1) THEN 
SET cont = (SELECT Doador_Male_Sick from cont_donor WHERE idCont = 1); 
SET total_D = (SELECT Total_Donors from cont_donor WHERE idCont = 1); 
UPDATE cont_donor SET Donor_Male_Sick = (cont + 1) , Total_Donors = (total_D + 
1) WHERE idCont = 1; 
END IF; 
IF (NEW.gender = 'F' AND NEW disease = 1) THEN 
SET cont = (SELECT Donor_Female_Sick FROM cont_donor WHERE idCont = 1); 
SET total_D = (SELECT Total_Donors FROM cont_donor WHERE idCont = 1);
UPDATE cont_donor SET Donor_Female_Sick = (cont + 1) , Total_Doadores = (total_D 
+ 1) WHERE idCont = 1; 
END IF; 
IF (NEW.gender = 'F' AND NEW.disease = 0) THEN 
SET cont = (SELECT Donor_Female FROM cont_donor WHERE idCont = 1); 
SET total_D = (SELECT Total_Donors FROM cont_donor WHERE idCont = 1); 
UPDATE cont_donor SET Donor_Female = (cont + 1) , Total_Donors = (total_D + 1) 
WHERE idCont = 1; 
END IF; 
END// 
DELIMITER ;








/* It counts the donors, after the removal of any donor record, by their gender and by the 
fact that they contain or not any disease. */



DELIMITER // 
CREATE TRIGGER contar_donor_delete BEFORE DELETE 
ON donor FOR EACH ROW 
BEGIN 
DECLARE total_D, cont INT; 
IF (OLD.gender = 'M' AND OLD.disease = 0) THEN 
SET cont = (SELECT Donor_Male FROM cont_donor WHERE idCont = 1); 
SET total_D = (SELECT Total_Donors FROM cont_donor WHERE idCont = 1); 
UPDATE cont_donor SET Donor_Male = (cont - 1), Total_Donors = (total_D - 1) 
WHERE idCont = 1; 
END IF; 
IF (OLD.gender = 'M' AND OLD.disease = 1) THEN 
SET cont = (SELECT Donor_Male_Sick from cont_donor WHERE idCont = 1); 
SET total_D = (SELECT Total_Doadores from cont_donor WHERE idCont = 1); 
UPDATE cont_donor SET Donor_Male_Sick = (cont - 1) , Total_Donors = (total_D - 1) 
WHERE idCont = 1; 
END IF; 
IF (OLD.gender = 'F' AND OLD.disease = 1) THEN 
SET cont = (SELECT Donor_Female_Sick FROM cont_donor WHERE idCont = 1); 
SET total_D = (SELECT Total_Donors FROM cont_donor WHERE idCont = 1); 
UPDATE cont_donor SET Donor_Female_Sick = (cont - 1) , Total_Donors = (total_D - 
1) WHERE idCont = 1; 
END IF; 
IF (OLD.gender = 'F' AND OLD.disease = 0) THEN 
SET cont = (SELECT Donor_Female FROM cont_donor WHERE idCont = 1);
SET total_D = (SELECT Total_Donors FROM cont_donor WHERE idCont = 1); 
UPDATE cont_donor SET Donor_Female = (cont - 1) , Total_Donors = (total_D - 1) 
WHERE idCont = 1; 
END IF; 
END// 
DELIMITER ;







/*It counts the donors, after updating a donor’s record, by their gender and by whether 
or not they contain any disease. */



DELIMITER // 
CREATE TRIGGER contar_donor_update AFTER UPDATE 
ON donor FOR EACH ROW 
BEGIN 
DECLARE total_D, cont INT; 
IF (NEW.gender = 'M' AND NEW.disease = 0) THEN 
SET cont = (SELECT count(*) FROM donor WHERE gender='M' AND disease=0); 
SET total_D = (SELECT count(*) FROM donor);
UPDATE cont_donor SET Donor_Male = cont , Total_Donors = total_D WHERE idCont 
= 1; 
END IF; 
IF (NEW.gender = 'M' AND NEW.disease = 1) THEN 
SET cont = (SELECT count(*) from donor WHERE gender ='M' AND doenca=1); 
SET total_D = (SELECT count(*) from donor); disease 
UPDATE cont_donor SET Donor_Male_Sick = cont , Total_Donors = total_D WHERE 
idCont = 1; 
END IF; 
IF (NEW.gender = 'F' AND NEW.disease = 1) THEN 
SET cont = (SELECT count(*) FROM donor WHERE gender ='F' AND disease =1); 
SET total_D = (SELECT count(*) FROM donor);
UPDATE cont_donor SET Donor_Female_Sick = cont , Total_Donors = total_D 
WHERE idCont = 1; 
END IF; 
IF (NEW.gender = 'F' AND NEW.disease = 0) THEN 
SET cont = (SELECT count(*) FROM donor WHERE gender ='F' AND disease =0); 
SET total_D = (SELECT count(*) FROM donor);
UPDATE cont_donor SET Donor_Female = cont , Total_Donors = total_D WHERE 
idCont = 1; 
END IF; 
END// 
DELIMITER ; 







/*It counts the donors, after changing a donor’s register, by their gender and by the fact 
that they contain or not any disease. */



DELIMITER // 
CREATE TRIGGER contar_donor_update2 BEFORE UPDATE 
ON donor FOR EACH ROW 
BEGIN 
DECLARE cont INT; 
IF (OLD.gender = 'M' AND OLD.disease = 0) THEN 
SET cont = (SELECT Donor_Male FROM cont_donor WHERE idCont = 1); 
UPDATE cont_donor SET Donor_Male = (cont - 1) WHERE idCont = 1; 
END IF; 
IF (OLD.gender = 'M' AND OLD.disease = 1) THEN 
SET cont = (SELECT Donor_Male_Sick from cont_donor WHERE idCont = 1); 
UPDATE cont_donor SET Donor_Male_Sick = (cont - 1) WHERE idCont = 1; 
END IF; 
IF (OLD.gender = 'F' AND OLD.disease = 1) THEN 
SET cont = (SELECT Donor_Female_Sick FROM cont_donor WHERE idCont = 1); 
UPDATE cont_donor SET Donor_Female_Sick = (cont - 1) WHERE idCont = 1; 
END IF; 
IF (OLD.gender = 'F' AND OLD.disease = 0) THEN 
SET cont = (SELECT Donor_Female FROM cont_donor WHERE idCont = 1); 
UPDATE cont_donor SET Donor_Female = (cont - 1) WHERE idCont = 1; 
END IF; 
END// 
DELIMITER ; 



