-- What are the most highest paying data analyst jobs --
-- Q1 -> Top 10 highest jobs in Remote --
-- Q2 -> Should Specify Salaries (not null) --
-- Q3 -> Include company names --


SELECT	
	job_id,
	job_title,
  name AS company_name,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date
FROM
  job_postings_fact jpf
LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id
WHERE
  job_title_short LIKE '%Data Analyst%' AND
  job_location LIKE '%Anywhere%' AND
  salary_year_avg IS NOT NULL
ORDER BY
  salary_year_avg DESC

Limit 10;



-- Highest and lowest salary paying companies for Data Analyst role

(
    SELECT 
        c.name AS company_name,
        j.salary_year_avg,
        'Highest' AS salary_level
    FROM 
        job_postings_fact j
    JOIN 
        company_dim c ON j.company_id = c.company_id
    WHERE 
        LOWER(j.job_title_short) = 'data analyst'
        AND j.salary_year_avg IS NOT NULL
    ORDER BY 
        j.salary_year_avg DESC
    LIMIT 1
)
UNION
(
    SELECT 
        c.name AS company_name,
        j.salary_year_avg,
        'Lowest' AS salary_level
    FROM 
        job_postings_fact j
    JOIN 
        company_dim c ON j.company_id = c.company_id
    WHERE 
        LOWER(j.job_title_short) = 'data analyst'
        AND j.salary_year_avg IS NOT NULL
    ORDER BY 
        j.salary_year_avg ASC
    LIMIT 1
);
