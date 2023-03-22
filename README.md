# Covid-19 Data Analysis Using SQL
This is a SQL project that analyzes the COVID-19 data provided by Our World in Data. The data contains information on cases, deaths, and vaccinations for various countries around the world.

## Data Analysis

In this project, the data analysis is conducted using SQL, which stands for Structured Query Language. SQL is a programming language that is commonly used for managing and manipulating relational databases.

The Covid_19_PortfolioProject database contains two tables: CovidDeaths and CovidVacinations. These tables are related to each other through a common field (i.e., location and date). CovidDeaths table contains information on the total number of cases and deaths due to COVID-19 by location and date. On the other hand, CovidVacinations table contains information on the total number of people who have been vaccinated by location and date.

By analyzing these tables using SQL, we can extract meaningful insights from the data. For example, we can calculate the total number of COVID-19 cases and deaths in a particular location or for a particular date range. We can also calculate the vaccination rate for a particular location or date range.

Overall, the data analysis in this project involves using SQL queries to extract, manipulate, and analyze the data stored in the Covid_19_PortfolioProject database. The results of these analyses can provide valuable insights into the impact of COVID-19 and the effectiveness of vaccination efforts.

The following SQL queries were used to analyze the data:

1. "SELECT * FROM Covid_19_PortfolioProject..CovidDeaths ORDER BY location,date"
This query returns all columns from the CovidDeaths table, sorted by location and date.

2. "SELECT location, date, total_cases, new_cases, total_deaths, population FROM Covid_19_PortfolioProject..CovidDeaths ORDER BY location,date"
This query returns the location, date, total cases, new cases, total deaths, and population from the CovidDeaths table, sorted by location and date.

3. "SELECT location, date, total_cases, total_deaths, (CAST(total_deaths AS float) / CAST(total_cases AS float))*100 as death_rate FROM Covid_19_PortfolioProject..CovidDeaths ORDER BY location,date"
This query returns the location, date, total cases, total deaths, and death rate (calculated as the percentage of total cases that resulted in death) from the CovidDeaths table, sorted by location and date.

4. "SELECT location, date, total_cases, total_deaths, (CAST(total_deaths AS float) / CAST(total_cases AS float))*100 as death_rate FROM Covid_19_PortfolioProject..CovidDeaths WHERE location = 'Pakistan' ORDER BY location,date"
This query returns the location, date, total cases, total deaths, and death rate for Pakistan from the CovidDeaths table, sorted by location and date.

5. "SELECT location, date, total_cases, population, (CAST(total_cases AS int) / population)*100 as PercentPopulationInfected FROM Covid_19_PortfolioProject..CovidDeaths ORDER BY location,date"
This query returns the location, date, total cases, population, and percentage of the population infected from the CovidDeaths table, sorted by location and date.

6. "SELECT location, date, total_cases, population, (CAST(total_cases AS int) / population)*100 as PercentPopulationInfected FROM Covid_19_PortfolioProject..CovidDeaths WHERE location = 'Pakistan' ORDER BY location,date"
This query returns the location, date, total cases, population, and percentage of the population infected for Pakistan from the CovidDeaths table, sorted by location and date.

7. "SELECT location, MAX(total_cases) as highest_infaction_count, population, (MAX(CAST(total_cases AS int)) / population)*100 as PercentPopulationInfected FROM Covid_19_PortfolioProject..CovidDeaths GROUP BY location, population ORDER BY PercentPopulationInfected DESC"
This query returns the location, population, and highest infection count (total cases) and percentage of the population infected for each location from the CovidDeaths table, sorted by percentage of the population infected in descending order.

8. "SELECT location, population, MAX(total_cases) as highest_infaction_count, (MAX(CAST(total_cases AS int)) / population)*100 as PercentPopulationInfected FROM Covid_19_PortfolioProject..CovidDeaths WHERE location = 'Pakistan' GROUP BY location, population"
This query returns the location, population, and highest infection count (total cases) and percentage of the population infected for Pakistan from the CovidDeaths table.
