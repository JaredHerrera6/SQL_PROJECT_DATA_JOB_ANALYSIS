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

--Creating tables of each months jobs
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

--SubQueries

with january_jobs AS ( --CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) =1
) -- CTE definition ends here

SELECT *
from  january_jobs;


-- Getting the copany name where one company_id from company_dim is in job_posting_fact
-- and job_no_degree_mention = true 
SELECT 
    company_id,
    name as company_name
FROM company_dim
where company_id IN( 
SELECT
    company_id
FROM
    job_postings_fact
WHERE
    job_no_degree_mention = true
ORDER BY
    company_id
);


 /*
 Find the companies that have the most job openings.
 -Get the total number of job postings per company id (job_posting_fact)
 - Return the total number of jobs with the company name (company_dim)

 */

    WITH company_job_count AS(
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
)

SELECT company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
 LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC



-- practice problem 
/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, andn count of postings requiring the skill
*/

-- Any time we do an aggregation, we have to do a group by

with remote_job_skills as (
 SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM
    skills_job_dim AS skills_to_job
Inner join job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
where job_postings.job_work_from_home = true AND 
        job_title_short = 'Data Analyst'
GROUP BY
    skill_id

)
select 
    skills.skill_id,
    skills as skill_name,
    skill_count
from remote_job_skills
Inner join skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY 
    skill_count DESC
LIMIT 5

--UNIONS (combines tables )
SELECT * 
FROM january_jobs;

SELECT * from february_jobs;

select * from march_jobs;

--  Get jobs and companies from january
SELECT 
    job_title_short,
    company_id,
    job_location
FROM january_jobs
UNION

--Get jobs from february 
SELECT 
    job_title_short,
    company_id,
    job_location
FROM february_jobs
UNION
--Get jobs from march 
SELECT 
    job_title_short,
    company_id,
    job_location
FROM march_jobs


--Union ALL combine the result of two or more select statements

SELECT 
    job_title_short,
    company_id,
    job_location
FROM january_jobs
UNION ALL

--Get jobs from february 
SELECT 
    job_title_short,
    company_id,
    job_location
FROM february_jobs
UNION ALL
--Get jobs from march 
SELECT 
    job_title_short,
    company_id,
    job_location 
FROM march_jobs


/*
Problem 8 
Find job postings from the first quarter that have a salary greater than $70k
-Combine job postings tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/

SELECT
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::date,
    quarter1_job_postings.salary_year_avg
from(
SELECT *
from january_jobs
union all 
SELECT *
from february_jobs
UNION all
select * 
from march_jobs) AS quarter1_job_postings
where
    quarter1_job_postings.salary_year_avg > 7000
    AND quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
quarter1_job_postings.salary_year_avg DESC 
