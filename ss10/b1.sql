-- 1
use world;

-- 2
DELIMITER //
create procedure get_name_country_population(country_code char(3))
begin
	select c.id, c.name, c.population from city c
    where c.CounTryCode = country_code;
end //
DELIMITER //

-- 3
call get_name_country_population('NLD');

-- 4
drop procedure get_name_country_population;