CREATE TABLE manager( 
idManager INT  NOT NULL , 
nameM varchar(30) NOT NULL, 
surnameM varchar(30) NOT NULL,
CONSTRAINT PK_manager PRIMARY KEY (idManager)); 


CREATE TABLE bloodbank ( 
idBloodBank INT  NOT NULL , 
nameBB varchar(30) NOT NULL, 
avenue_street varchar(30) NOT NULL, 
building_number INT(4) NOT NULL, 
neighborhood varchar(30) NOT NULL,
city varchar(30) NOT NULL,
CONSTRAINT PK_bloodbank PRIMARY KEY(idBloodBank)); 


CREATE TABLE manager_bloodbank ( 
idManager INT   NOT NULL, 
idBloodBank INT   NOT NULL, 
CONSTRAINT PK_manager_bloodBank PRIMARY KEY (idManager, idBloodBank),
CONSTRAINT FK_manager_bloodBank1 FOREIGN KEY (idManager) REFERENCES manager (idManager) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK_manager_bloodBank2 FOREIGN KEY (idBloodBank) REFERENCES bloodbank (idBloodBank) ON UPDATE CASCADE ON DELETE CASCADE); 



CREATE TABLE registration_team ( 
idRT INT   NOT NULL , 
nameER varchar(30) NOT NULL, 
surnameER varchar(30) NOT NULL, 
idBloodBank INT    NOT NULL,
CONSTRAINT PK_registration_team PRIMARY KEY (idRT), 
CONSTRAINT FK_registration_team FOREIGN KEY (idBloodBank) REFERENCES bloodbank (idBloodBank) ON UPDATE CASCADE ON DELETE CASCADE); 


CREATE TABLE technical_analyst( 
idTA INT   NOT NULL , 
nameTA varchar(30) NOT NULL, 
surnameAT varchar(30) NOT NULL, 
idBloodBank INT    NOT NULL, 
CONSTRAINT PK_technical_analyst PRIMARY KEY (idTA),
CONSTRAINT FK_technical_analyst FOREIGN KEY (idBloodBank) REFERENCES bloodbank (idBloodBank) ON UPDATE CASCADE ON DELETE CASCADE);


CREATE TABLE blood ( 
idBlood INT   NOT NULL , 
bloodGroup varchar(3) NOT NULL, 
idManager INT    NOT NULL, 
CONSTRAINT PK_blood PRIMARY KEY (idBlood, bloodGroup),
CONSTRAINT FK_blood1 FOREIGN KEY (idManager) REFERENCES manager (idManager) ON UPDATE CASCADE ON DELETE CASCADE); 


CREATE TABLE patient ( 
idPatient INT   NOT NULL , 
nameP varchar(30) NOT NULL, 
surnameP varchar(30) NOT NULL, 
gender ENUM('M', 'F', 'N') NOT NULL, 
bloodGroup varchar(30) NOT NULL, 
contact varchar(20) NOT NULL, 
avenue_street varchar(30) NOT NULL, 
building_number INT(4) NOT NULL, 
neighborhood varchar(30) NOT NULL,
city varchar(30) NOT NULL ,
dateRegisters date NOT NULL, 
idRT INT    NOT NULL, 
idManager INT    NOT NULL,
CONSTRAINT PK_patient PRIMARY KEY(idPatient), 
CONSTRAINT FK_patient1 FOREIGN KEY (idRT) REFERENCES registration_team (idRT) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK_patient2 FOREIGN KEY (idManager) REFERENCES manager (idManager) ON UPDATE CASCADE ON DELETE CASCADE); 


CREATE TABLE requests ( 
idRequests INT   NOT NULL , 
bloodGroup varchar(3) NOT NULL, 
amountBlood INT(10) NOT NULL,
CONSTRAINT PK_requests PRIMARY KEY(idRequests)); 



CREATE TABLE patient_requests ( 
idPatient INT    NOT NULL, 
idRequests INT    NOT NULL, 
CONSTRAINT PK_patient_requests PRIMARY KEY (idPatient, idRequests),
CONSTRAINT FK_patient_requests1 FOREIGN KEY (idPatient) REFERENCES patient (idPatient) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK_patient_requests2 FOREIGN KEY (idRequests) REFERENCES requests (idRequests) ON UPDATE CASCADE ON DELETE CASCADE); 



CREATE TABLE hospital ( 
idHospital INT   NOT NULL , 
nameH varchar(30) NOT NULL, 
avenue_street varchar(30) NOT NULL, 
building_number INT(4) NOT NULL, 
neighborhood varchar(30) NOT NULL,
city varchar(30) NOT NULL , 
idManager INT   NOT NULL, 
CONSTRAINT PK_hospital PRIMARY KEY (idHospital),
CONSTRAINT FK_hospital FOREIGN KEY (idManager) REFERENCES manager (idManager) ON UPDATE CASCADE ON DELETE CASCADE); 



CREATE TABLE hospital_requests ( 
idHospital INT   NOT NULL, 
idRequests INT   NOT NULL, 
CONSTRAINT PK_hospital_requests PRIMARY KEY (idHospital, idRequests),
CONSTRAINT FK_hospital_requests1 FOREIGN KEY (idHospital) REFERENCES hospital (idHospital) ON UPDATE CASCADE ON DELETE CASCADE, 
CONSTRAINT FK_hospital_requests2 FOREIGN KEY (idRequests) REFERENCES requests (idRequests) ON UPDATE CASCADE ON DELETE CASCADE); 


CREATE TABLE blood_patient ( 
idBlood INT   NOT NULL, 
bloodGroup varchar(3) NOT NULL, 
idPatient INT   NOT NULL, 
CONSTRAINT PK_blood_patient PRIMARY KEY (idBlood, bloodGroup, idPatient), 
CONSTRAINT FK_blood_patient1 FOREIGN KEY (idBlood, bloodGroup) REFERENCES blood (idBlood, bloodGroup) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK_blood_patient2 FOREIGN KEY (idPatient) REFERENCES patient (idPatient) ON UPDATE CASCADE ON DELETE CASCADE); 



CREATE TABLE technicalAnalyst_blood( 
idTA INT   NOT NULL, 
idBlood INT   NOT NULL, 
bloodGroup varchar(3) NOT NULL, 
CONSTRAINT PK_techinalAnalyst_blood PRIMARY KEY (idTA, idBlood, bloodGroup),
CONSTRAINT FK_techinalAnalyst_blood1 FOREIGN KEY (idTA) REFERENCES technical_analyst (idTA) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK_techinalAnalyst_blood2 FOREIGN KEY (idBlood, bloodGroup) REFERENCES blood (idBlood, bloodGroup) ON UPDATE CASCADE ON DELETE CASCADE); 



CREATE TABLE donor( 
idDonor INT   NOT NULL  , 
nameD varchar(30) NOT NULL, 
surnameD varchar(30) NOT NULL, 
gender ENUM('M', 'F', 'N') NOT NULL,
bloodGroup varchar(3) NOT NULL, 
contact varchar(20) NOT NULL, 
avenue_street varchar(30) NOT NULL, 
building_number INT(4) NOT NULL, 
neighborhood  varchar(30) NOT NULL, 
city varchar(30) DEFAULT NULL,
age INT(3) NOT NULL, 
disease INT(1) DEFAULT 0, 
idBlood INT(10) NOT NULL, 
bloodGroupBlood varchar(3) NOT NULL, 
idRT INT(10) NOT NULL, 
dateRegisters date NOT NULL, 
CONSTRAINT PK_donor1 PRIMARY KEY(idDonor),
CONSTRAINT CHK_donor_age CHECK (age >= 18 AND age <= 60),
CONSTRAINT FK_donor1 FOREIGN KEY (idBlood, bloodGroupBlood) REFERENCES blood (idBlood, bloodGroup) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK_donor2 FOREIGN KEY (idRT) REFERENCES registration_team (idRT) ON UPDATE CASCADE ON DELETE CASCADE); 

--trig for 30days

DELIMITER //

CREATE TRIGGER before_insert_donor
BEFORE INSERT ON donor
FOR EACH ROW
BEGIN
    DECLARE last_donation_date DATE;

    -- Find the last donation date for the current donor
    SELECT MAX(dateRegisters) INTO last_donation_date
    FROM donor
    WHERE idDonor = NEW.idDonor;

    -- Check if the donation interval is at least 30 days
    IF last_donation_date IS NOT NULL AND DATEDIFF(NEW.dateRegisters, last_donation_date) < 30 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Donor can only donate once every 30 days';
    END IF;
END //

DELIMITER ;
ALTER TABLE blood
DROP CONSTRAINT PK_blood;

INSERT INTO blood (idBlood,bloodGroup, idManager) VALUES (1,'A+', 11);