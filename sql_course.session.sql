 SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' date_time,
    EXTRACT(MONTH from job_posted_date ) AS date_month,
    EXTRACT(YEAR from job_posted_date) date_year
from   
    job_postings_fact
LIMIT 5;

SELECT
    count(job_id) as job_posted_count, 
    EXTRACT(MONTH from job_posted_date) AS month
from 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY month
ORDER BY
    job_posted_count DESC;



CREATE TABLE january_jobs AS 
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH from job_posted_date) = 1;


-- january
CREATE TABLE january_jobs AS 
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;
--February 
CREATE TABLE february_jobs AS 
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;
--MArch
CREATE TABLE march_jobs AS 
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

select job_posted_date
from march_jobs;

--CASe 

/*
Label new column as follows:
-'Anywhere' jobs as 'Remote'
- 'New York, NY' jobs as  'Local'
-Otherwise 'Onsite'
*/

select
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'REMOTE'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
from job_postings_fact;
--end

-- COunts the number of jobs listed of each location category
select
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'REMOTE'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
from job_postings_fact
where job_title_short = 'Data Analyst'
GROUP BY
    location_category;