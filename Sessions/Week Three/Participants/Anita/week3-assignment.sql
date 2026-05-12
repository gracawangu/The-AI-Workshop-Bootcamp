/*
Task 1
Calculate the number of admissions for
each combination of admission type and diagnosis, 
then return only the unique admission types 
with their overall admission counts. 
*/

SELECT  
    AdmissionType,
    SUM(AdmissionCount) AS TotalAdmissionsCount

FROM (

SELECT 
    AdmissionType, 
    Diagnosis,
COUNT(*) AS AdmissionCount
FROM Admissions
GROUP BY AdmissionType, Diagnosis
) 

AS temp_table

GROUP BY AdmissionType
ORDER BY AdmissionType;

/* 
Result Set Batch 1 - Query 1
========================================

AdmissionType  TotalAdmissionsCount
-------------  --------------------
Elective       3                   
Emergency      5                   
Transfer       4                   
(3 rows affected)
*/


/*Task 2
Take the admissions table definition (no live data needed).
Use AI with the prompt template to generate a professional data dictionary.
*/

/*
Answer 

| Column Name     | Data Type     | Description                                                     | Example Values      | Notes                                         |
| --------------- | ------------- | --------------------------------------------------------------- | ------------------- | --------------------------------------------- |
| AdmissionID     | INT           | Unique identifier for each admission record                     | 1, 2, 3             | Primary Key; auto-increment (`IDENTITY(1,1)`) |
| PatientID       | INT           | Unique identifier for the patient associated with the admission | 1001                | Not Null; Foreign Key → Patients(PatientID)   |
| WardID          | INT           | Identifier for the hospital ward where the patient is admitted  | 12                  | Nullable; Foreign Key → Wards(WardID)         |
| AdmissionDate   | DATETIME      | Date and time when the patient was admitted                     | 2025-03-01 14:30:00 | Not Null                                      |
| DischargeDate   | DATETIME      | Date and time when the patient was discharged                   | 2025-03-05 10:00:00 | Nullable; null indicates ongoing admission    |
| AdmissionType   | NVARCHAR(50)  | Category of admission (e.g., emergency, elective)               | Emergency, Elective | Optional; consider standardizing values       |
| Diagnosis       | NVARCHAR(200) | Primary diagnosis recorded during admission                     | Pneumonia           | Free text or coded (e.g., ICD-10)             |
| DischargeReason | NVARCHAR(100) | Reason for discharge (e.g., recovered, transferred, deceased)   | Recovered           | Optional                                      |
*/
