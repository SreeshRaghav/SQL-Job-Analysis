COPY company_dim
FROM ' your path to csv '
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM ' your path to csv '
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM ' your path to csv '
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM ' your path to csv '
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
