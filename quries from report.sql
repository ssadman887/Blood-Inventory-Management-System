-- -- Get details about blood units and the patients who received them.
--    SELECT Blood.idBlood, Blood.bloodGroup, Patient.idPatient, Patient.nameP, Patient.surnameP
--    FROM Blood
--    JOIN Blood_Patient ON Blood.idBlood = Blood_Patient.idBlood
--    JOIN Patient ON Blood_Patient.idPatient = Patient.idPatient;



-- --  List Blood Donors Eligible for Donation:

--    SELECT * FROM Donor
--    WHERE disease = 0 AND age BETWEEN 18 AND 60;

-- --Find Blood Requests Fulfilled by Each Hospital:

-- SELECT Hospital.idHospital, Hospital.nameH, COUNT(*) AS RequestsFulfilled
-- FROM Hospital
-- JOIN Hospital_Requests ON Hospital.idHospital = Hospital_Requests.idHospital
-- GROUP BY Hospital.idHospital;

-- --Identify Blood Banks with Critical Blood Shortages:
-- SELECT idBloodBank, nameBB, COUNT(*) AS AvailableBloodUnits
-- FROM BloodBank
-- LEFT JOIN Blood ON BloodBank.idBloodBank = Blood.idBlood
-- GROUP BY BloodBank.idBloodBank
-- HAVING AvailableBloodUnits < 10;

 --Find the total number of donors for each blood group:
  SELECT bloodGroup, COUNT(*) as totalDonors
  FROM donor
  GROUP BY bloodGroup;

--Find the total number of patients for each blood group:
  SELECT bloodGroup, COUNT(*) as totalPatients
  FROM patient
  GROUP BY bloodGroup;

--Find the total number of requests for each blood group:
  SELECT bloodGroup, COUNT(*) as totalRequests
  FROM requests
  GROUP BY bloodGroup;

--Find the number of patients registered by each registration team.

SELECT nameER, surnameER, COUNT(*) AS numPatients
FROM patient
JOIN registration_team ON patient.idRT = registration_team.idRT
GROUP BY registration_team.nameER, registration_team.surnameER;

 --Find the max amount of blood requested by each hospital.

SELECT nameH, AVG(amountBlood) AS avgBlood
FROM hospital
JOIN hospital_requests ON hospital.idHospital = hospital_requests.idHospital
JOIN requests ON hospital_requests.idRequests = requests.idRequests
GROUP BY hospital.nameH;


-- --find relapsed time of all donated blood

-- SELECT
--     iddonor,bloodGroupblood,
--     (DATEDIFF(CURDATE(), dateRegisters)) AS ElapsedDays
-- FROM
--     Donor;

-- --find  all expired donated blood 
-- SELECT * FROM donor
-- WHERE DATEDIFF(CURDATE(), dateRegisters) >= 120;

-- --Find Hospitals and Their Pending Blood Requests:
--  SELECT h.idHospital, h.nameH, COUNT(hr.idRequests) AS PendingRequests
--  FROM Hospital h
--  LEFT JOIN Hospital_Requests hr ON h.idHospital = hr.idHospital
--  GROUP BY h.idHospital, h.nameH;


 --Retrive blood with donation details


--  --Get info on current inventory

--  Select bb.idBloodBank, bb.nameBB ,b.bloodGroup, COUNT(b.idBlood) AS InventoryCount
--  FROM BloodBank bb
--  LEFT JOIN Manager_Bloodbank mbb on bb.idBloodBank = mbb.idBloodBank
--  LEFT join Blood b on mbb.idManager = b.idManager
--  group by bb.idBloodbank , bb.nameBB, b.bloodGroup;