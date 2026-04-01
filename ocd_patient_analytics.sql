-- 1. Count of F vs M that have OCD & Average Obsesion Score by Gender
/*
with data as (
SELECT 	Gender, 
		count(`Patient ID`) as patient_count, 
		round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score
FROM healthcare.`ocd_patient_dataset`
GROUP BY 1
ORDER BY 2
)

SELECT 

	sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
	sum(case when Gender = 'Male' then patient_count else 0 end) as count_male,
   
	sum(case when Gender = 'Female' then patient_count else 0 end)/
	(sum(case when Gender = 'Male' then patient_count else 0 end) + sum(case when Gender = 'Female' then patient_count else 0 end))*100
	as pct_female,

	sum(case when Gender = 'Male' then patient_count else 0 end)/
	(sum(case when Gender = 'Male' then patient_count else 0 end) + sum(case when Gender = 'Female' then patient_count else 0 end))*100
	as pct_male

from data
;
*/

-- 2.Count of nby Ethnicity and their respective Average Obsession Score

SELECT
	Ethnicity,
	count(`Patient ID`) as patient_count,
	round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
FROM healthcare.ocd_patient_dataset
GROUP BY 1
ORDER BY 2
;


-- 3. Number of people diagnosed MoM
alter table healthcare.ocd_patient_dataset
modify `OCD Diagnosis Date` date;

-- 4. What is the most common Obseession Type ((count) & it's respective Average Obsession Score

-- 5. What is the most common Compulsion type ((Count) & it's respectice Average Obsession Score)