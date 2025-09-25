
CREATE Database ZooDB

--ตาราง AnimalType
CREATE TABLE AnimalType (
    animal_type_id INT NOT NULL PRIMARY KEY,
    type_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX) NULL);

    select * from AnimalType

--ตาราง Speciesinfo
CREATE TABLE Speciesinfo (
    species_info_id int PRIMARY KEY,
    common_name NVARCHAR(100) Not NULL,
    scientific_name NVARCHAR(100) NULL,
    habitat NVARCHAR(max) NULL,
    diet NVARCHAR(max) NULL,
    conservation_status NVARCHAR(100) NULL,
    description NVARCHAR(max) NULL);

    Select * from Speciesinfo

--ตาราง Enclosure
CREATE TABLE Enclosure (
    enclosure_id int PRIMARY KEY,
    name NVARCHAR(100) Not NULL,
    location NVARCHAR(200) NULL);

    Select * from Enclosure

--ตาราง Keeper 
CREATE TABLE Keeper (
    keeper_id int PRIMARY KEY,
    name NVARCHAR(100) Not NULL,
    phone NVARCHAR(50) NULL,
    email NVARCHAR(100) NULL);

    Select * from Keeper

--ตาราง EnclosureKeeper
CREATE TABLE EnclosureKeeper (
    enclosure_id int Not NULL,
    keeper_id    int Not NULL,
    PRIMARY KEY(enclosure_id, keeper_id),
    FOREIGN KEY(enclosure_id) REFERENCES Enclosure(enclosure_id),
    FOREIGN KEY(Keeper_id) REFERENCES Keeper(keeper_id));

    Select * from EnclosureKeeper

--ตาราง Food
CREATE TABLE Food (
    food_id int PRIMARY KEY,
    name NVARCHAR(100) Not NULL,
    type NVARCHAR(100) NULL,
    unit NVARCHAR(50) NULL);

    Select * from Food

--ตาราง Animal
CREATE TABLE Animal (
    animal_id int PRIMARY KEY, 
    name NVARCHAR(100) NOt NULL,
    gender NVARCHAR(10) NULL,
    birth_date DATE NULL,
    enclosure_id int NULL,
    animal_type_id int NULL,
    species_info_id int NULL,
    FOREIGN KEY(enclosure_id) REFERENCES Enclosure(enclosure_id),
    FOREIGN KEY(animal_type_id) REFERENCES AnimalType(animal_type_id),
    FOREIGN KEY(species_info_id) REFERENCES Speciesinfo(species_info_id));

    Select * from Animal

--ตาราง FeedingSchedule
CREATE TABLE FeedingSchedule(
    feeding_id int PRIMARY KEY,
    animal_id int Not NULL,
    food_id int Not NULL,
    amount DECIMAL(10,2) NULL,
    feeding_date DATE NULL,
    feeding_time TIME NULL,
    keeper_id int NULL,
    FOREIGN KEY(animal_id) REFERENCES Animal(animal_id),
    FOREIGN KEY(food_id) REFERENCES Food(food_id),
    FOREIGN KEY(keeper_id) REFERENCES Keeper(keeper_id));

    Select * from FeedingSchedule


