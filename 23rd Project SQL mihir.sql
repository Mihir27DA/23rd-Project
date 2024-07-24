create database insurance;
use insurance;



-- 1. Select all columns for all patients.
SELECT 
    *
FROM
    insurance_data;

-- 2. Display the average claim amount for patients in each region.
SELECT 
    region, AVG(claim) AS avg_claim
FROM
    insurance_data
GROUP BY region;

-- 3. Select the maximum and minimum BMI values in the table.
SELECT 
    MAX(bmi) AS max_bmi, MIN(bmi) AS min_bmi
FROM
    insurance_data;

-- 4. Select the PatientID, age, and BMI for patients with a BMI between 40 and 50.
SELECT 
    PatientID, age, bmi
FROM
    insurance_data
WHERE
    bmi BETWEEN 40 AND 50;


-- 5. Select the number of smokers in each region.
SELECT 
    region, COUNT(PatientID)
FROM
    insurance_data
WHERE
    smoker = 'Yes'
GROUP BY region;

-- 6. What is the average claim amount for patients who are both diabetic and smokers?
SELECT 
    AVG(claim) AS avg_claim
FROM
    insurance_data
WHERE
    diabetic = 'Yes' AND smoker = 'Yes';
    
-- 7. Retrieve all patients who have a BMI greater than the average BMI of patients who are smokers.
SELECT 
    *
FROM
    insurance_data
WHERE
    smoker = 'Yes'
        AND bmi > (SELECT 
            AVG(bmi)
        FROM
            insurance_data
        WHERE
            smoker = 'Yes');
            
-- Average Bmi :

SELECT 
    AVG(bmi)
FROM
    insurance_data
WHERE
    smoker = 'Yes';


-- 8. Retrieve the total claim amount for each patient along with the average claim amount across all patients.

select *,sum(claim) over(partition by PatientID) as total_claim,
avg(claim) over() as avg_claim from insurance_data;



-- 9. Retrieve the top 3 patients with the highest claim amount, along with their respective claim amounts and the total claim amount for all patients.
select PatientID, claim,sum(claim) over() as total_claim from insurance_data
order by claim desc limit 3;


-- 10. Retrieve the rank of each patient based on their claim amount.

select * , rank() over(order by claim desc) from insurance_data;
