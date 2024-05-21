/*

 
2. List the names of registered donors who donated blood aged 18-28 years, and older 
male and female donors who also donated blood. 
3. List the registered donors who donated blood and who belong to the blood group 
considered universal donor, as well as the patients who belong to the blood group 
considered universal recipient. 
4. List the names of workers who work in the same blood bank as technical analyst 
‘Junaid’.
5. List registered donors who cannot donate (who have some illness). 
6. The percentage of male donors without any disease, where the percentage of donors 
without any disease is approximately 69.23%. 
7. List the hospital and patient with the highest number of requested bags.

*/


1. --List the names of the donors next to their address, who belong to the AB+ blood group and are female.
SELECT idDonor, nameD, surnameD, gender, d.bloodGroup, avenue_street, building_number, 
neighborhood 
FROM donor d, blood s 
WHERE d.idBlood = s.idBlood 
AND bloodGroupBlood = s.bloodGroup 
AND gender='F' 
AND d.bloodGroup = 'AB+'; 
2. 
SELECT idDonor, nameD, surnameD, gender, age 
FROM donor d, blood s 
WHERE d. idBlood = s. idBlood AND bloodGroupBlood = s.bloodGroup 
AND age >=18 AND age <=28 
UNION 
SELECT idDonor, nameD, surnameD, gender, max(age) 
FROM donor d, blood s 
WHERE d.idBlood = s. idBlood AND bloodGroupBlood = s. bloodGroup 
AND gender = 'M' 
UNION 
SELECT idDonor, nameD, surnameD, gender, max(age) 
FROM donor d, blood s 
WHERE d. idBlood = s. idBlood AND bloodGroupBlood = s. bloodGroup 
AND gender = 'F'; 
3. 
SELECT idDonor AS 'iD', nameD, surnameD, d. bloodGroup 
FROM donor d, blood s 
WHERE d. idBlood = s. idBlood 
AND bloodGroupBlood = s. bloodGroup 
AND d. bloodGroup = 'O-' 
UNION 
SELECT idPatient, nameP, surnameP, bloodGroup 
FROM patient 
WHERE bloodGroup = 'AB+'; 
4. 
SELECT nameM AS 'Name', surnameM AS 'Surname' 
FROM manager m, manager_bloodbank mb
WHERE g.idManager = gb.idManager 
AND gb.idBloodBank = (SELECT idBloodBank 
 FROM technical_analyst 
 WHERE nameTA = 'Junaid') 
UNION 
SELECT nameRT, surnameRT 
FROM registration_team RT
WHERE RT. idBloodBank = (SELECT idBloodBank 
 FROM technical_analyst 
 WHERE nameAT = 'Junaid') 
UNION 
SELECT nameTA, surnameTA 
FROM technical_analyst TA 
WHERE TA.idBloodBank = (SELECT idBloodBank 
 FROM technical_analyst 
 WHERE nameTA = 'Junaid'); 
5. 
SELECT idDonor, nameD, surnameD 
FROM donor 
WHERE disease != 0; 
6.
SELECT ((count(nameD)*100)/18) AS ‘Disease Free Male Donors (%)’
FROM donor 
WHERE gender = 'M' 
AND disease = 0; 
7. 
SELECT h.idHospital AS ‘iD’, CONCAT(nameH, ' (hospital)') AS 'Name', 
r.amountBlood AS ‘Amount of Blood’
FROM hospital h, requests r, hospital_requests hr 
WHERE h.idHospital = hr.idHospital 
AND hr.idRequests = r.idRequests 
AND r.amountBlood = (SELECT max(amountBlood) FROM requests re, 
hospital_requests hre 
 WHERE hre.idRequests = re.idRequests) 
UNION ALL 
SELECT p.idPatient, CONCAT(nameP,' ',surnameP, ' (patient)'), r.amountBlood 
FROM patient p, requests r, patient_requests pr 
WHERE p.idPatient = pr.idPatient 
AND pr.idRequests = r.idRequests 
AND r.amountBlood = (SELECT max(amountBlood) FROM requests re, 
patient_requests pre 
 WHERE pre.idRequests = re.idRequests);
