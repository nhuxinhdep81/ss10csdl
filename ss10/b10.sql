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
    select 
        ct.Name as COuntryName, 
        c.Name as CityName, 
        c.Population as CityPopulation, 
        cp.TotalPopulation
    from 
        (select 
            ct.Code as CountryCode, 
            sum(c.Population) as TotalPopulation
        from country ct
        join city c on ct.Code = c.CountryCode
        group by ct.Code
        having TotalPopulation > 5000000
        ) as cp  
    join city c on cp.CountryCode = c.CountryCode
    join countrylanguage ctl on cp.CountryCode = ctl.CountryCode
    join country ct on cp.CountryCode = ct.Code
    where ctl.Language = language_name
        and c.Name like 'New%'
    order by cp.TotalPopulation desc, CityPopulation desc
    limit 10;
end //
delimiter ;

-- 6
call GetSpecialCountriesAndCities('English');


drop procedure GetSpecialCountriesAndCities;
