# 🧠 OCD Patient Data Analysis | SQL Portfolio Project

## 📌 Project Overview

This project analyzes a clinical dataset of patients diagnosed with Obsessive-Compulsive Disorder (OCD) to uncover patterns in **demographics, symptom severity, diagnosis trends, and behavioral characteristics**.

Using SQL, I transformed raw healthcare data into actionable insights by analyzing **gender distribution, ethnicity patterns, time trends, and dominant symptom behaviors**.

---

## 🎯 Business Questions

This project answers key analytical questions relevant to healthcare decision-making:

* What is the **gender distribution** of OCD patients?
* Do **male vs female patients** differ in symptom severity?
* Which **ethnic groups** show higher OCD prevalence and severity?
* How do OCD diagnoses trend **month-over-month (MoM)**?
* What are the most common **obsession and compulsion types**, and how severe are they?

💡 **Business Value:**

* Identify **high-risk patient segments**
* Support **personalized treatment strategies**
* Improve **resource allocation in mental healthcare**
* Enable **data-driven clinical insights**

---

## 👥 Target Audience

* Healthcare providers & mental health clinics
* Healthcare / Data Analysts
* Researchers studying behavioral health

---

## 📂 Dataset Description

* **Source:** Kaggle – OCD Patient Dataset (Demographics & Clinical Data)
* **Format:** CSV (structured dataset)
* **Size:** ~1,500 patients | ~17 features
* **Grain:** Each row represents one patient

### 🔑 Key Features:

* **Demographics:** Gender, Ethnicity, Age
* **Clinical Data:** Diagnosis date, medical background
* **Symptoms:** Obsession type, compulsion type
* **Severity Metric:** Y-BOCS Score (Obsessions)
* **Treatment-related attributes**

---

## 🛠 Tools & Skills

* SQL (MySQL)
* Data Aggregation & Grouping
* Data Cleaning & Transformation
* Time-Series Analysis (MoM)
* Analytical Thinking & Business Framing

---

## 🔍 Key Analysis

### 1. Gender Distribution & Severity

* Calculated total patients by gender
* Derived percentage split (Male vs Female)
* Compared average obsession severity

#### 🚀 Queries
```sql
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
```

#### 💡 Queries result

<img width="267" height="51" alt="Screenshot 2026-04-01 at 11 05 05" src="https://github.com/user-attachments/assets/8e50becb-7241-48c1-a86d-3a9723608348" />

#### 📌 Insight:
> OCD prevalence may differ by gender, but symptom severity appears consistent across groups, suggesting treatment intensity should not be gender-biased.

---

### 2. Ethnicity Analysis

* Counted patients by ethnicity
* Calculated average obsession score per group
  
#### 🚀 Queries  
```sql
SELECT
	Ethnicity,
	count(`Patient ID`) as patient_count,
	round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
FROM healthcare.ocd_patient_dataset
GROUP BY 1
ORDER BY 2
;
```
#### 💡 Queries result
<img width="231" height="100" alt="Screenshot 2026-04-01 at 11 20 19" src="https://github.com/user-attachments/assets/1d3703d9-6873-4d4a-b6bf-aaff60ed46cd" />

📌 Insight:
> While prevalence varies by ethnicity, severity remains fairly uniform, suggesting OCD impacts patients similarly across demographic groups.

---

### 3. Diagnosis Trend Over Time (MoM)

* Grouped diagnosis data by month
* Calculated number of new diagnoses

#### 🚀 Queries
```sql
-- DATA PREPARATION
alter table healthcare.ocd_patient_dataset
modify `OCD Diagnosis Date` date;

-- QUERY
SELECT
	date_format(`OCD Diagnosis Date`,'%Y-%m-01 00:00:00') as month,
    -- `OCD Diagnosis Date`
	count(`Patient ID`) as patient_count
FROM healthcare.ocd_patient_dataset
GROUP BY 1
ORDER BY 1;
```

#### 💡 Queries result
<img width="219" height="343" alt="Screenshot 2026-04-01 at 11 23 30" src="https://github.com/user-attachments/assets/a8c59480-e6d8-469b-b228-348752e0ec76" />

📌 Insight:
OCD diagnosis is not evenly distributed over time, indicating opportunities for better screening and awareness campaigns during peak periods.

---

### 4. Obsession Type Analysis

* Identified most common obsession types
* Measured their average severity
  
#### 🚀 Queries
```sql
SELECT 
	`Obsession Type`, 
	count(`Patient ID`) as patient_count, 
	round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
FROM healthcare.ocd_patient_dataset
GROUP BY 1
ORDER BY 2;
```
#### 💡 Queries result

<img width="257" height="110" alt="Screenshot 2026-04-01 at 11 25 30" src="https://github.com/user-attachments/assets/bd1ded01-f489-42c0-ae9b-392b49ee3441" />

📌 Insight:
OCD symptoms are concentrated around key obsession patterns, meaning targeted therapies could be more effective than generalized treatment approaches.

---

### 5. Compulsion Type Analysis

* Identified most common compulsion behaviors
* Compared their severity levels

#### 🚀 Queries
```sql
SELECT 
	`Compulsion Type`, 
	count(`Patient ID`) as patient_count, 
	round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
FROM healthcare.ocd_patient_dataset
GROUP BY 1
ORDER BY 2;
```
#### 💡 Queries result
<img width="270" height="110" alt="Screenshot 2026-04-01 at 11 26 08" src="https://github.com/user-attachments/assets/cf9aa5e5-b11e-4972-9f5d-e2b980e6dad5" />

📌 Insight:
Common behavioral patterns dominate OCD cases, allowing providers to standardize treatment protocols for the majority of patients.

---
#### 💡 Overall Insight

OCD severity is relatively consistent across demographic groups, while differences are more visible in ***patient distribution and behavioral patterns.***
This suggests that ***who gets OCD may vary,*** but ***how severe it is tends to be similar,*** highlighting ***the importance of early detection and targeted behavioral treatment.***

---

## 📈 Key Takeaways

* Built end-to-end SQL analysis for a real-world healthcare dataset
* Applied **segmentation (gender, ethnicity)** and **behavioral analysis (obsession/compulsion)**
* Implemented **time-series analysis (MoM trends)**
* Translated raw data into **business-relevant insights**

---

## 🚀 Future Improvements

* Build interactive dashboard (Power BI / Tableau)
* Add KPI metrics (severity index, high-risk segmentation)
* Perform correlation analysis (e.g., demographics vs severity)
* Use Python for predictive modeling

---

## 💼 Why This Project Matters

This project demonstrates my ability to:

* Analyze structured datasets using SQL
* Break down business questions into data queries
* Extract insights that support decision-making
* Think analytically across **healthcare + business contexts**

---
