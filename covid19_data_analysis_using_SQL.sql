-- Checking Deaths Table

SELECT *
FROM Covid_19_PortfolioProject..CovidDeaths
ORDER BY location,date


SELECT 
	location,
	date,
	total_cases,
	new_cases,
	total_deaths,
	population
FROM Covid_19_PortfolioProject..CovidDeaths
ORDER BY location,date

-- Total Cases vs Total Deaths

SELECT 
	location,
	date,
	total_cases,
	total_deaths,
	(CAST(total_deaths AS float) / CAST(total_cases AS float))*100 as death_rate
FROM Covid_19_PortfolioProject..CovidDeaths
ORDER BY location,date

-- Death Rate or Likelihood of dying in Pakistan
SELECT 
	location,
	date,
	total_cases,
	total_deaths,
	(CAST(total_deaths AS float) / CAST(total_cases AS float))*100 as death_rate
FROM Covid_19_PortfolioProject..CovidDeaths
WHERE location = 'Pakistan'
ORDER BY location,date


-- Total Cases vs Population
-- Show what percentage of population got Covid

SELECT 
	location,
	date,
	total_cases,
	population,
	(CAST(total_cases AS int) / population)*100 as PercentPopulationInfected
FROM Covid_19_PortfolioProject..CovidDeaths
ORDER BY location,date

-- Show what percentage of population got Covid in Pakisatn

SELECT 
	location,
	date,
	total_cases,
	population,
	(CAST(total_cases AS int) / population)*100 as PercentPopulationInfected
FROM Covid_19_PortfolioProject..CovidDeaths
WHERE location = 'Pakistan'
ORDER BY location,date


-- Which Country has highest infaction rate compared to population

SELECT 
	location,
	MAX(total_cases) as highest_infaction_count,
	population,
	(MAX(CAST(total_cases AS int)) / population)*100 as PercentPopulationInfected
FROM Covid_19_PortfolioProject..CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

-- What is the highest infaction rate in Pakisatn

SELECT 
	location,
	population,
	MAX(total_cases) as highest_infaction_count,
	(MAX(CAST(total_cases AS int)) / population)*100 as PercentPopulationInfected
FROM Covid_19_PortfolioProject..CovidDeaths
WHERE location = 'Pakistan'
GROUP BY location, population


-- Which Country Has the Highest Death Count per Population

SELECT 
	location, 
	MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM Covid_19_PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


-- What is the total death count in Pakistan

SELECT 
	location, 
	MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM Covid_19_PortfolioProject..CovidDeaths
WHERE location = 'Pakistan'
GROUP BY location
ORDER BY TotalDeathCount DESC

-- What Percent of people died with respect to population

WITH tab1 AS 
	(SELECT 
		location, 
		MAX(CAST(total_deaths AS int)) AS TotalDeathCount,
		population
	FROM Covid_19_PortfolioProject..CovidDeaths
	WHERE location = 'Pakistan'
	GROUP BY location,population)
SELECT *,
	(TotalDeathCount/population)*100 AS PercentPeopleDied
FROM tab1

-- Contintents with the highest death count per population

SELECT 
	continent,
	MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM Covid_19_PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

--SELECT 
--	location,
--	MAX(CAST(total_deaths AS int)) AS TotalDeathCount
--FROM Covid_19_PortfolioProject..CovidDeaths
--WHERE continent IS NULL
--GROUP BY location
--ORDER BY TotalDeathCount DESC

-- What is the average death rate across different continents

SELECT
	continent,
	AVG(CAST(total_deaths AS float) / CAST(total_cases AS float))*100 AS average_death_rate
FROM Covid_19_PortfolioProject..CovidDeaths
GROUP BY continent
ORDER BY average_death_rate DESC


-- What are the Total number of cases and deaths In all the countries till now

Select 
	SUM(new_cases) AS total_cases,
	SUM(new_deaths) AS total_deaths,
	(SUM(new_deaths) / SUM(new_cases))*100 AS DeathPercentage
FROM Covid_19_PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL


-- Checking Vacination Table

SELECT *
FROM Covid_19_PortfolioProject..CovidVacinations
ORDER BY location,date

-- Joining Deaths and Vacination Tables

SELECT *
FROM Covid_19_PortfolioProject..CovidDeaths cd
JOIN Covid_19_PortfolioProject..CovidVacinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date

-- How many People Vaccinated Per Day

SELECT 
	cd.continent,
	cd.location,
	cd.date,
	cd.population,
	cv.new_vaccinations,
	SUM(CAST(cv.new_vaccinations AS float)) OVER (PARTITION BY cd.location ORDER BY cd.location,cd.date) AS PeopleVaccinatedPerDay
FROM Covid_19_PortfolioProject..CovidDeaths cd
JOIN Covid_19_PortfolioProject..CovidVacinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
ORDER BY location,date

-- Total Population vs Vacination

WITH VaccinatedPerDay AS
	(SELECT 
		cd.continent,
		cd.location,
		cd.date,
		cd.population,
		cv.new_vaccinations,
		SUM(CAST(cv.new_vaccinations AS float)) OVER (PARTITION BY cd.location ORDER BY cd.location,cd.date) AS PeopleVaccinatedPerDay
	FROM Covid_19_PortfolioProject..CovidDeaths cd
	JOIN Covid_19_PortfolioProject..CovidVacinations cv
		ON cd.location = cv.location
		AND cd.date = cv.date
	WHERE cd.continent IS NOT NULL)
SELECT *,
	(PeopleVaccinatedPerDay / population) * 100 AS PercentPeopleVacinated
FROM VaccinatedPerDay

-- How many People Vaccinated Per Day and their Percentage with respect to population

WITH VaccinatedPerDay AS
	(SELECT 
		cd.continent,
		cd.location,
		cd.date,
		cd.population,
		cv.new_vaccinations,
		SUM(CAST(cv.new_vaccinations AS float)) OVER (PARTITION BY cd.location ORDER BY cd.location,cd.date) AS PeopleVaccinatedPerDay
	FROM Covid_19_PortfolioProject..CovidDeaths cd
	JOIN Covid_19_PortfolioProject..CovidVacinations cv
		ON cd.location = cv.location
		AND cd.date = cv.date
	WHERE cd.location = 'Pakistan')
SELECT *,
	(PeopleVaccinatedPerDay / population) * 100 AS PercentPeopleVacinated
FROM VaccinatedPerDay

-- How many percent of people vaccinated so far in Pakistan
WITH VaccinatedPerDay AS
	(SELECT 
		cd.continent,
		cd.location,
		cd.date,
		cd.population,
		cv.new_vaccinations,
		SUM(CAST(cv.new_vaccinations AS float)) OVER (PARTITION BY cd.location ORDER BY cd.location,cd.date) AS PeopleVaccinatedPerDay
	FROM Covid_19_PortfolioProject..CovidDeaths cd
	JOIN Covid_19_PortfolioProject..CovidVacinations cv
		ON cd.location = cv.location
		AND cd.date = cv.date
	WHERE cd.location = 'Pakistan')
SELECT TOP 1 *,
	(PeopleVaccinatedPerDay / population) * 100 AS PercentPeopleVacinated
FROM VaccinatedPerDay
ORDER BY PercentPeopleVacinated DESC
-- SO 56% of total population of Pakistan is vaccinated so far


