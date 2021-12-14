-- Part 1: Market Segmentation
--1. Differences in ratings by gender in various categories of movies
SELECT genre, round(AVG(females_allages_avg_vote),2) AS females_avg_votes, round(AVG(males_allages_avg_vote),2) AS males_avg_votes
FROM vote_female vf
LEFT JOIN vote_male vm ON vf.imdb_title_id = vm.imdb_title_id
LEFT JOIN genre g ON vf.imdb_title_id = g.imdb_title_id
GROUP BY genre;

--2. Differences in ratings by age for various categories of movies
SELECT genre, round(AVG(allgenders_0age_avg_vote),2) AS Below_18, round(AVG(allgenders_18age_avg_vote),2) AS From_18_to_30, 
 round(AVG(allgenders_30age_avg_vote),2) From_30_to_45, round(AVG(allgenders_45age_avg_vote),2) Over_45
FROM genre g
LEFT JOIN vote_all_gender v on g.imdb_title_id = v.imdb_title_id
GROUP BY genre;

--3. Percentage of movies by category in different countries
select t1.country, genre, movie_count, country_movie_count, movie_count*100/country_movie_count as genre_percentage
from 
(select country, genre, count(g.imdb_title_id) as movie_count
from country c
join genre g on c.imdb_title_id = g.imdb_title_id
group by country, genre) t1
join
(select country, count(imdb_title_id) as country_movie_count
from country
group by country) t2
on t1.country = t2.country
order by 1;

-- Part 2: Popularity Trends
--4. Percentage of movies by genre in different generations
select t1.year, genre, movie_count, yearly_movie_count, movie_count*100/yearly_movie_count as genre_percentage
from 
(select year, genre, count(g.imdb_title_id) as movie_count
from imdb_movie i
join genre g on i.imdb_title_id = g.imdb_title_id
group by year, genre) t1
join
(select year, count(imdb_title_id) as yearly_movie_count
from imdb_movie
group by year) t2
on t1.year = t2.year
where yearly_movie_count > 100
order by 1 desc;

--5. What are the movies that receive the highest number of reviews/critics genre
--& Which type of topics can create traffic talking points. This question can also be extended to actors
select g.genre, sum(reviews_from_users) as total_user_reviews, round(sum(reviews_from_users)/count(r.imdb_title_id),2) as avg_user_reviews,
sum(reviews_from_critics) as total_critics_reviews, round(sum(reviews_from_critics)/count(r.imdb_title_id),2) as avg_critics_reviews
from reviews r
join genre g on r.imdb_title_id = g.imdb_title_id
group by g.genre
order by 3 desc, 5 desc;

--6. How movies distribute among each genre?
-- good movies(weighted_average_vote>=7), normal movies(4<=weighted_average_vote<7) and bad movies(weighted_average_vote<7) distribute
select g.genre,
(case when weighted_average_vote >= 7 then 'good movie' when weighted_average_vote>=4 then 'normal movie' else 'bad movies' end) as movie_type,
count(v.imdb_title_id) as movie_count, genre_movie_count, (count(v.imdb_title_id)*100/genre_movie_count) as movie_type_percentage
from vote_overall v
join genre g on g.imdb_title_id = v.imdb_title_id
join (
select genre, count(imdb_title_id) as genre_movie_count
from genre
group by genre
) t1 on g.genre = t1.genre
group by g.genre, movie_type, genre_movie_count
order by 1,2;

--7. A ranking of the number of reviews for different regions, movie titles? 
--Check which movie titles are the most popular in different regions, so Netflix can target the selection according to the region.
select genre, country, round(avg(weighted_average_vote),2) as avg_rating, 
RANK() OVER (PARTITION BY country order by avg(weighted_average_vote) DESC) AS genre_rank
from country c
join genre g on c.imdb_title_id = g.imdb_title_id
join vote_overall v on g.imdb_title_id = v.imdb_title_id
group by genre,country
having count(g.imdb_title_id)>10
order by 4;

-- Part 3: Celebrity Factor
--8. The average ratings of actors/actresses who received more than 5,000 reviews
SELECT C.name AS Director_name, 
  round(AVG(V.weighted_average_vote),2) AS Avg_Vote, 
  sum(R.reviews_from_users) AS Sum_of_Reviews
FROM Cast_information C 
INNER JOIN Title_Principals T ON T.imdb_name_id = C.imdb_name_id
INNER JOIN Vote_Overall V ON T.imdb_title_id = V.imdb_title_id
INNER JOIN Reviews R ON V.imdb_title_id = R.imdb_title_id
WHERE T.category = 'director'
GROUP BY C.name
HAVING SUM(R.reviews_from_users)>5000
ORDER BY 3 DESC;

--9. The average ratings of directors who received more than 5,000 reviews.
SELECT C.name As Actor_Actress_Name, 
  round(avg(V.weighted_average_vote),2) AS Avg_Vote, 
  sum(R.reviews_from_users) AS Sum_of_Reviews
FROM Cast_information C 
INNER JOIN Title_Principals T ON T.imdb_name_id = C.imdb_name_id
INNER JOIN Vote_Overall V ON T.imdb_title_id = V.imdb_title_id
INNER JOIN Reviews R ON V.imdb_title_id = R.imdb_title_id
WHERE T.category IN ('actor','actress')
GROUP BY C.name

--10. The effect of whether Voters is a US region on the ratings of different movies
select genre, round(avg(us_voters_rating),2) as us_avg_rating,
round(avg(non_us_voters_rating),2) as non_us_avg_rating,
round(avg(us_voters_rating),2)-round(avg(non_us_voters_rating),2) as difference,
count(g.imdb_title_id) as movie_count
from vote_region v
join genre g on v.imdb_title_id = g.imdb_title_id
group by genre
having count(g.imdb_title_id)>10
order by 4 desc;


