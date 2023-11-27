/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Patient_ID]
      ,[Name]
      ,[Age]
      ,[Sex]
      ,[Location]
      ,[Admission_Date]
      ,[Discharge_Date]
      ,[Status]
      ,[Attending_Physician]
      ,[Case_Type]
      ,[Amount_Paid]
      ,[Department_Visited]
  FROM [ANALYSIS].[dbo].[Hospital]


  /* TOTAL COUNT OF PATIENTS*/
  SELECT COUNT(SEX) FROM HOSPITAL

 /* TOTAL COUNT OF MALE PATIENTS*/
 SELECT COUNT(SEX) [NO OF MALE PATIENTS] FROM HOSPITAL 
 WHERE SEX = 'M'

  /* TOTAL COUNT OF FEMALE PATIENTS*/
 SELECT COUNT(SEX) [NO OF FEMALE PATIENTS] FROM HOSPITAL 
 WHERE SEX = 'F'

  /* TOTAL COUNT OF ACTIVE PATIENTS*/
 SELECT COUNT([STATUS]) [ACTIVE PATIENTS] FROM HOSPITAL 
 WHERE STATUS = 'ACTIVE'

   /* TOTAL COUNT OF DISCHARGED PATIENTS*/
 SELECT COUNT([STATUS]) [DISCHARGED PATIENTS] FROM HOSPITAL 
 WHERE STATUS = 'DISCHARGED'

 /* DISTINCT COUNT OF DEPARTMENTS VISITED*/ 
 SELECT APPROX_COUNT_DISTINCT(DEPARTMENT_VISITED) FROM HOSPITAL

  /* DISTINCT COUNT OF CASE TYPE*/ 
 SELECT APPROX_COUNT_DISTINCT(CASE_TYPE) FROM HOSPITAL

 /* NUMBER OF TIMES DEPARTMENTS WERE VISITED BY PATIENTS*/
 SELECT DEPARTMENT_VISITED, COUNT(*) [NUMBER OF PATIENTS VISITED] FROM HOSPITAL
 GROUP BY DEPARTMENT_VISITED
 ORDER BY [NUMBER OF PATIENTS VISITED] DESC

  /* NUMBER OF CASE TYPE HAD BY PATIENTS*/
 SELECT CASE_TYPE, COUNT(*) [NUMBER OF CASE TYPE] FROM HOSPITAL
 GROUP BY CASE_TYPE
 ORDER BY  [NUMBER OF CASE TYPE] DESC

 /* NUMBER OF CASES PHYSISCIANS HANDLED*/
 SELECT ATTENDING_PHYSICIAN, COUNT(*) AS [NUMBER OF CASES HANDLED] FROM HOSPITAL
 GROUP BY ATTENDING_PHYSICIAN
 ORDER BY [NUMBER OF CASES HANDLED] DESC

 /* TOTAL AMOUNT MADE IN THE HOSPITAL*/
 SELECT SUM(AMOUNT_PAID) FROM HOSPITAL

/* AMOUNT MADE FROM EACH OF THE CASES*/
SELECT CASE_TYPE, SUM(AMOUNT_PAID) [AMOUNT PAID], COUNT(*) AS [AMOUNT MADE FROM CASE TYPE] FROM HOSPITAL
GROUP BY CASE_TYPE
ORDER BY [AMOUNT PAID] DESC

/* AMOUNT MADE FROM EACH DEPARTMENT IN THE HOPITAL*/
SELECT DEPARTMENT_VISITED, SUM(AMOUNT_PAID) [AMOUNT PAID], COUNT(*) AS [AMOUNT MADE FROM CASE TYPE] FROM HOSPITAL
GROUP BY DEPARTMENT_VISITED
ORDER BY [AMOUNT PAID] DESC

/* TOTAL AMOUNT MADE FROM  MALE AND FEMALE PATIENTS AND NUMBER OF TIMES VISITED*/
SELECT SEX, SUM(AMOUNT_PAID) [AMOUNT PAID BY PATIENTS], COUNT(*) [NUMBER OF TIMES VISITED] FROM  HOSPITAL
GROUP BY SEX
ORDER BY [AMOUNT PAID BY PATIENTS] DESC

/* PATIENTS THAT WERE ADMIITED ON 2025*/
SELECT * FROM HOSPITAL 
WHERE DATEPART(YEAR, ADMISSION_DATE) = 2025

/* PATIENTS THAT WERE ADMIITED ON 2024*/
SELECT * FROM HOSPITAL 
WHERE DATEPART(YEAR, ADMISSION_DATE) = 2024

/* PATIENTS THAT WERE ADMIITED ON 2023*/
SELECT * FROM HOSPITAL 
WHERE DATEPART(YEAR, ADMISSION_DATE) = 2023

/* PATIENTS THAT WERE ADMIITED ON 2022*/
SELECT * FROM HOSPITAL 
WHERE DATEPART(YEAR,ADMISSION_DATE)= 2022

/*YEAR WITH THE HIGHEST AMOUNT MADE*/
SELECT YEAR(ADMISSION_DATE) [YEAR ], SUM(AMOUNT_PAID) [AMOUNT MADE BY YEAR] FROM HOSPITAL
GROUP BY YEAR(ADMISSION_DATE)
ORDER BY [AMOUNT MADE BY YEAR] DESC

/* USING CONDIIONAL STATEMENT*/
SELECT UPPER([NAME]) NAME, AGE,SEX,UPPER([STATUS]) STATUS,
CASE WHEN AGE < 30 THEN 'YOUNG PATIENT'
     WHEN AGE < 45 THEN 'AVERAGE PATIENT'
	 WHEN AGE < 60 THEN 'AGED PATIENT'
	 ELSE 'OLD PATIENTS'
END AS AGE_RANGE
FROM HOSPITAL

SELECT NAME, AGE, SEX,
CASE WHEN SEX = 'M' THEN 'MALE'
     ELSE 'FEMALE'
END AS GENDER
FROM HOSPITAL

SELECT COUNT(PATIENT_ID) ID, SUM( 
CASE WHEN CASE_TYPE = 'MALARIA' THEN 1
     ELSE 0
END) AS [COUNT OF MALARIA] FROM HOSPITAL

SELECT COUNT(PATIENT_ID) [COUNT OF ID], SUM(
CASE SEX WHEN 'M' THEN 1
         ELSE 0
END) [COUNT OF MALE] FROM HOSPITAL

SELECT COUNT(PATIENT_ID) [COUNT OF ID], SUM(
CASE WHEN SEX = 'F' THEN 1
         ELSE 0
END) [COUNT OF FEMALE] FROM HOSPITAL


SELECT SUM(AMOUNT_PAID) [TOTAL AMOUNT], SUM(
CASE WHEN STATUS = 'Active' THEN AMOUNT_PAID
     ELSE 0
END) AS [TOTAL MADE FROM ACTIVE CASES] FROM HOSPITAL

SELECT SUM(AMOUNT_PAID) [TOTAL AMOUNT GENERATED], SUM(
CASE WHEN STATUS = 'Discharged' THEN AMOUNT_PAID
     ELSE 0
END) AS [TOTAL MADE FROM DISCHARGED CASES] FROM HOSPITAL

SELECT (MAX(AMOUNT_PAID) / MIN(AMOUNT_PAID)) AS [COMPENSATION RATIO] FROM HOSPITAL

SELECT MIN(AMOUNT_PAID) FROM HOSPITAL

