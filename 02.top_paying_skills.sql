-- -- 2. find highest paid skills

select
  sd.skills,
  count(jpf.job_id) as high_demand,
  round(approx_quantiles(jpf.salary_year_avg, 2)[offset(1)],0) as high_paid
from
  `main.job_postings_fact` as jpf
left join
  `main.skills_job_dim` as sjd
on jpf.job_id = sjd.job_id
left join
  `main.skills_dim` as sd
on sjd.skill_id = sd.skill_id
where (jpf.job_title_short = 'Data Engineer' AND job_work_from_home = TRUE)
group by sd.skills
having high_demand > 100
order by high_paid desc
limit 10;


/*
[{
  "skills": "rust",
  "high_demand": "232",
  "high_paid": "210000.0"
}, {
  "skills": "terraform",
  "high_demand": "3248",
  "high_paid": "184000.0"
}, {
  "skills": "golang",
  "high_demand": "912",
  "high_paid": "184000.0"
}, {
  "skills": "spring",
  "high_demand": "364",
  "high_paid": "175500.0"
}, {
  "skills": "neo4j",
  "high_demand": "277",
  "high_paid": "170000.0"
}, {
  "skills": "graphql",
  "high_demand": "445",
  "high_paid": "165000.0"
}, {
  "skills": "zoom",
  "high_demand": "127",
  "high_paid": "165000.0"
}, {
  "skills": "gdpr",
  "high_demand": "582",
  "high_paid": "158731.0"
}, {
  "skills": "mongo",
  "high_demand": "265",
  "high_paid": "158000.0"
}, {
  "skills": "fastapi",
  "high_demand": "204",
  "high_paid": "157500.0"
}]

*/