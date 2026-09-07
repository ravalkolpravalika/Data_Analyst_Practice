"Easy - level"
"1. Show first name, last name, and gender of patients whose gender is 'M'"
SELECT first_name, last_name, gender
FROM patients
where gender="M";

"2. Show first name and last name of patients who does not have allergies. (null)"
SELECT first_name, last_name
FROM patients
where allergies is NULL;

"3.Show first name of patients that start with the letter 'C'"
SELECT first_name
FROM patients
where first_name like "C%";

"4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)"
SELECT first_name, last_name
FROM patients
where weight between '100' and '120';

"5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'"
update patients
set allergies = "NKA"
where allergies is null;

"6. Show first name and last name concatinated into one column to show their full name."
select concat(first_name,' ',last_name) as full_name
from patients;

"7. Show first name, last name, and the full province name of each patient.
Example: 'Ontario' instead of 'ON'"
select patients.first_name, patients.last_name, province_names.province_name
from patients 
left join province_names 
on patients.province_id = province_names.province_id;

"8. Show how many patients have a birth_date with 2010 as the birth year. "
select count(*) as total_patients
from patients 
where year(birth_date) = 2010;

"9.Show the first_name, last_name, and height of the patient with the greatest height. "
select first_name,last_name,max(height)
from patients;

"10.Show all columns for patients who have one of the following patient_ids:
1,45,534,879,1000 "
select *
from patients
where patient_id in (1,45,534,879,1000);

"11. Show the total number of admissions "
select count(*) as total_admissions
from admissions;

"12.Show all the columns from admissions where the patient was admitted and discharged on the same day."
select * 
from admissions
where admission_date = discharge_date;

"13. Show the patient id and the total number of admissions for patient_id 579."
select patient_id, count(admission_date) as total_admissions
from admissions
where patient_id = 579;

"14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'. "
select distinct(city) as unique_cities
from patients
where province_id = 'NS';

"15. Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70 "
select first_name, last_name, birth_date
from patients
where height > 160 and weight > 70;

"16. Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'"
select first_name, last_name, allergies
from patients
where allergies is not null 
and city = 'Hamilton' ;

"Medium - level"
"17. Show unique birth years from patients and order them by ascending."
select distinct(year(birth_date)) as birth_year
from patients
order by birth_date asc;

"18. Show unique first names from the patients table which only occurs once in the list.
For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output." 
select first_name 
from patients
group by first_name 
having count(first_name) = 1;

"19. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long. "
select patient_id,first_name 
from patients
where first_name like "s%s"
and len(first_name)>=6;

"20. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table."
select patients.patient_id,patients.first_name,patients.last_name
from patients
join admissions
on patients.patient_id = admissions.patient_id
where diagnosis = 'Dementia';

"21. Display every patient's first_name.
Order the list by the length of each name and then by alphabetically. "
SELECT first_name
FROM patients
order by len(first_name), first_name;

"22. Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row."
select
sum(case when gender = 'M' then 1 else 0 end) as male_count,
sum(case when gender = 'F' then 1 else 0 end) as female_count
from patients;

"23. Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name."
select first_name, last_name, allergies
from patients
where allergies = 'Penicillin' or allergies = 'Morphine'
order by allergies, first_name, last_name;

"24.Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis. "
select patient_id, diagnosis
from admissions
group by patient_id,diagnosis 
having count(*) > 1;

"25. Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending."\
select city, count(*) as num_patients
from patients
group by city
order by num_patients desc, city asc;

"26. Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor" "
select first_name, last_name, 'Patient' as role
from patients
union all
select first_name, last_name, 'Doctor' as role
from doctors;

"27. Show all allergies ordered by popularity. Remove NULL values from query."
select allergies, count(allergies) as total_diagnosis
from patients
where allergies is not null
group by allergies
order by total_diagnosis desc ;

"28.Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date. "
select first_name,last_name,birth_date
from patients
where birth_date between '1970-01-01' and '1980-01-01'
order by birth_date;

"29. We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane"
select concat(upper(last_name),',',lower(first_name)) as new_name_format
from patients
order by first_name desc;

"30.Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000. "
select province_id,sum(height) as sum_height
from patients
group by province_id
having sum_height>=7000;

"31. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'" 
select max(weight)-min(weight) as weight_delta
from patients
where last_name='Maroni';

"32. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions."
select day(admission_date) as day_number,count(admission_date) as number_of_admissions
from admissions
group by day_number
order by number_of_admissions desc;

"33. Show all columns for patient_id 542's most recent admission_date."
select *
from admissions
where admission_date=(select max(admission_date) from admissions where patient_id=542)
and patient_id=542;

"34. Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters."
select patient_id,attending_doctor_id,diagnosis
from admissions
where patient_id%2!=0 and attending_doctor_id in (1,5,19)
       or 
      attending_doctor_id like '%2%' and len(patient_id)=3;
	  
"35. Show first_name, last_name, and the total number of admissions attended for each doctor.
Every admission has been attended by a doctor."
select doctors.first_name,doctors.last_name,count(admissions.admission_date) as admissions_total
from doctors
join admissions
where doctors.doctor_id = admissions.attending_doctor_id
group by attending_doctor_id;

"36.For each doctor, display their id, full name, and the first and last admission date they attended. "
select doctors.doctor_id,concat(doctors.first_name,' ',doctors.last_name) as full_name,
min(admissions.admission_date) as first_admission_date,
max(admissions.admission_date) as last_admission_date
from doctors
join admissions
on doctors.doctor_id = admissions.attending_doctor_id
group by doctor_id
order by admission_date;

"37.Display the total amount of patients for each province. Order by descending. "
select province_names.province_name, count(patients.patient_id) as patient_count
from province_names
join patients
where province_names.province_id = patients.province_id
group by province_name
order by patient_count desc;

"38.For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem." 
select concat(patients.first_name,' ',patients.last_name) as patient_name,
admissions.diagnosis, concat(doctors.first_name,' ',doctors.last_name) as doctor_name
from patients
join admissions
on patients.patient_id = admissions.patient_id 
join doctors
on admissions.attending_doctor_id = doctors.doctor_id;

"39. display the first name, last name and number of duplicate patients based on their first name and last name.
Ex: A patient with an identical name can be considered a duplicate.   "     
select first_name,last_name,count(patient_id) as num_of_duplicates
from patients
group by first_name,last_name
having count(patient_id) > 1;

"40. Display patient's full name,height in the units feet rounded to 1 decimal,weight in the unit pounds rounded to 0 decimals,
birth_date,gender non abbreviated.
Convert CM to feet by dividing by 30.48.
Convert KG to pounds by multiplying by 2.205."
select concat(first_name,' ',last_name) as patient_name,
round(height/30.48,1) as height , round(weight*2.205,0) as weight,birth_date,
case when gender = 'M' then 'MAle' else 'FEMALE' end as gender_type
from patients;


"41. Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)"
select patients.patient_id,patients.first_name,patients.last_name
from patients
left join admissions
ON patients.patient_id = admissions.patient_id
where admissions.patient_id is null;

"42. Display a single row with max_visits, min_visits, average_visits where the maximum, minimum and average number of admissions per day is calculated. Average is rounded to 2 decimal places."
SELECT
    MAX(visits) AS max_visits,
    MIN(visits) AS min_visits,
    ROUND(AVG(visits), 2) AS average_visits
FROM (
    SELECT admission_date, COUNT(*) AS visits
    FROM admissions
    GROUP BY admission_date
);

"43. Display every patient that has at least one admission and show their most recent admission along with the patient and doctor's full name." 
select concat(patients.first_name,' ',patients.last_name) as patient_name,
admissions.admission_date,
concat(doctors.first_name,' ',doctors.last_name) as doctor_name
from patients
join admissions
on patients.patient_id=admissions.patient_id
join doctors
on admissions.attending_doctor_id=doctors.doctor_id
where admission_date=(select max(admission_date) from admissions
                     where patients.patient_id=admissions.patient_id);
	
"Hard - Level"	
"45.Show all of the patients grouped into weight groups.Show the total amount of patients in each weight group.
Order the list by the weight group decending.
For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc."
SELECT
  COUNT(*) AS patients_in_group,
  FLOOR(weight / 10) * 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

"46. Show patient_id, weight, height, isObese from the patients table.Display isObese as a boolean 0 or 1.
Obese is defined as weight(kg)/(height(m)2) >= 30. weight is in units kg.height is in units cm."
SELECT patient_id, weight, height,
       CASE
           WHEN weight / ((height / 100.0) * (height / 100.0)) >= 30
           THEN 1
           ELSE 0
       END AS isObese
FROM patients;

"47. Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
Check patients, admissions, and doctors tables for required information."
select patients.patient_id,patients.first_name,patients.last_name,
doctors.specialty
from patients
join admissions
on patients.patient_id=admissions.patient_id
join doctors
on admissions.attending_doctor_id= doctors.doctor_id
where admissions.diagnosis='Epilepsy' and doctors.first_name='Lisa';

"48. All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date "
select admissions.patient_id,
concat(patients.patient_id,len(patients.last_name),year(patients.birth_date)) as temp_password
from patients
join admissions
on patients.patient_id=admissions.patient_id
group by admissions.patient_id;

"49. Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group."\
select
case when patients.patient_id%2=0 then 'Yes' else 'No' end as has_insurance,
sum(case when patients.patient_id%2=0 then 10 else 50 end )as cost_after_insurance
from patients
join admissions
on patients.patient_id=admissions.patient_id
group by has_insurance;

"50. Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name"
SELECT province_name
FROM province_names
JOIN patients
    ON province_names.province_id = patients.province_id
GROUP BY province_names.province_id, province_name
HAVING SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) >
       SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END);
	   
"51. We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'"
select *
from patients
where first_name like '__r%' and gender='F' and month(birth_date) in (2,5,12)
and weight between 60 and 80
and patient_id%2 != 0
and city='Kingston';

"52. Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form."
SELECT CONCAT(
    ROUND(100.0 * SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) / COUNT(*), 2),
    '%'
) AS percent_of_male_patients
FROM patients;

"53. For each day display the total amount of admissions on that day. Display the amount changed from the previous date."
SELECT
    admission_date,
    COUNT(*) AS total_admissions,
    COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY admission_date) AS change_from_previous
FROM admissions
GROUP BY admission_date
ORDER BY admission_date;

"54. Sort the province names in ascending order in such a way that the province 'Ontario' is always on top."
select province_name
from province_names
ORDER BY CASE WHEN province_name = 'Ontario' THEN 0 ELSE 1 END,
         province_name ASC;
		 
"55. We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year."
SELECT
    doctors.doctor_id,
    CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_name,
    doctors.specialty,
    YEAR(admissions.admission_date) AS selected_year,
    COUNT(*) AS total_admissions
FROM doctors
JOIN admissions
    ON doctors.doctor_id = admissions.attending_doctor_id
GROUP BY doctors.doctor_id, selected_year
ORDER BY doctors.doctor_id, selected_year;