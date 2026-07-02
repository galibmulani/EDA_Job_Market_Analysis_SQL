-- 3 find the optimal skills Data Engineer + WFH + not null

select
  sd.skills,
  count(*) as demand_count,
  round(ln(count(jpf.salary_year_avg)),1) as ln_demand_count,
  round(approx_quantiles(jpf.salary_year_avg, 2)[offset(1)],0) as median_salary,
  round(approx_quantiles(jpf.salary_year_avg,2)[offset(1)] * ln(count(jpf.salary_year_avg))/1000000,2) as optimal_skills,
from
  `main.job_postings_fact` as jpf
join
  `main.skills_job_dim` as sjd
on
  jpf.job_id = sjd.job_id
join
  `main.skills_dim` as sd
on
  sjd.skill_id = sd.skill_id
where jpf.job_title_short = 'Data Engineer' AND jpf.job_work_from_home = True AND jpf.salary_year_avg is not null
group by
  sd.skills
having count(*) > 100
order by optimal_skills desc
limit 25;

/*
[{
  "skills": "terraform",
  "demand_count": "193",
  "ln_demand_count": "5.3",
  "median_salary": "184000.0",
  "optimal_skills": "0.97"
}, {
  "skills": "python",
  "demand_count": "1133",
  "ln_demand_count": "7.0",
  "median_salary": "135000.0",
  "optimal_skills": "0.95"
}, {
  "skills": "sql",
  "demand_count": "1128",
  "ln_demand_count": "7.0",
  "median_salary": "130000.0",
  "optimal_skills": "0.91"
}, {
  "skills": "aws",
  "demand_count": "783",
  "ln_demand_count": "6.7",
  "median_salary": "136500.0",
  "optimal_skills": "0.91"
}, {
  "skills": "airflow",
  "demand_count": "386",
  "ln_demand_count": "6.0",
  "median_salary": "150000.0",
  "optimal_skills": "0.89"
}, {
  "skills": "spark",
  "demand_count": "503",
  "ln_demand_count": "6.2",
  "median_salary": "140000.0",
  "optimal_skills": "0.87"
}, {
  "skills": "kafka",
  "demand_count": "292",
  "ln_demand_count": "5.7",
  "median_salary": "145000.0",
  "optimal_skills": "0.82"
}, {
  "skills": "snowflake",
  "demand_count": "438",
  "ln_demand_count": "6.1",
  "median_salary": "135000.0",
  "optimal_skills": "0.82"
}, {
  "skills": "azure",
  "demand_count": "475",
  "ln_demand_count": "6.2",
  "median_salary": "128000.0",
  "optimal_skills": "0.79"
}, {
  "skills": "java",
  "demand_count": "303",
  "ln_demand_count": "5.7",
  "median_salary": "135000.0",
  "optimal_skills": "0.77"
}, {
  "skills": "kubernetes",
  "demand_count": "147",
  "ln_demand_count": "5.0",
  "median_salary": "150000.0",
  "optimal_skills": "0.75"
}, {
  "skills": "git",
  "demand_count": "208",
  "ln_demand_count": "5.3",
  "median_salary": "140000.0",
  "optimal_skills": "0.75"
}, {
  "skills": "scala",
  "demand_count": "247",
  "ln_demand_count": "5.5",
  "median_salary": "136000.0",
  "optimal_skills": "0.75"
}, {
  "skills": "databricks",
  "demand_count": "266",
  "ln_demand_count": "5.6",
  "median_salary": "132500.0",
  "optimal_skills": "0.74"
}, {
  "skills": "redshift",
  "demand_count": "274",
  "ln_demand_count": "5.6",
  "median_salary": "130000.0",
  "optimal_skills": "0.73"
}, {
  "skills": "gcp",
  "demand_count": "196",
  "ln_demand_count": "5.3",
  "median_salary": "135000.0",
  "optimal_skills": "0.71"
}, {
  "skills": "nosql",
  "demand_count": "193",
  "ln_demand_count": "5.3",
  "median_salary": "132500.0",
  "optimal_skills": "0.70"
}, {
  "skills": "pyspark",
  "demand_count": "152",
  "ln_demand_count": "5.0",
  "median_salary": "140000.0",
  "optimal_skills": "0.70"
}, {
  "skills": "hadoop",
  "demand_count": "198",
  "ln_demand_count": "5.3",
  "median_salary": "132707.0",
  "optimal_skills": "0.70"
}, {
  "skills": "mongodb",
  "demand_count": "136",
  "ln_demand_count": "4.9",
  "median_salary": "135500.0",
  "optimal_skills": "0.67"
}, {
  "skills": "docker",
  "demand_count": "144",
  "ln_demand_count": "5.0",
  "median_salary": "135000.0",
  "optimal_skills": "0.67"
}, {
  "skills": "go",
  "demand_count": "113",
  "ln_demand_count": "4.7",
  "median_salary": "140000.0",
  "optimal_skills": "0.66"
}, {
  "skills": "r",
  "demand_count": "133",
  "ln_demand_count": "4.9",
  "median_salary": "134775.0",
  "optimal_skills": "0.66"
}, {
  "skills": "bigquery",
  "demand_count": "123",
  "ln_demand_count": "4.8",
  "median_salary": "135000.0",
  "optimal_skills": "0.65"
}, {
  "skills": "github",
  "demand_count": "127",
  "ln_demand_count": "4.8",
  "median_salary": "135000.0",
  "optimal_skills": "0.65"
}]
*/
