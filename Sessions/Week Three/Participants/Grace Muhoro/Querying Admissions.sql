SELECT * FROM BootcampDB.Admissions;

SELECT DISTINCT AdmissionType, COUNT(*)
FROM BootcampDB.Admissions
GROUP BY AdmissionType, Diagnosis;
