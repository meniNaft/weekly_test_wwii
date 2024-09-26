"שאילתא א"
explain analyze select
    air_force,
    count(mission_id) AS total_missions
from
    mission
where
    EXTRACT(YEAR FROM Mission_date) = 1943
group by
    Air_force, Target_City
order by
    total_missions DESC
limit 1;


--Limit  (cost=6093.81..6093.81 rows=1 width=22) (actual time=107.270..107.361 rows=1 loops=1)
--  ->  Sort  (cost=6093.81..6095.99 rows=871 width=22) (actual time=107.267..107.354 rows=1 loops=1)
--        Sort Key: (count(mission_id)) DESC
--        Sort Method: top-N heapsort  Memory: 25kB
--        ->  Finalize GroupAggregate  (cost=5982.11..6089.45 rows=871 width=22) (actual time=94.595..106.721 rows=1967 loops=1)
--              Group Key: air_force, target_city
--              ->  Gather Merge  (cost=5982.11..6075.18 rows=742 width=22) (actual time=94.579..105.271 rows=2394 loops=1)"
--                    Workers Planned: 2
--                    Workers Launched: 2
--                    ->  Partial GroupAggregate  (cost=4982.09..4989.51 rows=371 width=22) (actual time=34.042..36.816 rows=798 loops=3)
--                          Group Key: air_force, target_city
--                          ->  Sort  (cost=4982.09..4983.02 rows=371 width=18) (actual time=34.022..34.667 rows=7738 loops=3)
--                                Sort Key: air_force, target_city
--                                Sort Method: quicksort  Memory: 1485kB
--                                Worker 0:  Sort Method: quicksort  Memory: 201kB
--                                Worker 1:  Sort Method: quicksort  Memory: 53kB
--                                ->  Parallel Seq Scan on mission  (cost=0.00..4966.26 rows=371 width=18) (actual time=0.033..16.212 rows=7738 loops=3)
--                                      Filter: (EXTRACT(year FROM mission_date) = '1943'::numeric)
--                                      Rows Removed by Filter: 51689

"משך הזמן שלקח להרצה"
Planning Time: 0.811 ms
Execution Time: 107.984 ms


"הוספת אינקסים על העמודות הרלוונטיות"
CREATE INDEX idx_mission_date_year ON mission(EXTRACT(YEAR FROM mission_date));
CREATE INDEX idx_air_force ON mission(air_force);
CREATE INDEX idx_target_city ON mission(target_city);


"ניתוח הביצוע לאחר ההרצה"
--Limit  (cost=2156.75..2156.75 rows=1 width=22) (actual time=20.726..20.727 rows=1 loops=1)
--  ->  Sort  (cost=2156.75..2158.93 rows=871 width=22) (actual time=20.724..20.725 rows=1 loops=1)
--        Sort Key: (count(mission_id)) DESC
--        Sort Method: top-N heapsort  Memory: 25kB
--        ->  HashAggregate  (cost=2143.69..2152.40 rows=871 width=22) (actual time=20.206..20.461 rows=1967 loops=1)
--              Group Key: air_force, target_city
--              Batches: 1  Memory Usage: 369kB
--              ->  Bitmap Heap Scan on mission  (cost=19.33..2137.00 rows=891 width=18) (actual time=7.290..10.329 rows=23214 loops=1)
--                    Recheck Cond: (EXTRACT(year FROM mission_date) = '1943'::numeric)
--                    Heap Blocks: exact=949
--                    ->  Bitmap Index Scan on idx_mission_date_year  (cost=0.00..19.10 rows=891 width=0) (actual time=7.115..7.116 rows=23214 loops=1)
--                          Index Cond: (EXTRACT(year FROM mission_date) = '1943'::numeric)
--

"זמן ביצוע לאחר הוספת האינקסים"
Planning Time: 0.841 ms
Execution Time: 20.873 ms






"שאילתא ב"

explain analyze select
    bomb_damage_assessment, count(target_country)
from
    mission
where
    bomb_damage_assessment is not null
    and airborne_aircraft > 5
group by
    target_country, bomb_damage_assessment
order by
    count(bomb_damage_assessment) desc limit 1


 "ניתוח נתונים"
--Limit  (cost=5783.82..5783.82 rows=1 width=58) (actual time=51.402..59.136 rows=1 loops=1)
--  ->  Sort  (cost=5783.82..5783.87 rows=23 width=58) (actual time=51.395..59.125 rows=1 loops=1)
--        Sort Key: (count(bomb_damage_assessment)) DESC
--        Sort Method: top-N heapsort  Memory: 25kB
--        ->  Finalize GroupAggregate  (cost=5780.74..5783.70 rows=23 width=58) (actual time=51.323..59.110 rows=21 loops=1)
--              Group Key: target_country, bomb_damage_assessment
--              ->  Gather Merge  (cost=5780.74..5783.27 rows=20 width=58) (actual time=51.258..59.047 rows=21 loops=1)
--                    Workers Planned: 2
--                    Workers Launched: 2
--                    ->  Partial GroupAggregate  (cost=4780.71..4780.94 rows=10 width=58) (actual time=13.942..13.961 rows=7 loops=3)
--                          Group Key: target_country, bomb_damage_assessment
--                          ->  Sort  (cost=4780.71..4780.74 rows=10 width=42) (actual time=13.938..13.942 rows=11 loops=3)
--                                Sort Key: target_country, bomb_damage_assessment
--                                Sort Method: quicksort  Memory: 26kB
--                                Worker 0:  Sort Method: quicksort  Memory: 25kB
--                                Worker 1:  Sort Method: quicksort  Memory: 25kB
--                                ->  Parallel Seq Scan on mission  (cost=0.00..4780.55 rows=10 width=42) (actual time=9.250..13.841 rows=11 loops=3)
--                                      Filter: ((bomb_damage_assessment IS NOT NULL) AND (airborne_aircraft > '5'::numeric))
--                                      Rows Removed by Filter: 59416
--

"זמן ביצוע"
Planning Time: 0.322 ms
Execution Time: 59.319 ms


"הוספת אינקסים לעמודה הרלוונטים"
CREATE INDEX idx_bomb_damage_assessment ON mission(bomb_damage_assessment);


"ניתוח נתונים לאחר הוספת האינדקסים"
--Limit  (cost=282.33..282.34 rows=1 width=58) (actual time=0.290..0.291 rows=1 loops=1)
--  ->  Sort  (cost=282.33..282.39 rows=23 width=58) (actual time=0.288..0.289 rows=1 loops=1)
--        Sort Key: (count(bomb_damage_assessment)) DESC
--        Sort Method: top-N heapsort  Memory: 25kB
--        ->  GroupAggregate  (cost=281.70..282.22 rows=23 width=58) (actual time=0.259..0.273 rows=21 loops=1)
--              Group Key: target_country, bomb_damage_assessment
--              ->  Sort  (cost=281.70..281.76 rows=23 width=42) (actual time=0.248..0.251 rows=32 loops=1)
--                    Sort Key: target_country, bomb_damage_assessment
--                    Sort Method: quicksort  Memory: 26kB
--                    ->  Bitmap Heap Scan on mission  (cost=4.88..281.18 rows=23 width=42) (actual time=0.078..0.174 rows=32 loops=1)
--                          Recheck Cond: (bomb_damage_assessment IS NOT NULL)
--                          Filter: (airborne_aircraft > '5'::numeric)
--                          Rows Removed by Filter: 72
--                          Heap Blocks: exact=53
--                          ->  Bitmap Index Scan on idx_bomb_damage_assessment  (cost=0.00..4.87 rows=77 width=0) (actual time=0.048..0.048 rows=104 loops=1)
--                                Index Cond: (bomb_damage_assessment IS NOT NULL)
--

"זמן ביצוע לאחר הוספת האינדקס"
Planning Time: 0.619 ms
Execution Time: 0.398 ms