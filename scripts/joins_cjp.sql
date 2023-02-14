-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT film_title, release_year, worldwide_gross
FROM specs 
INNER JOIN revenue  
USING (movie_id)
ORDER BY worldwide_gross ASC;
--Semi-Tough in 1977 worldwide gross amt 37,187,139.00

-- 2. What year has the highest average imdb rating?
SELECT release_year, ROUND(AVG(imdb_rating),2) AS avg_imbdrating
FROM specs
INNER JOIN rating
USING (movie_id)
GROUP BY release_year
ORDER BY avg_imbdrating DESC;
--1991 highest avg rating 7.45

-- 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT film_title, mpaa_rating, worldwide_gross, company_name
FROM specs
INNER JOIN revenue
USING (movie_id)
INNER JOIN distributors
ON specs.domestic_distributor_id = distributors.distributor_id
WHERE mpaa_rating ='G'
ORDER BY worldwide_gross DESC;
--Toy Story 4, Walt Disney
 
-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT company_name, COUNT(film_title) AS film_title
FROM distributors
FULL JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id 
GROUP BY company_name
ORDER BY film_title DESC;
--There are 11 movies with NULL as the Distributor ID

-- 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT company_name, ROUND(AVG(film_budget),2) AS avg_film_budget
FROM specs
INNER JOIN distributors
ON specs.domestic_distributor_id = distributors.distributor_id
INNER JOIN revenue
USING (movie_id)
GROUP BY company_name
ORDER BY avg_film_budget DESC
LIMIT 5; 
--1. Walt Disney 148,735,526.32
--2. Sony Pictures 139,129,032.26
--3. Lionsgate 122,600,000.00
--4. Dreamworks 121,352,941.18
--5. Warner Bros. 103,430,985.92

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT headquarters, imdb_rating, film_title, COUNT(movie_id) AS film_count
FROM specs
INNER JOIN distributors
ON specs.domestic_distributor_id = distributors.distributor_id
INNER JOIN rating
USING (movie_id)
WHERE headquarters NOT LIKE '%CA%'
GROUP BY headquarters, imdb_rating,film_title
ORDER BY imdb_rating DESC;
--2 movies distriubuted by companies outside of CA. Dirty Dancing has higher rating.


-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT AVG(imdb_rating) AS avg_rating
FROM rating
 	SELECT length_in_min, film_title
	FROM specs
	WHERE specs.movie_id = rating.movie_id
	GROUP BY lenth_in_min
	
--this does not work becuase I need to give subqueries more attention. I am re-doing the last datacamp assignment. 
