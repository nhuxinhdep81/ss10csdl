-- 1
use world;

-- 2
delimiter //
create procedure GetEnglishSpeakingCountriesWithCities
(
	in language_in char(30)
)
begin
	select ct.Name as CountryName, sum(c.population) as TotalCityPopulation 
    from country ct 
    join city c on ct.Code = c.countryCode
    join countrylanguage ctl on ct.Code = ctl.countryCode
    where ctl.Language = language_in 
    and ctl.IsOfficial = 'T'
    group by c.countryCode , ct.Name
    having TotalCityPopulation > 5000000
    order by TotalCityPopulation desc
    limit 10;
end //
delimiter //

-- 3
call GetEnglishSpeakingCountriesWithCities('English');

-- 4
drop procedure GetEnglishSpeakingCountriesWithCities;