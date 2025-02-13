-- 1
use world;

-- 2
delimiter //
create procedure get_country_use_langugage
(
	in language char(30)
)
begin
	select cl.CountryCode, cl.Language, cl.Percentage
    from countryLanguage cl
    where cl.Language = language and cl.Percentage > 0.5;
end //
delimiter //
-- 3
call get_country_use_langugage('English');

-- 4 
drop procedure get_country_use_langugage;