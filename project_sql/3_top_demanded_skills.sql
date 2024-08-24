-- The first query is from an exercise and its specific to Data Anlyst jobs.
WITH remote_job_skills AS (
    SELECT
        skills_job_dim.skill_id,
        COUNT(skills_job_dim.skill_id) AS skill_count
    FROM 
        skills_job_dim
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_postings_fact.job_work_from_home = TRUE AND
        job_postings_fact.job_title_short = 'Data Analyst'
    GROUP BY
        skills_job_dim.skill_id
) 
SELECT
    remote_job_skills.skill_id,
    skills_dim.skills,
    remote_job_skills.skill_count
FROM 
    remote_job_skills
INNER JOIN skills_dim ON Skills_dim.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5

-- Alternative method


SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5 

-- Variations can be added to this query like the job_title_job, job_location ans so on
