-- 1. skills associated with data engineer
SELECT
  sd.skills,
  count(jpf.job_id) as demand_count
FROM
  `main.job_postings_fact` AS jpf
LEFT JOIN
  `main.skills_job_dim` AS sjd
ON
  jpf.job_id = sjd.job_id
LEFT JOIN
  `main.skills_dim` as sd
ON
  sjd.skill_id  = sd.skill_id
WHERE
  (job_title_short = 'Data Engineer' AND job_work_from_home = TRUE)
GROUP BY
  sd.skills
ORDER BY demand_count desc
LIMIT 10;

-- Output/Results:
/*
[{
  "skills": "sql",
  "demand_count": "29221"
}, {
  "skills": "python",
  "demand_count": "28776"
}, {
  "skills": "aws",
  "demand_count": "17823"
}, {
  "skills": "azure",
  "demand_count": "14143"
}, {
  "skills": "spark",
  "demand_count": "12799"
}, {
  "skills": "airflow",
  "demand_count": "9996"
}, {
  "skills": "snowflake",
  "demand_count": "8639"
}, {
  "skills": "databricks",
  "demand_count": "8183"
}, {
  "skills": "java",
  "demand_count": "7267"
}, {
  "skills": "gcp",
  "demand_count": "6446"
}]
*/