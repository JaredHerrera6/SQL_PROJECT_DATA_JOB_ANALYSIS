/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Dataanalyst roles that re available remotely
- Focuses on jib psotings with specified salaries (remove nulls)
- Why? Hightlight the top-paying opportunities for Data Analysts, offering insights into employement opportunities
*/

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
AND job_location = 'Anywhere'
AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10 


-- Taking as step further to see the name of the company
-- going to left join into the Company_dim table

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name

FROM
    job_postings_fact
LEFT JOIN company_dim
ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
AND job_location = 'Anywhere'
AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10 

