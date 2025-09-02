CREATE DATABASE IF NOT EXISTS revision;
USE revision;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150),
    email VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO users (name, email, created_at) VALUES
('Alice Martin', 'alice.martin@example.com', '2025-01-05 09:12:00'),
('Bob Dupont', 'bob.dupont@example.com', '2025-02-12 10:15:00'),
('Claire Durand', 'claire.durand@example.com', '2025-03-18 14:25:00'),
('David Bernard', 'david.bernard@example.com', '2025-04-22 16:40:00'),
('Emma Lefevre', 'emma.lefevre@example.com', '2025-05-10 11:05:00'),
('François Petit', 'francois.petit@example.com', '2025-06-15 12:30:00'),
('Gabrielle Leroy', 'gabrielle.leroy@example.com', '2025-07-01 13:45:00'),
('Hugo Fontaine', 'hugo.fontaine@example.com', '2025-07-19 09:20:00'),
('Isabelle Caron', 'isabelle.caron@example.com', '2025-08-05 15:15:00'),
('Julien Robert', 'julien.robert@example.com', '2025-08-20 10:50:00'),
('Karine Noel', 'karine.noel@example.com', '2025-09-02 14:30:00'),
('Louis Girard', 'louis.girard@example.com', '2025-09-15 09:10:00'),
('Marie Lambert', 'marie.lambert@example.com', '2025-10-01 11:25:00'),
('Nicolas Gauthier', 'nicolas.gauthier@example.com', '2025-10-12 13:05:00'),
('Olivier Marchand', 'olivier.marchand@example.com', '2025-11-05 16:00:00'),
('Pauline Mercier', 'pauline.mercier@example.com', '2025-11-20 08:45:00'),
('Quentin Morel', 'quentin.morel@example.com', '2025-12-01 14:10:00'),
('Romain Blanchard', 'romain.blanchard@example.com', '2025-12-15 12:30:00'),
('Sophie Fabre', 'sophie.fabre@example.com', '2025-12-20 10:00:00'),
('Thomas Riviere', 'thomas.riviere@example.com', '2025-12-25 09:40:00'),
('Ulysse Rey', 'ulysse.rey@example.com', '2025-12-28 11:55:00'),
('Valérie Colin', 'valerie.colin@example.com', '2025-12-30 15:20:00'),
('William Perrot', 'william.perrot@example.com', '2025-12-31 17:10:00'),
('Xavier Chevalier', 'xavier.chevalier@example.com', '2025-12-31 18:45:00'),
('Yasmine Aubry', 'yasmine.aubry@example.com', '2025-12-31 19:30:00'),
('Zoe Moulin', 'zoe.moulin@example.com', '2025-12-31 20:15:00'),
('Antoine Georges', 'antoine.georges@example.com', '2025-12-31 21:00:00'),
('Brigitte Faure', 'brigitte.faure@example.com', '2025-12-31 21:45:00'),
('Cédric Boucher', 'cedric.boucher@example.com', '2025-12-31 22:30:00'),
('Delphine Henry', 'delphine.henry@example.com', '2025-12-31 23:15:00');


CREATE TABLE IF NOT EXISTS courses(
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(150),
category VARCHAR(150),
price DECIMAL(10,2)
);

INSERT INTO courses (title, category, price) VALUES
('Introduction à Python', 'Programmation', 49.99),
('Java pour débutants', 'Programmation', 59.99),
('Développement Web avec HTML & CSS', 'Programmation', 39.99),
('ReactJS avancé', 'Programmation', 79.99),
('UI/UX Design Fundamentals', 'Design', 54.99),
('Photoshop pour débutants', 'Design', 44.99),
('Illustrator avancé', 'Design', 64.99),
('Design Thinking', 'Design', 69.99),
('Finance pour non-financiers', 'Business', 59.99),
('Entrepreneuriat digital', 'Business', 79.99),
('Management de projet Agile', 'Business', 74.99),
('Comptabilité simplifiée', 'Business', 49.99),
('Marketing Digital', 'Marketing', 69.99),
('Publicité sur les réseaux sociaux', 'Marketing', 59.99),
('SEO pour débutants', 'Marketing', 39.99),
('Stratégie de contenu', 'Marketing', 54.99),
('Analyse de données avec Excel', 'Données', 39.99),
('SQL pour analystes', 'Données', 49.99),
('Machine Learning introduction', 'Données', 99.99),
('Data Visualization avec Tableau', 'Données', 79.99)
;

CREATE TABLE IF NOT EXISTS enrollments(
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT,
course_id INT,
enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
completed BOOlEAN,
completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO enrollments (user_id, course_id, enrolled_at, completed, completed_at) VALUES
(1, 1, '2025-01-10 10:00:00', TRUE, '2025-02-10 10:00:00'),
(2, 2, '2025-01-12 11:15:00', FALSE, NULL),
(3, 3, '2025-01-15 09:30:00', TRUE, '2025-02-15 09:30:00'),
(4, 4, '2025-01-18 14:20:00', FALSE, NULL),
(5, 5, '2025-01-20 16:05:00', TRUE, '2025-02-20 16:05:00'),
(6, 6, '2025-01-22 12:10:00', FALSE, NULL),
(7, 7, '2025-01-25 10:40:00', TRUE, '2025-02-25 10:40:00'),
(8, 8, '2025-01-28 13:55:00', TRUE, '2025-02-28 13:55:00'),
(9, 9, '2025-02-01 09:20:00', FALSE, NULL),
(10, 10, '2025-02-03 11:35:00', TRUE, '2025-03-03 11:35:00'),
(11, 11, '2025-02-05 14:50:00', TRUE, '2025-03-05 14:50:00'),
(12, 12, '2025-02-07 10:15:00', FALSE, NULL),
(13, 13, '2025-02-10 09:40:00', TRUE, '2025-03-10 09:40:00'),
(14, 14, '2025-02-12 12:25:00', FALSE, NULL),
(15, 15, '2025-02-15 15:30:00', TRUE, '2025-03-15 15:30:00'),
(16, 16, '2025-02-17 11:45:00', FALSE, NULL),
(17, 17, '2025-02-20 10:10:00', TRUE, '2025-03-20 10:10:00'),
(18, 18, '2025-02-22 13:20:00', TRUE, '2025-03-22 13:20:00'),
(19, 19, '2025-02-25 09:55:00', FALSE, NULL),
(20, 20, '2025-02-27 11:30:00', TRUE, '2025-03-27 11:30:00'),
(21, 1, '2025-03-01 14:45:00', FALSE, NULL),
(22, 2, '2025-03-03 10:20:00', TRUE, '2025-04-03 10:20:00'),
(23, 3, '2025-03-05 13:35:00', TRUE, '2025-04-05 13:35:00'),
(24, 4, '2025-03-07 09:50:00', FALSE, NULL),
(25, 5, '2025-03-10 12:10:00', TRUE, '2025-04-10 12:10:00'),
(26, 6, '2025-03-12 14:25:00', FALSE, NULL),
(27, 7, '2025-03-15 10:40:00', TRUE, '2025-04-15 10:40:00'),
(28, 8, '2025-03-17 11:55:00', TRUE, '2025-04-17 11:55:00'),
(29, 9, '2025-03-20 09:15:00', FALSE, NULL),
(30, 10, '2025-03-22 12:30:00', TRUE, '2025-04-22 12:30:00'),
(1, 11, '2025-03-25 14:45:00', TRUE, '2025-04-25 14:45:00'),
(2, 12, '2025-03-27 10:00:00', FALSE, NULL),
(3, 13, '2025-03-30 11:20:00', TRUE, '2025-04-30 11:20:00'),
(4, 14, '2025-04-01 13:35:00', FALSE, NULL),
(5, 15, '2025-04-03 09:50:00', TRUE, '2025-05-03 09:50:00'),
(6, 16, '2025-04-05 12:10:00', FALSE, NULL),
(7, 17, '2025-04-07 14:25:00', TRUE, '2025-05-07 14:25:00'),
(8, 18, '2025-04-10 10:40:00', TRUE, '2025-05-10 10:40:00'),
(9, 19, '2025-04-12 11:55:00', FALSE, NULL),
(10, 20, '2025-04-15 09:15:00', TRUE, '2025-05-15 09:15:00'),
(11, 1, '2025-04-17 12:30:00', TRUE, '2025-05-17 12:30:00'),
(12, 2, '2025-04-20 14:45:00', FALSE, NULL),
(13, 3, '2025-04-22 10:00:00', TRUE, '2025-05-22 10:00:00'),
(14, 4, '2025-04-25 11:20:00', FALSE, NULL),
(15, 5, '2025-04-27 13:35:00', TRUE, '2025-05-27 13:35:00'),
(16, 6, '2025-04-30 09:50:00', FALSE, NULL),
(17, 7, '2025-05-02 12:10:00', TRUE, '2025-06-02 12:10:00'),
(18, 8, '2025-05-05 14:25:00', TRUE, '2025-06-05 14:25:00'),
(19, 9, '2025-05-07 10:40:00', FALSE, NULL),
(20, 10, '2025-05-10 11:55:00', TRUE, '2025-06-10 11:55:00')
;


CREATE TABLE IF NOT EXISTS reviews(
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT,
course_id INT,
rating ENUM("1","2","3","4","5"),
comment LONGTEXT,
FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO reviews (user_id, course_id, rating, comment) VALUES
(1, 1, '5', 'Super cours, très clair !'),
(2, 2, '4', 'Bien expliqué, mais un peu rapide.'),
(3, 3, '3', 'Moyen, certaines parties sont confuses.'),
(4, 4, '5', 'Excellent contenu !'),
(5, 5, '2', 'Pas adapté pour débutants.'),
(6, 6, '4', 'Très utile, j’ai appris beaucoup.'),
(7, 7, '3', 'Correct mais peut être amélioré.'),
(8, 8, '5', 'Parfait, je recommande.'),
(9, 9, '4', 'Bon cours, mais manque d’exemples.'),
(10, 10, '5', 'Top qualité et pratique.'),
(11, 11, '3', 'Moyen, certaines explications sont floues.'),
(12, 12, '4', 'Bien structuré et intéressant.'),
(13, 13, '2', 'Pas assez approfondi.'),
(14, 14, '5', 'Excellent ! Très complet.'),
(15, 15, '4', 'Cours satisfaisant.'),
(16, 16, '5', 'Je recommande vivement.'),
(17, 17, '3', 'Peut mieux faire.'),
(18, 18, '4', 'Bonne qualité.'),
(19, 19, '5', 'Super instructeur.'),
(20, 20, '4', 'Très utile et bien expliqué.')
;