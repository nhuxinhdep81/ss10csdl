-- 1
use world;

-- 2
create view CountryLanguageView
as
	select ct.Code as CountryCode, ct.Name as CountryName, ctl.Language as Language, ctl.IsOfficial as IsOfficial
    from country ct 
    join countrylanguage ctl on ct.Code = ctl.CountryCode
    where ctl.IsOfficial = 'T';

-- 3
select * from CountryLanguageView;

-- 4
delimiter //
create procedure GetLargeCitiesWithEnglish
(
	in language_in char(30)
)
begin 
	select c.Name as CityName, ct.Name as CountryName, c.population as Population
    from country ct 
    join city c on ct.Code = c.CountryCode
    join countryLanguage ctl on ct.Code = ctl.CountryCode
    where 
    c.population > 1000000
    and ctl.Language = language_in
    and ctl.IsOfficial = 'T'
    order by c.population desc
    limit 20;
end //
delimiter //

-- 5
call GetLargeCitiesWithEnglish('English');

-- 6 
drop procedure GetLargeCitiesWithEnglish;