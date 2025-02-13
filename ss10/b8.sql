-- 1
use world;

-- 2

delimiter //
create procedure GetCountriesByCityNames
(
	in first_word char(1)
)
begin 
	select ct.Name as CountryName, ctl.Language as OfficalLanguage, sum(c.Population) as TotalPopulation
    from country ct
    join city c on ct.Code = c.countryCode
    join countryLanguage ctl on ct.Code = ctl.countryCode
    where ctl.IsOfficial = 'T' 
    and c.Name like concat(first_word, '%')
	group by c.CountryCode, ct.Name, ctl.Language
    having TotalPopulation > 2000000
    order by ct.Name asc;
end //
delimiter //

-- 3
call GetCountriesByCityNames('A');

-- 4 
drop procedure GetCountriesByCityNames;