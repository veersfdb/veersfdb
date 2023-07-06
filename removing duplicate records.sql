ID, MODEL, BRAND, COLOR, MAKE
1, Model S, Tesla, Blue, 2018
2, EQS, Mercedes-Benz, Black, 2022
3, iX, BMW, Red, 2022
4, Ioniq 5, Hyundai, White, 2021
5, Model S, Tesla, Silver, 2018
6, Ioniq 5, Hyundai, Green, 2021

select * from cars order by model, brand;
select model, brand, max(id) from cars group by model,brand having count(*) > 1;

Duplicate records:
--Delete using Unique Identifier
Delete from cars 
where id in (
			select max(id) from cars group by model,brand having count(*) > 1);

--using SELF JOIN
select c2.*
from cars c1
join cars c2 on c1.model = c2.model and c1.brand = c2.brand
where c1.id < c2.id;

Delete from cars 
where id in (
			select c2.id
			from cars c1
			join cars c2 on c1.model = c2.model and c1.brand = c2.brand
			where c1.id < c2.id);

--using WINDOW FUNCTION
DELETE FROM cars
WHERE id in (
			SELECT id 
			FROM (
				select *
				, ROW_NUMBER() over (PARTITION BY model, brand) as rn
				from cars) x
			where x.rn > 1);
			
--Using MIN function (this delete even multiple duplicate records)
delete from cars
where id not in (
				select min(id)
				from cars 
				group by model,brand);

--Using backup table 
