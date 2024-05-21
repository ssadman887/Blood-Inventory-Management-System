/*Trigger for donor data entry, where it checks if the donor has any disease and if the 
donor has an age betweern 18-60. If it does not contain it and has the age in the range 
above, the donor proceeeds with the donation, and the record of the donated blood is 
inserted in the blood table; if not, no record will be inserted in the blood table, and in the 
donor table, the id and blood group of the donated blood will be canceled. */

DELIMITER // 

CREATE TRIGGER blood_bank.trg_donor_before_insert
BEFORE INSERT ON blood_bank.donor
FOR EACH ROW
BEGIN
  DECLARE v_blood_id INT;

  IF NEW.age >= 18 AND NEW.age <= 60 AND NEW.disease = 0 THEN
    
    INSERT INTO blood_bank.blood (bloodGroup, idManager) 
      SELECT NEW.bloodGroup, mb.idManager  
      FROM blood_bank.manager_bloodbank mb
      JOIN blood_bank.registration_team rt
        ON rt.idRT = NEW.idRT
        AND rt.idBloodBank = mb.idBloodBank;
        
    SET v_blood_id = LAST_INSERT_ID();
    
    IF v_blood_id > 0 THEN
      SET NEW.idBlood = v_blood_id;
      SET NEW.bloodGroupBlood = NEW.bloodGroup;
    ELSE
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error inserting blood record';
    END IF;

  ELSE
    SET NEW.idBlood = NULL;
    SET NEW.bloodGroupBlood = NULL;
  END IF;
  
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER blood_bank.trg_patient_before_insert
BEFORE INSERT ON blood_bank.patient
FOR EACH ROW
BEGIN

  DECLARE v_manager_id INTEGER;
  
  SELECT m.idManager INTO v_manager_id
  FROM blood_bank.manager m
  JOIN blood_bank.manager_bloodbank mb 
    ON m.idManager = mb.idManager
  JOIN blood_bank.blood_bank bb
    ON mb.idBloodBank = bb.idBloodBank
  JOIN blood_bank.registration_team rt
    ON bb.idBloodBank = rt.idBloodBank
  WHERE rt.idRT = NEW.idRT
  LIMIT 1;

  IF v_manager_id IS NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Invalid registration team for this blood bank';
  ELSEIF v_manager_id != NEW.idManager THEN 
    SET NEW.idManager = v_manager_id;
  END IF;

END//

DELIMITER ;


DELIMITER //

CREATE TRIGGER blood_bank.trg_donor_after_insert
AFTER INSERT ON blood_bank.donor
FOR EACH ROW
BEGIN

  IF NEW.disease = 0 THEN

    IF NEW.gender = 'M' THEN
      UPDATE blood_bank.donor_counts  
        SET male_healthy = male_healthy + 1;

    ELSEIF NEW.gender = 'F' THEN
      UPDATE blood_bank.donor_counts
        SET female_healthy = female_healthy + 1;  
    END IF;

  ELSE 

    IF NEW.gender = 'M' THEN
      UPDATE blood_bank.donor_counts
        SET male_sick = male_sick + 1;

    ELSEIF NEW.gender = 'F' THEN  
      UPDATE blood_bank.donor_counts
        SET female_sick = female_sick + 1;
    END IF;

  END IF;

  UPDATE blood_bank.donor_counts
    SET total_donors = total_donors + 1;

END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER blood_bank.trg_donor_after_delete 
AFTER DELETE ON blood_bank.donor
FOR EACH ROW
BEGIN

  IF OLD.disease = 0 THEN

    IF OLD.gender = 'M' THEN
      UPDATE blood_bank.donor_counts  
        SET male_healthy = male_healthy - 1;

    ELSEIF OLD.gender = 'F' THEN
      UPDATE blood_bank.donor_counts
        SET female_healthy = female_healthy - 1;
    END IF;

  ELSE

    IF OLD.gender = 'M' THEN
      UPDATE blood_bank.donor_counts
        SET male_sick = male_sick - 1;

    ELSEIF OLD.gender = 'F' THEN
      UPDATE blood_bank.donor_counts
        SET female_sick = female_sick - 1;
    END IF;
  
  END IF;

  UPDATE blood_bank.donor_counts
    SET total_donors = total_donors - 1;
  
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER blood_bank.trg_donor_after_update
AFTER UPDATE ON blood_bank.donor 
FOR EACH ROW
BEGIN

  IF OLD.disease != NEW.disease OR OLD.gender != NEW.gender THEN

    IF OLD.disease = 0 THEN 

      IF OLD.gender = 'M' THEN
        UPDATE blood_bank.donor_counts  
          SET male_healthy = male_healthy - 1;
  
      ELSEIF OLD.gender = 'F' THEN
        UPDATE blood_bank.donor_counts
          SET female_healthy = female_healthy - 1;
      END IF;

    ELSE

      IF OLD.gender = 'M' THEN
        UPDATE blood_bank.donor_counts
          SET male_sick = male_sick - 1;
  
      ELSEIF OLD.gender = 'F' THEN
        UPDATE blood_bank.donor_counts
          SET female_sick = female_sick - 1;
      END IF;

    END IF;

    IF NEW.disease = 0 THEN

      IF NEW.gender = 'M' THEN
        UPDATE blood_bank.donor_counts  
          SET male_healthy = male_healthy + 1;

      ELSEIF NEW.gender = 'F' THEN
        UPDATE blood_bank.donor_counts
          SET female_healthy = female_healthy + 1;
      END IF;

    ELSE

      IF NEW.gender = 'M' THEN
        UPDATE blood_bank.donor_counts
          SET male_sick = male_sick + 1;

      ELSEIF NEW.gender = 'F' THEN
        UPDATE blood_bank.donor_counts
          SET female_sick = female_sick + 1;
      END IF;

    END IF;

  END IF;
  
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER blood_bank.trg_donor_after_update2 
AFTER UPDATE ON blood_bank.donor
FOR EACH ROW 
BEGIN

  IF OLD.dateRegisters != NEW.dateRegisters THEN

    IF OLD.disease = 0 THEN

      IF OLD.gender = 'M' THEN
        UPDATE blood_bank.donor_counts
          SET male_healthy = male_healthy - 1;

      ELSEIF OLD.gender = 'F' THEN
        UPDATE blood_bank.donor_counts  
          SET female_healthy = female_healthy - 1;
      END IF;

    ELSE

      IF OLD.gender = 'M' THEN
        UPDATE blood_bank.donor_counts
          SET male_sick = male_sick - 1;

      ELSEIF OLD.gender = 'F' THEN
        UPDATE blood_bank.donor_counts
          SET female_sick = female_sick - 1;
      END IF;

    END IF;

    IF NEW.disease = 0 THEN

      IF NEW.gender = 'M' THEN
        UPDATE blood_bank.donor_counts
          SET male_healthy = male_healthy + 1;

      ELSEIF NEW.gender = 'F' THEN
        UPDATE blood_bank.donor_counts
          SET female_healthy = female_healthy + 1;
      END IF;

    ELSE

      IF NEW.gender = 'M' THEN
        UPDATE blood_bank.donor_counts
          SET male_sick = male_sick + 1;

      ELSEIF NEW.gender = 'F' THEN
        UPDATE blood_bank.donor_counts
          SET female_sick = female_sick + 1;
      END IF;

    END IF;

  END IF;

END//

DELIMITER ;


DELIMITER //
CREATE TRIGGER check_disease_before_insert
BEFORE INSERT ON donor
FOR EACH ROW
BEGIN
  IF NEW.disease = 1 THEN 
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cannot insert data when disease value is 1';
  END IF;
END;//
DELIMITER ;
