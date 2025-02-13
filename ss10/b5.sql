-- 1
use world;

-- 2
delimiter //
create procedure GetLargeCitiesByCountry
(
	in country_code char(3)
)
begin
	select ID as CityID, Name as CityName, Population
    from city
    where CountryCode = country_code and Population > 1000000;
end //
delimiter //

-- 3
call GetLargeCitiesByCountry('USA');

-- 4
drop procedure GetLargeCitiesByCountry;