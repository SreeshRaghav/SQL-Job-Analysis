-- Skills required for high paying Data Analyst Jobs --
-- First get top paying DA jobs --
-- Second get the main skills required for that job with its pay --


-- Use CTE to create a temporary result set for high paying jobs --

WITH top_paying AS (
  SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
  FROM 
    job_postings_fact j
  LEFT JOIN company_dim c ON j.company_id = c.company_id
  WHERE
    job_title_short LIKE '%Data Analyst%' AND 
    job_location LIKE 'Anywhere' AND 
    salary_year_avg IS NOT NULL
  ORDER BY
    salary_year_avg DESC
  LIMIT 10
)

-- Now get the skills required for these high paying jobs --

SELECT
  t.*,
  skills
FROM
  top_paying t
INNER JOIN skills_job_dim sj ON t.job_id = sj.job_id
INNER JOIN skills_dim sd ON sj.skill_id = sd.skill_id
ORDER BY
  salary_year_avg DESC;



-- Top Skills per company --

WITH company_skills AS (
    SELECT 
        c.name AS company_name,
        sd.skills
    FROM 
        job_postings_fact j
    JOIN 
        company_dim c ON j.company_id = c.company_id
    JOIN 
        skills_job_dim sj ON j.job_id = sj.job_id
    JOIN 
        skills_dim sd ON sj.skill_id = sd.skill_id
      
),
ranked_skills AS (
    SELECT 
        company_name,
        skills,
        COUNT(*) AS skill_count,
        RANK() OVER (PARTITION BY company_name ORDER BY COUNT(*) DESC) AS skill_rank
    FROM 
        company_skills
    GROUP BY 
        company_name, skills
)

-- Only return top 3 skills per company --
SELECT *
FROM ranked_skills
WHERE skill_rank <= 3
ORDER BY company_name, skill_rank;
