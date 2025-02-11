create or replace view analytics.driver_standings_by_year as
select
year,
driver_id,
forename,
surname,
sum(r1.points + coalesce(r2.points, 0)) as total_points,
sum(case when r1.position = 1 then 1 else 0 end) as wins,
sum(case when r1.position <= 3 then 1 else 0 end) as podiums
from f1.results as r1
join f1.drivers using (driver_id)
join f1.races using (race_id)
left join f1.sprint_results as r2 using (race_id, driver_id)
group by year, driver_id, forename, surname
order by total_points desc
;
