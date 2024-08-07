select * from diabetes_prediction;
-- 1. Retrieve the Patient_id and ages of all patients.
select Patient_id, Age
from diabetes_prediction;

-- 2. Select all female patients who are olderthan 30.
select * from diabetes_prediction
where Gender='Female' and Age > 30;

-- 3. Calculate the average BMI of patients.
Select avg(BMI) as Avg_BMI from diabetes_prediction;

-- 4. List patients in descending order of blood glucose levels.
select Patient_id,Blood_glucose_level from diabetes_prediction order by Blood_glucose_level desc;


-- 5. Find patients who have hypertension and diabetes.
select * from diabetes_prediction
where hypertension = 1 and diabetes = 1;
 
 -- 6. Determine the number of patients with heart disease.
select count(*) as Total_heart_disease_patients from diabetes_prediction where Heart_disease=1;

-- 7. Group patients by smoking history and count how many smokers and non-smokers there are.
select smoking_history, count(*) as Total_patients from diabetes_prediction group by smoking_history;

-- 8. Retrieve the Patient_id of patients who have a BMI greater than the average BMI.
select Patient_id from diabetes_prediction
where bmi > (select avg(BMI) from diabetes_prediction);

-- 9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.
select Patient_id, MAX(HbA1c_level) as highest_HbA1c, MIN(HbA1c_level) as lowest_HbA1c
from diabetes_prediction group by Patient_id;

-- 10. Calculate the age of patients in years (assuming the current date as of now).
select Patient_id, timestampdiff(year, STR_TO_DATE(DOB, '%d-%m-%Y'), curdate()) AS Age
FROM diabetes_prediction;

-- 11. Rank patients by blood glucose level within each gender group.
select *, rank() over (partition by Gender order by Blood_glucose_level desc) as glucose_rank
from diabetes_prediction;

-- 12. Update the smoking history of patients who are olderthan 40 to "Ex-smoker."
update diabetes_prediction 
set smoking_history = 'Ex-smoker'
where Age > 40;

-- 13. Insert a new patient into the database with sample data.

insert into diabetes_prediction 
(EmployeeName, Patient_id, Gender, DOB, Age, Hypertension, Heart_disease, 
Smoking_history, BMI, HbA1c_level, Blood_glucose_level, diabetes)
values ('DEVID LEE', 'PT1101', 'Male', '01-01-1990', 34, 0, 0, 
'Non-smoker', 25.0, 5.5, 100, 0);

-- 14. Delete all patients with heart disease from the database.

delete from diabetes_prediction where Heart_disease = 1;


-- 15. Find patients who have hypertension but not diabetes using the EXCEPT operator

select * from diabetes_prediction 
where Hypertension = 1 
Except
select * from diabetes_prediction
where diabetes = 1;






-- 16. Define a unique constraint on the "patient_id" column to ensure its values are unique.

alter table diabetes_prediction
add constraint unique_patient_id UNIQUE (Patient_id);

-- 17. Create a view that displays the Patient_ids, ages, and BMI of patients.

create view patient_info as
select Patient_id,Age,BMI
FROM diabetes_prediction;

select * from patient_info;


-- 18. Suggest improvements in the database schema to reduce data redundancy and improve data integrity.
-- 19. Explain how you can optimize the performance of SQL queries on this dataset.

