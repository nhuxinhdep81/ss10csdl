-- 1
use world;

-- 2
create view OfficialLanguageView
as 
	select ct.code as CountryCode, ct.Name as CountryName, ctl.Language as Language 
    from country ct
    join countryLanguage ctl on ct.Code = ctl.CountryCode
    where ctl.IsOfficial = 'T';
    
-- 3
select * from OfficialLanguageView; 

-- 4
create index idx_name on city(Name);

-- 5
delimiter //
create procedure GetSpecialCountriesAndCities
(
	in language_name char(30)
)
begin
	select ct.Name as CountryName, c.Name as CityName, c.Population as CityPopulation, ct.population as TotalPopulation
    from country ct 
    join city c on ct.Code = c.CountryCode
    join countrylanguage ctl on ct.Code = ctl.CountryCode
    where ctl.Language = language_name
    and c.Name like 'New%'
    and ct.population > 5000000
    order by ct.population desc
    limit 10;

end //
delimiter //

-- 6
call GetSpecialCountriesAndCities('English');













