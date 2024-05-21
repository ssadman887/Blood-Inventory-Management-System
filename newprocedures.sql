DELIMITER //

CREATE PROCEDURE donor_compatibility(
  IN blood_type VARCHAR(3)
)
BEGIN
  CASE blood_type
    WHEN 'A+' THEN 
      SELECT 'A+, AB+' AS compatible_groups;

    WHEN 'A-' THEN
      SELECT 'A+, A-, AB+, AB-' AS compatible_groups;

    WHEN 'B+' THEN  
      SELECT 'B+, AB+' AS compatible_groups;

    WHEN 'B-' THEN
      SELECT 'B+, B-, AB+, AB-' AS compatible_groups;

    WHEN 'AB+' THEN
      SELECT 'AB+' AS compatible_groups;

    WHEN 'AB-' THEN  
      SELECT 'AB+, AB-' AS compatible_groups;

    WHEN 'O+' THEN
      SELECT 'A+, B+, AB+, O+' AS compatible_groups;

    WHEN 'O-' THEN
      SELECT 'A+, B+, AB+, O+' AS compatible_groups;

  END CASE;

END //

DELIMITER ;

--CALL donor_compatibility('B+');

DELIMITER // 

CREATE PROCEDURE get_eligible_donors (
  IN blood_group VARCHAR(3)
)
BEGIN
  SELECT 
    d.idDonor, 
    d.nameD,
    d.surnameD,
    d.gender,
    d.bloodGroup
  FROM donor d
  WHERE 
    d.bloodGroup = blood_group
    AND d.disease = 0;
END //

DELIMITER ;

--CALL get_eligible_donors('A+');


DELIMITER //

CREATE PROCEDURE view_blood_stock()
BEGIN
  SELECT 
    b.bloodGroup,
    COUNT(bp.idBlood) AS total_units 
  FROM 
    blood b
  LEFT JOIN 
    blood_patient bp ON b.idBlood = bp.idBlood AND b.bloodGroup = bp.bloodGroup
  GROUP BY 
    b.bloodGroup;

END //

DELIMITER ;

--CALL view_blood_stock();


DELIMITER //

CREATE PROCEDURE donate_blood (
  IN donor_id INT,
  OUT donation_id INT
)
BEGIN

  DECLARE donor_age INT;
  DECLARE donor_disease INT;

  SELECT age, disease 
  INTO donor_age, donor_disease
  FROM donor
  WHERE idDonor = donor_id;

  IF donor_age >= 18 AND donor_age <= 60 AND donor_disease = 0 THEN

    INSERT INTO blood (bloodGroup, idManager)
    SELECT bloodGroup, idManager 
    FROM donor 
    WHERE idDonor = donor_id;

    SET donation_id = LAST_INSERT_ID();

  ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Donor does not meet donation requirements';
  END IF;

END //

DELIMITER ;

--CALL donate_blood(201, @donation_id);