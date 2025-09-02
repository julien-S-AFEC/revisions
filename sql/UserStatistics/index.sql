
-- Nombre total d'utilisateurs
SELECT id FROM users WHERE 1 ORDER BY id DESC LIMIT 1;

-- Liste des utilisateurs avec leur nombre d’inscriptions (y compris ceux à 0)
SELECT name, COUNT(course_id) FROM users JOIN enrollments ON users.id = enrollments.user_id  WHERE 1 GROUP BY name;

---Moyenne d'inscription par utilisateurs
 SELECT
 (SELECT COUNT(*) FROM enrollments) / 
(SELECT COUNT(*) FROM users) AS MoyenneDInscritparUtilisateur WHERE 1 ;

--- Liste des utilisateurs avec leur date d'inscription la plus ancienne
SELECT * FROM users ORDER BY users.created_at ASC;

--- Nombre d'inscription par date 
SELECT enrolled_at, COUNT(*) FROM enrollments AS nb_d_inscriptions GROUP BY enrolled_at ORDER BY enrolled_at;

--- Top 3 des utilisateurs ayant complété les plus de cours
SELECT u.id, u.name, COUNT(e.id) AS cours_completes FROM users u JOIN enrollments e ON u.id = e.user_id WHERE e.completed = TRUE GROUP BY u.id, u.name ORDER BY cours_completes DESC LIMIT 3;

--- Liste des utilisateurs n’ayant jamais laissé d’avis
SELECT users.id, users.name, users.email
FROM users 
LEFT JOIN reviews ON users.id = reviews.user_id
WHERE reviews.id IS NULL;

