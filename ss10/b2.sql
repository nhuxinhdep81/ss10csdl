-- 1 
use world;

-- 2
DELIMITER //
create procedure CalculationPopulation
(
	in p_country char(3),
    out country_code char(3),
    out total_population int
)

begin
	select sum(population) into total_population
    from city c
    where c.countryCode = p_country
    group by c.countryCode;
    
    set country_code = p_country;
end //

DELIMITER //

-- 3
call CalculationPopulation('NLD',@country_code, @total_population);
select @country_code as countryCode, @total_population as total_population;

-- 4 
drop procedure CalculationPopulation;
