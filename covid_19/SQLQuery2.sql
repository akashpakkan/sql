select *
from CovidPortfolio.dbo.CovidDeaths$
--where continent is null
order by 2

--select *
--from CovidPortfolio.dbo.CovidVaccination$


select location, date, total_cases, new_cases, total_deaths, population
from CovidPortfolio.dbo.CovidDeaths$
order by 1,2



/*Total cases vs total deaths*/

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPrcnt
from CovidPortfolio.dbo.CovidDeaths$
where location like '%India%'
order by 1,2



/*Total cases Vs Population*/

select location, date, total_cases, population, (total_cases/population)*100 as '%Infected'
from CovidPortfolio.dbo.CovidDeaths$
where location like '%India%'
order by 1,2 desc



select location, date, new_cases, total_cases, new_deaths, total_deaths, population
from CovidPortfolio.dbo.CovidDeaths$
where location like '%India%'
order by 1,2

Select location, date, max(new_cases)
from CovidPortfolio.dbo.CovidDeaths$
where location like '%India%'
group by location, date
order by 3 desc


/*Max percnt of population infected */

select location, population, max(total_cases) as HighestCase, max((total_cases/population))*100 as '%Infected'
from CovidPortfolio.dbo.CovidDeaths$
--where location like '%India%'
Group by location, population
order by 4 desc


/* Countries With highest death count */

select location, max(cast(total_deaths as int)) as HighestDeath
from CovidPortfolio.dbo.CovidDeaths$
--where location like '%India%'
where continent is null
Group by location
order by 2 desc


/* Global Status: Global Numebers, Total cases, Total deaths, Max %infect, Max %Death */

select  location, population, max(cast(total_cases as int)) as HighestCases, max(cast(total_deaths as int)) as HighestDeath
from CovidPortfolio.dbo.CovidDeaths$
--where location like '%India%'
where continent is null
group by location,population


select continent, max(cast(total_cases as int)), max(cast(total_deaths as int))
from CovidPortfolio.dbo.CovidDeaths$
where continent is not null
group by continent
order by 1,2

Select max(population) as total_population, max(cast(total_cases as int)) as total_cases, max(cast(total_deaths as int)) as total_deaths,  max(cast(total_cases as int))/max(population)*100 as DeathPercentage
from CovidPortfolio.dbo.CovidDeaths$
where continent is null

Select *
From CovidPortfolio.dbo.CovidDeaths$ cd
join CovidPortfolio.dbo.CovidVaccination$ cv
on cd.location=cv.location
where cd.continent is not null


/*Population Vs Vaccinated*/

Select cd.location, cd.date, cd.population, cv.new_vaccinations
From CovidPortfolio.dbo.CovidDeaths$ cd
join CovidPortfolio.dbo.CovidVaccination$ cv
on cd.location=cv.location
and cd.date=cv.date
where cd.continent is not null
order by 1