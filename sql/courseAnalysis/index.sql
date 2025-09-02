-- Nombre de cours par catégorie
SELECT
  category,
  COUNT(*) AS nb_cours
FROM courses
GROUP BY category
ORDER BY nb_cours DESC, category;

-- Prix moyen par catégorie (arrondi à 2 décimales)
SELECT
  category,
  ROUND(AVG(price), 2) AS prix_moyen
FROM courses
GROUP BY category
ORDER BY prix_moyen DESC, category;

-- Cours le plus cher (gère les ex-aequo)
SELECT id, title, category, price
FROM courses
WHERE price = (SELECT MAX(price) FROM courses)
ORDER BY title;

-- Cours le moins cher (gère les ex-aequo)
SELECT id, title, category, price
FROM courses
WHERE price = (SELECT MIN(price) FROM courses)
ORDER BY title;

-- Nombre d'inscriptions par cours (inclut les cours à 0 inscription)
SELECT
  courses.id,
  courses.title,
  courses.category,
  COALESCE(COUNT(enrollments.id), 0) AS nb_inscriptions
FROM courses 
LEFT JOIN enrollments  ON enrollments.course_id = courses.id
GROUP BY courses.id, courses.title, courses.category
ORDER BY nb_inscriptions DESC, courses.title;

-- Cours sans aucune inscription
SELECT
  courses.id,
  courses.title,
  courses.category,
  courses.price
FROM courses 
LEFT JOIN enrollments ON enrollments.course_id = courses.id
GROUP BY courses.id, courses.title, courses.category, courses.price
HAVING COUNT(enrollments.id) = 0
ORDER BY courses.title;

-- Cours ayant un taux de complétion > 80%
-- On calcule le taux = SUM(completed)/COUNT(enrollments) ; on ignore les cours sans inscription
SELECT
  courses.id,
  courses.title,
  courses.category,
  COUNT(enrollments.id) AS nb_inscriptions,
  ROUND(100 * SUM(CASE WHEN enrollments.completed = TRUE OR enrollments.completed = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(enrollments.id),0), 2) AS taux_completion_pourcent
FROM courses
LEFT JOIN enrollments ON enrollments.course_id = courses.id
GROUP BY courses.id, courses.title, courses.category
HAVING COUNT(enrollments.id) > 0
   AND (SUM(CASE WHEN enrollments.completed = TRUE OR enrollments.completed = 1 THEN 1 ELSE 0 END) / COUNT(enrollments.id)) > 0.8
ORDER BY taux_completion_pourcent DESC, courses.title;

-- Variante utile : afficher tous les cours avec leur taux de complétion (0 pour 0 inscriptions)
SELECT
  courses.id,
  courses.title,
  courses.category,
  COUNT(enrollments.id) AS nb_inscriptions,
  ROUND(100 * COALESCE(SUM(CASE WHEN enrollments.completed = TRUE OR enrollments.completed = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(enrollments.id),0), 0), 2) AS taux_completion_pourcent
FROM courses
LEFT JOIN enrollments ON enrollments.course_id = courses.id
GROUP BY courses.id, courses.title, courses.category
ORDER BY taux_completion_pourcent DESC, nb_inscriptions DESC, courses.title;
