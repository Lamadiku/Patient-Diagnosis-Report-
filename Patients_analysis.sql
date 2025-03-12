--1. create the patients table

CREATE TABLE patient (
	PatientId INT, 
	FirstName VARCHAR (20),
	LastName VARCHAR (30),
	DOB DATE, 
	Gender VARCHAR (10),
	Weight_in_lbs DECIMAL (5,2),  
	City VARCHAR (60), 
	State VARCHAR (15), 
	Hospital VARCHAR (20), 
	Department VARCHAR (50),
	Phone INT, 
	Admission_Date DATE, 
	Diagnosis VARCHAR (50), 
	Diagnosis_Code INT,
	Doctor_First_Name VARCHAR (20),
	Doctor_Last_Name VARCHAR (30),
 	DoctorID INT
	);
	
--2.  Steps imported patients.csv file
-- Downloaded Lesson 14_Dataset patients.csv
--Right click on patient table and select Import data
--Select CSV|Import from CSV file on Import source and click next
--Input files: select downloaded patients.csv file and next 
--Tables mapping shows patients.csv and click next
--Leave the default check box on Data lead settings and next to confirm
--Click Proceed



--3. Queries of at least 4-5 data quality checks of the table including the count of patients in the table

SELECT PatientId, COUNT(PatientId) AS Total_patients
From patient p
GROUP BY PatientId;
-- Total Patients = 101

SELECT DISTINCT PatientId AS Distinct_patients
From patient p ;
-- No duplicate Patient ID found

SELECT PatientId , FirstName , DOB
FROM patient p 
WHERE PatientId IS NULL;
--No NULL values found for patient id

SELECT PatientId, FirstName, DOB , Admission_Date 
FROM patient p 
WHERE p.DOB > p.Admission_Date ;
-- No inconsistent date 

--4.1 Display the patient id and patient name with the current date

SELECT PatientId, (FirstName  ||" "|| LastName) AS Full_Name, 
STRFTIME('%Y %m %d','now')
FROM patient p;

--4.2 Display the old patient name and the new patient name in uppercase
SELECT UPPER(FirstName ||" "|| LastName) As Full_Name
FROM patient p ;

--4.3 the patients' combined names along with the total number of characters
SELECT UPPER(FirstName ||" "|| LastName) As Full_Name, 
LENGTH (FirstName ||" "|| LastName) AS Char_count_fullname
FROM patient p;

--4.4 the patient's combined name and the doctor's last name
ALTER TABLE patient 
ADD COLUMN PatientName_DocLastName VARCHAR(80);

UPDATE patient 
SET PatientName_DocLastName = UPPER(FirstName||"  "||LastName ||" - " ||Doctor_Last_Name);

--4.5 Extract the year for a given date and place it in a separate column
SELECT STRFTIME('%Y', DOB) AS DOB_year
FROM patient p ;

--4.6 calculate the patient's age at the time of admission
SELECT FirstName, LastName, Admission_Date - DOB AS Patient_Age
FROM patient p ;

--4.7 under 27 with 'Gen-Z' and all other patients called 'Other'

SELECT PatientId, UPPER(FirstName||"  "||LastName) AS FullName, 
CASE WHEN (Admission_Date - DOB) <= 27 THEN 'Gen-Z' ELSE 'Other'
END AS Age_Group
FROM patient p ;
