
INSERT INTO manager (idManager,nameM, surnameM) VALUES
(1,'Abdul', 'Rahman'),
(2,'Fatima', 'Begum'),
(3,'Mohammad', 'Ali'),
(4,'Ayesha', 'Akhtar'),
(5,'Kamal', 'Hossain'),
(6,'Nazia', 'Islam'),
(7,'Rahim', 'Khan'),
(8,'Nasreen', 'Binte'),
(9,'Iqbal', 'Ahmed'),
(10,'Farida', 'Sultana');


INSERT INTO bloodbank (idBloodBank,nameBB, avenue_street, building_number, neighborhood, city) VALUES
(1,'Dhaka Blood Bank', 'Shahbagh Road', 1234, 'Shahbagh', 'Dhaka'),
(2,'Chittagong Blood Bank', 'GEC Circle', 5678, 'Agrabad', 'Chittagong'),
(3,'Rajshahi Blood Bank', 'Boalia Road', 91011, 'Boalia', 'Rajshahi'),
(4,'Khulna Blood Bank', 'Moylapota Lane', 1213, 'Sonadanga', 'Khulna'),
(5,'Sylhet Blood Bank', 'Zinda Bazar', 1415, 'Zinda Bazar', 'Sylhet'),
(6,'Barisal Blood Bank', 'Sadarghat Road', 1617, 'Sadarghat', 'Barisal'),
(7,'Rangpur Blood Bank', 'Station Road', 1819, 'Station Road', 'Rangpur'),
(8,'Comilla Blood Bank', 'Kandirpar', 2021, 'Kandirpar', 'Comilla'),
(9,'Jessore Blood Bank', 'M.K. Road', 2223, 'M.K. Road', 'Jessore'),
(10,'Cox''s Bazar Blood Bank', 'Sea Beach Road', 2425, 'Sea Beach', 'Cox''s Bazar');


INSERT INTO manager_bloodbank (idManager, idBloodBank) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


INSERT INTO registration_team (idRT,nameER, surnameER, idBloodBank) VALUES
(1,'Mohammad', 'Akram', 1),
(2,'Sultana', 'Begum', 2),
(3,'Rahman', 'Miah', 3),
(4,'Anisa', 'Binte', 4),
(5,'Mamun', 'Hossain', 5),
(6,'Sabina', 'Khatun', 6),
(7,'Mustafizur', 'Rahman', 7),
(8,'Farhana', 'Akter', 8),
(9,'Imran', 'Khan', 9),
(10,'Nasrin', 'Jahan', 10);


INSERT INTO technical_analyst (idTA,nameTA, surnameAT, idBloodBank) VALUES
(1,'Sohel', 'Islam', 1),
(2,'Shabnam', 'Chowdhury', 2),
(3,'Aminul', 'Haque', 3),
(4,'Fahmida', 'Khatun', 4),
(5,'Rakib', 'Ahmed', 5),
(6,'Tasnim', 'Akter', 6),
(7,'Rafiq', 'Khan', 7),
(8,'Nahida', 'Binte', 8),
(9,'Jamal', 'Uddin', 9),
(10,'Salma', 'Sultana', 10);


INSERT INTO blood (idBlood,bloodGroup, idManager) VALUES
(1,'A+', 1),
(2,'B-', 2),
(3,'O+', 3),
(4,'AB+', 4),
(5,'B+', 5),
(6,'O-', 6),
(7,'A-', 7),
(8,'AB-', 8);


INSERT INTO patient (idPatient,nameP, surnameP, gender, bloodGroup, contact, avenue_street, building_number, neighborhood, city, dateRegisters, idRT, idManager) VALUES
(1,'Sadia', 'Akter', 'F', 'A+', '01711234567', 'Shahbagh Road', 567, 'Shahbagh', 'Dhaka', '2023-01-01', 1, 1),
(2,'Rahim', 'Miah', 'M', 'B-', '01987654321', 'GEC Circle', 123, 'Agrabad', 'Chittagong', '2023-02-01', 2, 2),
(3,'Sumaiya', 'Khatun', 'F', 'O+', '01897654321', 'Boalia Road', 456, 'Boalia', 'Rajshahi', '2023-03-01', 3, 3),
(4,'Kamal', 'Hossain', 'M', 'AB+', '01676543210', 'Moylapota Lane', 789, 'Sonadanga', 'Khulna', '2023-04-01', 4, 4),
(5,'Sabina', 'Chowdhury', 'F', 'B+', '01543210987', 'Zinda Bazar', 1011, 'Zinda Bazar', 'Sylhet', '2023-05-01', 5, 5),
(6,'Mizan', 'Rahman', 'M', 'O-', '01789012345', 'Sadarghat Road', 1213, 'Sadarghat', 'Barisal', '2023-06-01', 6, 6),
(7,'Nusrat', 'Jahan', 'F', 'A-', '01987654321', 'Station Road', 1415, 'Station Road', 'Rangpur', '2023-07-01', 7, 7),
(8,'Imran', 'Khan', 'M', 'AB-', '01876543210', 'Kandirpar', 1617, 'Kandirpar', 'Comilla', '2023-08-01', 8, 8),
(9,'Sadia', 'Sultana', 'F', 'A+', '01654321098', 'M.K. Road', 1819, 'M.K. Road', 'Jessore', '2023-09-01', 9, 9),
(10,'Rahman', 'Uddin', 'M', 'B-', '01789012345', 'Sea Beach Road', 2021, 'Sea Beach', 'Cox''s Bazar', '2023-10-01', 10, 10);


INSERT INTO requests (idRequests,bloodGroup, amountBlood) VALUES
(1,'A+', 10),
(2,'B-', 5),
(3,'O+', 8),
(4,'AB+', 12),
(5,'B+', 7),
(6,'O-', 6),
(7,'A-', 9),
(8,'AB-', 15),
(9,'A+', 11),
(10,'B-', 4);


INSERT INTO patient_requests (idPatient, idRequests) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


INSERT INTO hospital (idHospital,nameH, avenue_street, building_number, neighborhood, city, idManager) VALUES
(1,'Dhaka Medical Center', 'Green Road', 123, 'Dhanmondi', 'Dhaka', 1),
(2,'Chittagong General Hospital', 'Chawkbazar', 456, 'Chawkbazar', 'Chittagong', 2),
(3,'Rajshahi Central Hospital', 'Boalia Road', 789, 'Boalia', 'Rajshahi', 3),
(4,'Khulna City Hospital', 'Shibbari', 1011, 'Shibbari', 'Khulna', 4),
(5,'Sylhet Medical Complex', 'Zinda Bazar', 1213, 'Zinda Bazar', 'Sylhet', 5),
(6,'Barisal General Hospital', 'Sadarghat Road', 1415, 'Sadarghat', 'Barisal', 6),
(7,'Rangpur Medical Center', 'Station Road', 1617, 'Station Road', 'Rangpur', 7),
(8,'Comilla Central Hospital', 'Kandirpar', 1819, 'Kandirpar', 'Comilla', 8),
(9,'Jessore Health Complex', 'M.K. Road', 2021, 'M.K. Road', 'Jessore', 9),
(10,'Cox''s Bazar Hospital', 'Sea Beach Road', 2223, 'Sea Beach', 'Cox''s Bazar', 10);


INSERT INTO hospital_requests (idHospital, idRequests) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


INSERT INTO blood_patient (idBlood, bloodGroup, idPatient) VALUES
(1, 'A+', 1),
(2, 'B-', 2),
(3, 'O+', 3),
(4, 'AB+', 4),
(5, 'B+', 5),
(6, 'O-', 6),
(7, 'A-', 7),
(8, 'AB-', 8);


INSERT INTO technicalAnalyst_blood (idTA, idBlood, bloodGroup) VALUES
(1, 1, 'A+'),
(2, 2, 'B-'),
(3, 3, 'O+'),
(4, 4, 'AB+'),
(5, 5, 'B+'),
(6, 6, 'O-'),
(7, 7, 'A-'),
(8, 8, 'AB-');


INSERT INTO donor (idDonor,nameD, surnameD, gender, bloodGroup, contact, avenue_street, building_number, neighborhood, city, age, disease, idBlood, bloodGroupBlood, idRT, dateRegisters) VALUES
(1,'Abdul', 'Karim', 'M', 'A+', '01911223344', 'Green Road', 123, 'Dhanmondi', 'Dhaka', 30, 0, 1, 'A+', 1, '2023-7-01'),
(2,'Farida', 'Akhter', 'F', 'B-', '01899887766', 'Chawkbazar', 456, 'Chawkbazar', 'Chittagong', 25, 1, 2, 'B-', 2, '2023-7-02'),
(3,'Rahim', 'Uddin', 'M', 'O+', '01788996655', 'Boalia Road', 789, 'Boalia', 'Rajshahi', 35, 0, 3, 'O+', 3, '2023-7-03'),
(4,'Ayesha', 'Khatun', 'F', 'AB+', '01667778888', 'Shibbari', 1011, 'Shibbari', 'Khulna', 28, 0, 4, 'AB+', 4, '2023-7-04'),
(5,'Kamal', 'Islam', 'M', 'B+', '01556667777', 'Zinda Bazar', 1213, 'Zinda Bazar', 'Sylhet', 32, 0,5,'B+',5,'2023-8-05');

INSERT INTO donor (idDonor,nameD, surnameD, gender, bloodGroup, contact, avenue_street, building_number, neighborhood, city, age, disease, idBlood, bloodGroupBlood, idRT, dateRegisters) VALUES
(6,'Nasrin', 'Jahan', 'F', 'A+', '01447788990', 'Mirpur Road', 567, 'Mirpur', 'Dhaka', 26, 0, 1, 'A+', 1, '2023-7-05'),
(7,'Imran', 'Kabir', 'M', 'B-', '01336699887', 'Agrabad', 123, 'Agrabad', 'Chittagong', 40, 0, 2, 'B-', 2, '2023-7-06'),
(8,'Sabina', 'Hossain', 'F', 'O+', '01998887766', 'Lalbagh', 101, 'Lalbagh', 'Dhaka', 22, 1, 3, 'O+', 3, '2023-7-07'),
(9,'Kamal', 'Uddin', 'M', 'AB+', '01775554444', 'Shibbari', 202, 'Shibbari', 'Khulna', 29, 0, 4, 'AB+', 4, '2023-7-08'),
(10,'Sadia', 'Khatun', 'F', 'B+', '01661112222', 'Sylhet Road', 303, 'Sylhet Road', 'Sylhet', 33, 0, 5, 'B+', 5, '2023-7-09'),
(11,'Rahman', 'Ahmed', 'M', 'O-', '01557778888', 'Moylapota Lane', 404, 'Sonadanga', 'Khulna', 31, 0, 6, 'O-', 6, '2023-7-10'),
(12,'Farida', 'Sultana', 'F', 'A-', '01889991111', 'Zinda Bazar', 505, 'Zinda Bazar', 'Sylhet', 27, 0, 7, 'A-', 7, '2023-7-11'),
(13,'Iqbal', 'Hossain', 'M', 'AB-', '01667770000', 'Station Road', 606, 'Station Road', 'Rangpur', 38, 0, 8, 'AB-', 8, '2023-7-12'),
(14,'Nazmul', 'Islam', 'M', 'A+', '01446669999', 'Kandirpar', 707, 'Kandirpar', 'Comilla', 34, 0, 1, 'A+', 9, '2023-7-13'),
(15,'Rabeya', 'Binte', 'F', 'B-', '01334445555', 'Sea Beach Road', 808, 'Sea Beach', 'Cox''s Bazar', 36, 0, 2, 'B-', 10, '2023-7-14');



INSERT INTO donor (idDonor,nameD, surnameD, gender, bloodGroup, contact, avenue_street, building_number, neighborhood, city, age, disease, idBlood, bloodGroupBlood, idRT, dateRegisters) VALUES
(16,'Nasrin', 'Jahan', 'F', 'A+', '01447788990', 'Mirpur Road', 567, 'Mirpur', 'Dhaka', 26, 0, 1, 'A+', 1, '2023-8-05'),
(17,'Imran', 'Kabir', 'M', 'B-', '01336699887', 'Agrabad', 123, 'Agrabad', 'Chittagong', 40, 0, 2, 'B-', 2, '2023-8-06'),
(18,'Sabina', 'Hossain', 'F', 'O+', '01998887766', 'Lalbagh', 101, 'Lalbagh', 'Dhaka', 22, 1, 3, 'O+', 3, '2023-8-07'),
(19,'Kamal', 'Uddin', 'M', 'AB+', '01775554444', 'Shibbari', 202, 'Shibbari', 'Khulna', 29, 0, 4, 'AB+', 4, '2023-8-08'),
(20,'Sadia', 'Khatun', 'F', 'B+', '01661112222', 'Sylhet Road', 303, 'Sylhet Road', 'Sylhet', 33, 0, 5, 'B+', 5, '2023-8-09'),
(21,'Rahman', 'Ahmed', 'M', 'O-', '01557778888', 'Moylapota Lane', 404, 'Sonadanga', 'Khulna', 31, 0, 6, 'O-', 6, '2023-8-10'),
(22,'Farida', 'Sultana', 'F', 'A-', '01889991111', 'Zinda Bazar', 505, 'Zinda Bazar', 'Sylhet', 27, 0, 7, 'A-', 7, '2023-8-11'),
(23,'Iqbal', 'Hossain', 'M', 'AB-', '01667770000', 'Station Road', 606, 'Station Road', 'Rangpur', 38, 0, 8, 'AB-', 8, '2023-8-12'),
(24,'Nazmul', 'Islam', 'M', 'A+', '01446669999', 'Kandirpar', 707, 'Kandirpar', 'Comilla', 34, 0, 1, 'A+', 9, '2023-8-13'),
(25,'Rabeya', 'Binte', 'F', 'B-', '01334445555', 'Sea Beach Road', 808, 'Sea Beach', 'Cox''s Bazar', 36, 0, 2, 'B-', 10, '2023-8-14');