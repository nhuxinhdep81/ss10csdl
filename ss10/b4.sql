-- 1
use world;

-- 2
delimiter //
create procedure UpdateCityPopulation
(
	inout city_id int,
    in new_population int,
    out updated_population int,
    out name_city char(35)
)
begin
	update city
    set population = new_population
    where ID = city_id;
	
    select ID, population, name 
    into city_id, updated_population ,name_city from city where ID = city_id ;
end //
delimiter //

-- 3
set @city_id = 2;
call UpdateCityPopulation(@city_id,999999, @updated_population, @name_city);
select @city_id as ID, @updated_population as NewPopulation , @name_city as Name;
-- 4
drop procedure UpdateCityPopulation;