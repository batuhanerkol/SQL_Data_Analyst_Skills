/*
What are the most optimal skills to learn (it's in high demand and high payind skill)
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries 
- Why? Target skills that offer job security and finencialy benefit offering strategic insight 
for career development in data analysis
*/

WITH skills_demand AS (
    SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count

FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True 

GROUP BY    
    skills_dim.skill_id

), average_salary AS (
     
    SELECT 
    skills_job_dim.skill_id,
    AVG(salary_year_avg)::INTEGER AS avg_salary

FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL

GROUP BY    
    skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary

FROM 
    skills_demand

INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id

ORDER BY
    demand_count DESC,
    avg_salary DESC

LIMIT 25

-- rewriting same query ore concisely 

SELECT  
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    AVG(job_postings_fact.salary_year_avg)::INTEGER AS avg_salary

FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True

GROUP BY 
    skills_dim.skill_id

HAVING
    COUNT(skills_job_dim.job_id) > 10

ORDER BY   
    demand_count DESC,
    avg_salary DESC

LIMIT 25