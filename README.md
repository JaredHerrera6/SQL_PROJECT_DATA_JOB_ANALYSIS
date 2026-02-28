# Introduction 
Dive into the data job market? Focusing on data analyst roles, this project 
ecpores top paying jobs, in demand skills, and where high
demand meets high salary in data analytics.

SQL queries? Check them ouyt here: [project_sql folder](/project_sql/)
# Background
Driven by a quest to navigate th edata analyst job market
more effectively, this project was born from a desire
to pinpoint top-paid and in-demand skills, streamlining 
others work to find optimal jobs.

Data hails from  [SQL Course](https://lukebarousse.com/sql). Its packed
with insights on job titles, salaries, locations, and essential skills

### THe questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are assoiciated with higher salaries?
5. What are the most optimal skills to learn?
# Tools I used
For my deep dive into the data analyst job market, 
I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis , allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system ,
ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management 
and executing SQL queries
- **Git & GitHub:** Essential for versio control 
and sharing my SQL scripts and analysis, ensuring collaboration and project tracking. 

# The analysis
 Each query for this project aimed at investigation specific aspects 
 of the data analyst job market. Heres how i approached each question:

### 1.Top Paying Data Analyst Jobs
To identify the highest_paying roles , I filtered data analyst position by average yearly salary and location , focusing on remote jobs. This queery highlight the high payiing opportunities in the field. 
``` sql
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
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles sapn from 
$184,000 to $650,000, indicating significant salary potential in the field. 
- **Diverse Employers:** Companies like SmartAsset, MeTA, adn AT&T are among those
offering high salaries , showing a broad interest accross different industries
- **Job Title Variety:** There's a hight diversity in job titles, from Data Analyst to director of Analysts, refelcting varied roles and specializations within data analytics.

# What i learned
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:
- **Complex Query Crafting:** Mastered the art of advanced SQL , merging tables like a pro
- **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data_summarizing sidekicks.
- **Analytical Wizadry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightul SQL queries

# Conclusions
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics. 