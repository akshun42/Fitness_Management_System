CREATE DATABASE FitnessWellnessDB;
USE FitnesswellnessDB;

CREATE TABLE HealthMetrics (
    Metric_Record_ID INT  PRIMARY KEY,
    sleep_schedule TIME,
    BMI DECIMAL(5,2),
    BloodPressure VARCHAR(20),
    FitnessLevel VARCHAR(50),
    Height DECIMAL(5,2),
    Weight DECIMAL(5,2),
    HeartRate INT
);

CREATE TABLE Account (
    Password VARCHAR(100),
    Username VARCHAR(50),
    Account_id INT PRIMARY KEY
);

CREATE TABLE User_Record (
    Age INT,
    Gender VARCHAR(10),
    Location VARCHAR(100),
    Name VARCHAR(100) PRIMARY KEY,
    Phone_number VARCHAR(20),
    Account_id INT,
    FOREIGN KEY (Account_id) REFERENCES Account(Account_id)
);
CREATE TABLE Membership_plan (
    Start_date DATE,
    End_date DATE,
    Pricing DECIMAL(8, 2) CHECK (Pricing >= 0),
    Membership_ID INT PRIMARY KEY NOT NULL
);

CREATE TABLE Instructor (
    Qualification VARCHAR(100),
    Instructor_name VARCHAR(100) PRIMARY KEY NOT NULL,
    Rating DECIMAL(3, 2),
    Courses_Taught varchar(50),
    Membership_ID INT NOT NULL,
    FOREIGN KEY (Membership_ID) REFERENCES Membership_plan(Membership_ID)
);

	CREATE TABLE Classes (
    Date DATE,
    Class_Type ENUM('Online', 'InPerson'),
    Capacity INT,
    Duration TIME,
    Class_ID INT PRIMARY KEY NOT NULL,
    Workout_Name VARCHAR(100),
    Instructor_Name VARCHAR(100),
    FOREIGN KEY (Instructor_Name) REFERENCES Instructor(Instructor_Name)
);

CREATE TABLE User (
    Name VARCHAR(100) NOT NULL,
    User_ID INT PRIMARY KEY NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Membership_ID INT,
    FOREIGN KEY (Membership_ID) REFERENCES Membership_plan(Membership_ID)
   
);


CREATE TABLE Activity (
    Type VARCHAR(100),
    Workout_Name VARCHAR(100) PRIMARY KEY NOT NULL,
    Calories_Burned DECIMAL(8, 2) not null,
    Duration TIME CHECK (Duration <= '01:00:00'),
    Class_ID INT NOT NULL,
    User_ID INT NOT NULL,
    FOREIGN KEY (Class_ID) REFERENCES Classes(Class_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);

CREATE TABLE Device (
    Type VARCHAR(50),
    Device_ID INT PRIMARY KEY NOT NULL,
    Last_Sync DATETIME,
    Battery_Level DECIMAL(5,2),
    Metric_Record_ID INT NOT null,
    User_ID INT NOT NULL,
    FOREIGN KEY (Metric_Record_ID) REFERENCES HealthMetrics(Metric_Record_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);

CREATE TABLE Nutrition_Record (
    Log_Date DATE NOT NULL,
    Nutrition_Log_ID INT PRIMARY KEY,
    Calories DECIMAL(8, 2),
    Food VARCHAR(255),
    Macros VARCHAR(255),
    User_ID INT NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);

CREATE TABLE Fitness_Goal (
    Duration INT,
    Target_Weight DECIMAL(8, 2),
    Membership_ID INT,
    Fitness_ID INT PRIMARY KEY NOT NULL,
    FOREIGN KEY (Membership_ID) REFERENCES Membership_plan(Membership_ID)
);


INSERT INTO Fitness_Goal (Duration, Target_Weight, Membership_ID, Fitness_ID) 
VALUES 
(30, 70.5, 101, 1234567),
(60, 65.0, 102, 2345678),
(45, 80.0, 103, 3456789),
(90, 72.0, 104, 4567890),
(30, 68.5, 105, 5678901),
(45, 75.0, 106, 6789012),
(60, 70.0, 107, 7890123),
(90, 68.0, 108, 8901234),
(30, 78.5, 109, 9876543),
(60, 67.0, 110, 8765432),
(45, 82.0, 111, 7654321),
(90, 70.5, 112, 6543210),
(30, 76.0, 113, 5432109),
(60, 69.5, 114, 4321098),
(45, 84.0, 115, 3210987),
(90, 69.0, 116, 2109876),
(30, 80.5, 117, 1098765),
(60, 66.0, 118, 9876541),
(45, 85.0, 119, 8765430),
(90, 67.5, 120, 7654329),
(30, 79.0, 121, 6543218),
(60, 64.5, 122, 5432107),
(45, 83.5, 123, 4321096),
(90, 66.5, 124, 3210985),
(30, 81.5, 125, 2109874),
(60, 63.0, 126, 1098763),
(45, 86.0, 127, 9876542),
(90, 66.0, 128, 8765431),
(30, 82.5, 129, 7654320),
(60, 61.5, 130, 6543219);







