
CREATE TABLE manager( 
idManager integer(4) PRIMARY KEY, 
nameM varchar(30) NOT NULL, 
surnameM varchar(30) NOT NULL); 


CREATE TABLE bloodbank ( 
idBloodBank integer(4) PRIMARY KEY, 
nameBB varchar(30) NOT NULL, 
avenue_street varchar(30) NOT NULL, 
building_number integer(4) NOT NULL, 
neighborhood varchar(30) DEFAULT NULL,
city varchar(30) DEFAULT NULL); 


CREATE TABLE manager_bloodbank ( 
idManager integer(4) NOT NULL, 
idBloodBank integer(4) NOT NULL, 
CONSTRAINT PK_manager_bloodBank PRIMARY KEY (idManager, idBloodBank),
CONSTRAINT FK_manager_bloodBank FOREIGN KEY (idManager) REFERENCES manager (idManager),
CONSTRAINT FK_manager_bloodBank2 FOREIGN KEY (idBloodBank) 
REFERENCES bloodbank (idBloodBank) ON DELETE CASCADE ON UPDATE CASCADE); 


CREATE TABLE registration_team ( 
idRT integer(10) PRIMARY KEY, 
nameER varchar(30) NOT NULL, 
surnameER varchar(30) NOT NULL, 
idBloodBank integer(4) NOT NULL, 
FOREIGN KEY (idBloodBank) REFERENCES bloodbank (idBloodBank) ON DELETE CASCADE ON UPDATE CASCADE); 


CREATE TABLE technical_analyst( 
idTA integer(10) PRIMARY KEY, 
nameTA varchar(30) NOT NULL, 
surnameAT varchar(30) NOT NULL, 
idBloodBank integer(4) NOT NULL, 
FOREIGN KEY (idBloodBank) REFERENCES bloodbank (idBloodBank) ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE blood ( 
idBlood integer(10) NOT NULL, 
bloodGroup varchar(3) NOT NULL, 
idManager integer(4) NOT NULL, 
CONSTRAINT PK_blood PRIMARY KEY (idBlood, bloodGroup),
CONSTRAINT FK_blood2 FOREIGN KEY (idManager) REFERENCES manager (idManager) ON DELETE CASCADE ON UPDATE CASCADE); 


CREATE TABLE patient ( 
idPatient integer(10) PRIMARY KEY, 
nameP varchar(30) NOT NULL, 
surnameP varchar(30) NOT NULL, 
gender char(1) DEFAULT 'M', 
bloodGroup varchar(30) NOT NULL, 
contact varchar(20) NOT NULL, 
avenue_street varchar(30) NOT NULL, 
building_number integer(4) NOT NULL, 
neighborhood varchar(30) NOT NULL,
city varchar(30) NOT NULL ,
dateRegisters date NOT NULL, 
idRT integer(10) NOT NULL, 
idManager integer(4) NOT NULL, 
FOREIGN KEY (idRT) REFERENCES registration_team (idRT),
FOREIGN KEY (idManager) REFERENCES manager (idManager) ON DELETE CASCADE ON UPDATE CASCADE); 


CREATE TABLE requests ( 
idRequests integer(10) PRIMARY KEY, 
bloodGroup varchar(3) NOT NULL, 
amountBlood integer(10) NOT NULL); 



CREATE TABLE patient_requests ( 
idPatient integer(10) NOT NULL, 
idRequests integer(10) NOT NULL, 
CONSTRAINT PK_patient_requests PRIMARY KEY (idPatient, idRequests),
CONSTRAINT FK_patient_requests2 FOREIGN KEY (idPatient) REFERENCES patient (idPatient),
CONSTRAINT FK_patient_requests3 FOREIGN KEY (idRequests) REFERENCES requests (idRequests) ON DELETE CASCADE ON UPDATE CASCADE); 



CREATE TABLE hospital ( 
idHospital integer(10) PRIMARY KEY, 
nameH varchar(30) NOT NULL, 
avenue_street varchar(30) NOT NULL, 
building_number integer(4) NOT NULL, 
neighborhood varchar(30) NOT NULL,
city varchar(30) NOT NULL , 
idManager integer(4) NOT NULL, 
FOREIGN KEY (idManager) REFERENCES manager (idManager) ON DELETE CASCADE ON UPDATE CASCADE); 



CREATE TABLE hospital_requests ( 
idHospital integer(10) NOT NULL, 
idRequests integer(10) NOT NULL, 
CONSTRAINT PK_hospital_request PRIMARY KEY (idHospital, idRequests),
CONSTRAINT FK_hospital_requests FOREIGN KEY (idHospital) REFERENCES hospital (idHospital), 
CONSTRAINT FK_hospital_requisita3 FOREIGN KEY (idRequests) REFERENCES requests (idRequests) ON DELETE CASCADE ON UPDATE CASCADE); 


CREATE TABLE blood_patient ( 
idBlood integer(10) NOT NULL, 
bloodGroup varchar(3) NOT NULL, 
idPatient integer(10) NOT NULL, 
CONSTRAINT PK_blood_patient PRIMARY KEY (idBlood, bloodGroup, idPatient), 
CONSTRAINT FK_blood_patient1 FOREIGN KEY (idBlood, bloodGroup) REFERENCES blood (idBlood, bloodGroup),
CONSTRAINT FK_blood_patient2 FOREIGN KEY (idPatient) REFERENCES patient (idPatient) ON DELETE CASCADE ON UPDATE CASCADE); 



CREATE TABLE technicalAnalyst_blood( 
idTA integer(10) NOT NULL, 
idBlood integer(10) NOT NULL, 
bloodGroup varchar(3) NOT NULL, 
CONSTRAINT PK_techinalAnalyst_Sangue PRIMARY KEY (idTA, idBlood, bloodGroup),
CONSTRAINT FK_techinalAnalyst_blood1 FOREIGN KEY (idTA) REFERENCES technical_analyst (idTA),
CONSTRAINT FK_techinalAnalyst_blood2 FOREIGN KEY (idBlood, bloodGroup) REFERENCES blood (idBlood, bloodGroup) ON DELETE CASCADE ON UPDATE CASCADE); 



CREATE TABLE donor( 
idDonor integer(10) PRIMARY KEY, 
nameD varchar(30) NOT NULL, 
surnameD varchar(30) NOT NULL, 
gender char(1) DEFAULT 'M',
bloodGroup varchar(3) NOT NULL, 
contact varchar(20) NOT NULL, 
avenue_street varchar(30) NOT NULL, 
building_number integer(4) NOT NULL, 
neighborhood  varchar(30) NOT NULL, 
city varchar(30) DEFAULT NULL,
age integer(3) NOT NULL, 
disease integer(1) DEFAULT 0, 
idBlood integer(10) NULL, 
bloodGroupBlood varchar(3) NULL, 
idRT integer(10) NOT NULL, 
dateRegisters date NOT NULL, 
CONSTRAINT FK_donor FOREIGN KEY (idBlood, bloodGroupBlood) REFERENCES blood (idBlood, bloodGroup),
CONSTRAINT FK_donor1 FOREIGN KEY (idRT) REFERENCES registration_team (idRT) ON DELETE CASCADE ON UPDATE CASCADE); 



CREATE TABLE cont_donor ( 
Donor_Male_Sick int not null default 0, 
Donor_Male int not null null default 0, 
Donor_Female_Sick int not null null default 0, 
Donor_Female int not null null default 0, 
Total_Donors int not null null default 0);

CREATE TABLE donor (
    idDonor INT NOT NULL AUTO_INCREMENT,
    nameD VARCHAR(30) NOT NULL,
    surnameD VARCHAR(30) NOT NULL,
    gender ENUM('M', 'F', 'N') NOT NULL,
    bloodGroup VARCHAR(3) NOT NULL,
    contact VARCHAR(20) NOT NULL,
    avenue_street VARCHAR(30) NOT NULL,
    building_number INT(4) NOT NULL,
    neighborhood VARCHAR(30) NOT NULL,
    city VARCHAR(30) DEFAULT NULL,
    age INT(3) NOT NULL,
    disease INT(1) DEFAULT 0,
    idBlood INT(10) NOT NULL,
    bloodGroupBlood VARCHAR(3) NOT NULL,
    idRT INT(10) NOT NULL,
    dateRegisters DATE NOT NULL,
    CONSTRAINT PK_donor1 PRIMARY KEY (idDonor),
    CONSTRAINT CHK_donor_age CHECK (age >= 18 AND age <= 60),
    CONSTRAINT FK_donor1 FOREIGN KEY (idBlood, bloodGroupBlood) REFERENCES blood (idBlood, bloodGroup) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_donor2 FOREIGN KEY (idRT) REFERENCES registration_team (idRT) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT UQ_donor_donation UNIQUE (idDonor, dateRegisters), -- Unique constraint for a donor's donation date
    CONSTRAINT CHK_donor_donation_interval CHECK (DATEDIFF(CURDATE(), dateRegisters) >= 30) -- Check constraint for the 30-day donation interval
);


