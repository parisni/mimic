with drb_stats as (
	select min(itemid) as min,
	max(itemid) as max
	from chartevents
),
histogram as (
	select width_bucket(itemid, min, max, 9) as bucket,
	int4range(min(itemid), max(itemid), '[]') as range,
	count(*) as freq
	from chartevents, drb_stats
	group by bucket
	order by bucket
)
select bucket, range, freq,
repeat('*', (freq::float / max(freq) over() * 30)::int) as bar
from histogram;
