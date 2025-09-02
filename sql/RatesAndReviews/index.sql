-- Get the average notes from the reviews 
SELECT
title AS course_title, ROUND(AVG(rating), 2) AS avg_rating
FROM
reviews
LEFT JOIN
courses
ON
courses.id=reviews.course_id
WHERE 1
GROUP BY course_title
ORDER BY course_title ASC


-- Average rate per user
SELECT 
name, AVG(rating) as average_rating
FROM
reviews
LEFT JOIN
users
ON
users.id=reviews.user_id
WHERE 1
GROUP BY name


-- Best rated course
SELECT
title, AVG(rating) as rating
FROM
courses
LEFT JOIN
reviews
ON
reviews.course_id=courses.id
WHERE
1
GROUP BY title
ORDER BY rating DESC
LIMIT 3


-- Rating count from courses
SELECT
title, COUNT(rating) as rating_count
FROM
courses
LEFT JOIN
reviews
ON
reviews.course_id=courses.id
WHERE
1
GROUP BY title
ORDER BY rating_count DESC


-- Get the critical users
SELECT
name as critical_user
FROM
courses
LEFT JOIN
reviews
ON
reviews.course_id=courses.id
LEFT JOIN
users
ON 
users.id=user_id
WHERE rating<=2

-- Get the correlation between the course price and the course rating
WITH avg_total_review_rate AS (
	SELECT AVG(rating) AS rating, course_id FROM reviews GROUP BY id
)
SELECT 
title, rating, price
FROM
courses
LEFT JOIN 
avg_total_review_rate
ON
courses.id=avg_total_review_rate.course_id
ORDER BY price DESC

-- Get the correlation between the course rate and the time to complete the course
WITH avg_rate_count AS (
	SELECT id, course_id, AVG(rating) as rating FROM reviews GROUP BY id
)

SELECT 
title, rating, DATEDIFF(completed_at, enrolled_at) as days
FROM 
courses
LEFT JOIN
enrollments
ON
courses.id=enrollments.id
LEFT JOIN 
avg_rate_count
ON
enrollments.id=avg_rate_count.id
ORDER BY rating DESC;


