--1. show all tables
DELIMITER //
CREATE PROCEDURE Showall()
BEGIN
 DECLARE done INT DEFAULT FALSE;
 DECLARE _tbl CHAR(64);
 DECLARE cur CURSOR FOR SELECT table_name FROM information_schema.tables WHERE table_schema=DATABASE();
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

 OPEN cur;

 read_loop: LOOP
   FETCH cur INTO _tbl;

   IF done THEN
     LEAVE read_loop;
   END IF;

   SET @s = CONCAT('SELECT * FROM ', _tbl);
   PREPARE stmt FROM @s;
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;
 END LOOP;

 CLOSE cur;
END//
DELIMITER ;

--2. get healthy donors OK
CREATE PROCEDURE GetHealthyDonors()
BEGIN
  SELECT * FROM Donor
  WHERE disease = 0 AND age BETWEEN 18 AND 60;
END//
DELIMITER ;

--3. get donors by gender and bloodgroup 
DELIMITER //
CREATE PROCEDURE GetDonors(IN p_gender VARCHAR(1), IN p_bloodgroup VARCHAR(3))
BEGIN
   SELECT idDonor, nameD, surnameD, gender, d.bloodGroup, avenue_street, building_number, neighborhood 
   FROM donor d, blood s 
   WHERE d.idBlood = s.idBlood 
         AND bloodGroupBlood = s.bloodGroup 
         AND gender = p_gender 
         AND d.bloodGroup = p_bloodgroup;
END//
DELIMITER ;

--4. Get details about blood units and the patients who received them.

DELIMITER //
CREATE PROCEDURE GetBloodUnitsAndPatients()
BEGIN
  SELECT Blood.idBlood, Blood.bloodGroup, Patient.idPatient, Patient.nameP, Patient.surnameP
  FROM Blood
  JOIN Blood_Patient ON Blood.idBlood = Blood_Patient.idBlood
  JOIN Patient ON Blood_Patient.idPatient = Patient.idPatient;
END//
DELIMITER ;

--5. get eligible donors having no disease and within age

DELIMITER //
CREATE PROCEDURE GetEligibleDonors()
BEGIN
 SELECT * FROM Donor
 WHERE disease = 0 AND age BETWEEN 18 AND 60;
END//
DELIMITER ;


--6 finding the requests fulfilled by hospitals

DELIMITER //
CREATE PROCEDURE GetFulfilledRequestsByHospital()
BEGIN
 SELECT Hospital.idHospital, Hospital.nameH, COUNT(*) AS RequestsFulfilled
 FROM Hospital
 JOIN Hospital_Requests ON Hospital.idHospital = Hospital_Requests.idHospital
 GROUP BY Hospital.idHospital;
END//
DELIMITER ;

--7 get info on critical blood shortage
DELIMITER //
CREATE PROCEDURE GetCritical()
BEGIN
 SELECT idBloodBank, nameBB, COUNT(*) AS AvailableBloodUnits
 FROM BloodBank
 LEFT JOIN Blood ON BloodBank.idBloodBank = Blood.idBlood
 GROUP BY BloodBank.idBloodBank
 HAVING AvailableBloodUnits < 10;
END//
DELIMITER ;

--8 find expired blood
DELIMITER //
CREATE PROCEDURE GetExpired()
BEGIN
 SELECT * FROM donor
 WHERE DATEDIFF(CURDATE(), dateRegisters) >= 120;
END//
DELIMITER ;


--9. Find Hospitals and Their Pending Blood Requests:
DELIMITER //
CREATE PROCEDURE GetHospitalsAndPending()
BEGIN
 SELECT h.idHospital, h.nameH, COUNT(hr.idRequests) AS PendingRequests
 FROM Hospital h
 LEFT JOIN Hospital_Requests hr ON h.idHospital = hr.idHospital
 GROUP BY h.idHospital, h.nameH;
END//
DELIMITER ;


--10. get relapsed time of all donarted blood
DELIMITER //
CREATE PROCEDURE GetRelapsedTimeOfDonatedBlood()
BEGIN
 SELECT
   iddonor, bloodGroupblood,
   (DATEDIFF(CURDATE(), dateRegisters)) AS ElapsedDays
 FROM
   Donor;
END//
DELIMITER ;

--11. get current inventory info
DELIMITER //
CREATE PROCEDURE GetCurrentInventoryInfo()
BEGIN
 SELECT bb.idBloodBank, bb.nameBB ,b.bloodGroup, COUNT(b.idBlood) AS InventoryCount
 FROM BloodBank bb
 LEFT JOIN Manager_Bloodbank mbb on bb.idBloodBank = mbb.idBloodBank
 LEFT join Blood b on mbb.idManager = b.idManager
 group by bb.idBloodbank , bb.nameBB, b.bloodGroup;
END//
DELIMITER ;


--show all procedures
   SHOW PROCEDURE STATUS;
