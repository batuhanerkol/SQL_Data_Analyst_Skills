/*
What are the most in demand skiils for data analysts ? 
- Join job postings to inner join table similar to query 2
- Idendify top 5 in demand skills or data analysts
- Focus on all job posting
- Why ? Retrives he top 5 skilss with the highest demand in the job market, 
providing nsights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count

FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE job_title_short = 'Data Analyst' 

GROUP BY    
    skills

    ORDER BY 
    demand_count DESC
LIMIT 5