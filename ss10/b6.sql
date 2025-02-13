-- 1
use world;

-- 2
delimiter //
create procedure GetCountriesWithLargeCities
(
	in continent_in enum('Asia', 'Europe', 'North America', 'Africa', 'Oceania', 'Antarctica', 'South America')
)
begin
	select ct.Name as CountryName , sum(c.population) as TotalPopulation 
    from country ct
    join city c on ct.code = c.CountryCode
    where continent = continent_in 
    group by c.countryCode, ct.name
    having TotalPopulation > 1000000
    order by TotalPopulation desc;
end //
delimiter //
-- 3
call GetCountriesWithLargeCities('Asia');

-- 4 
drop procedure GetCountriesWithLargeCities;

