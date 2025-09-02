USE revision;
-- Revenu total généré (somme des prix des cours vendus)
WITH calcul AS (
SELECT COUNT(user_id) as totalUser , price  
FROM enrollments JOIN courses ON enrollments.course_id = courses.id
WHERE 1 GROUP BY course_id )
SELECT sum(totalUser * price) as totalGenerer FROM calcul;

-- Revenu total par cours
SELECT COUNT(user_id) * price as prixTotal, title FROM enrollments JOIN courses ON enrollments.course_id = courses.id WHERE 1 GROUP BY course_id;

-- Revenu total par catégorie
SELECT COUNT(user_id) * price as prixTotal, category FROM enrollments JOIN courses ON enrollments.course_id = courses.id WHERE 1 GROUP BY category;

-- Revenu moyen par utilisateur inscrit
WITH calcul AS (
SELECT COUNT(user_id) as totalUser , price  
FROM enrollments JOIN courses ON enrollments.course_id = courses.id
WHERE 1 GROUP BY course_id )

SELECT sum(totalUser * price)/(SELECT COUNT(*) FROM users) AS moyenne
FROM calcul;