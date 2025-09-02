CREATE DATABASE IF NOT EXISTS revision;
USE revision;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150),
    email VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name, email, created_at) VALUES
('Alice Martin', 'alice.martin@email.com', '2023-01-15 10:30:00'),
('Bob Dupont', 'bob.dupont@email.com', '2023-02-20 14:15:00'),
('Catherine Moreau', 'catherine.moreau@email.com', '2023-03-10 09:45:00'),
('David Bernard', 'david.bernard@email.com', '2023-03-25 16:20:00'),
('Emma Rousseau', 'emma.rousseau@email.com', '2023-04-12 11:10:00'),
('François Leroy', 'francois.leroy@email.com', '2023-05-08 13:30:00'),
('Gabrielle Simon', 'gabrielle.simon@email.com', '2023-05-22 15:45:00'),
('Hugo Petit', 'hugo.petit@email.com', '2023-06-14 08:20:00'),
('Isabelle Roux', 'isabelle.roux@email.com', '2023-07-03 12:15:00'),
('Julien Garnier', 'julien.garnier@email.com', '2023-07-18 17:30:00'),
('Karine Fabre', 'karine.fabre@email.com', '2023-08-05 10:00:00'),
('Laurent Mercier', 'laurent.mercier@email.com', '2023-08-20 14:45:00'),
('Marie Blanc', 'marie.blanc@email.com', '2023-09-12 09:30:00'),
('Nicolas Girard', 'nicolas.girard@email.com', '2023-09-28 16:15:00'),
('Olivia Bonnet', 'olivia.bonnet@email.com', '2023-10-14 11:45:00'),
('Pierre Muller', 'pierre.muller@email.com', '2023-11-02 13:20:00'),
('Quentin Lambert', 'quentin.lambert@email.com', '2023-11-18 15:10:00'),
('Rose Fontaine', 'rose.fontaine@email.com', '2023-12-05 08:45:00'),
('Sébastien Morel', 'sebastien.morel@email.com', '2023-12-22 12:30:00'),
('Théo Carpentier', 'theo.carpentier@email.com', '2024-01-10 14:20:00'),
('Valérie Dufour', 'valerie.dufour@email.com', '2024-02-15 10:15:00'),
('William Nguyen', 'william.nguyen@email.com', '2024-03-08 16:45:00'),
('Xavier Perrin', 'xavier.perrin@email.com', '2024-04-20 09:10:00'),
('Yasmine Dubois', 'yasmine.dubois@email.com', '2024-05-12 11:30:00'),
('Zoé Leclerc', 'zoe.leclerc@email.com', '2024-06-25 15:20:00');


CREATE TABLE IF NOT EXISTS courses(
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(150),
category VARCHAR(150),
price DECIMAL(10,2)
);

INSERT INTO courses (title, category, price) VALUES
('Introduction au JavaScript', 'Programmation', 0.00),
('Python pour débutants', 'Programmation', 89.99),
('Bases de données SQL avancé', 'Programmation', 129.99),
('React.js - Développement moderne', 'Programmation', 149.99),
('HTML/CSS - Les fondamentaux', 'Programmation', 0.00),
('Photoshop pour créatifs', 'Design', 119.99),
('UI/UX Design Principles', 'Design', 179.99),
('Illustrator - Illustration vectorielle', 'Design', 109.99),
('Marketing Digital 2024', 'Marketing', 199.99),
('SEO et référencement naturel', 'Marketing', 0.00),
('Gestion de projet Agile', 'Management', 249.99),
('Leadership et communication', 'Management', 199.99),
('Comptabilité pour entrepreneurs', 'Finance', 169.99),
('Investissement et bourse', 'Finance', 299.99),
('Anglais des affaires', 'Langues', 0.00);
('Maths', 'maths', 5000)
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
-- Utilisateur 1 (Alice) - 4 cours
(1, 1, '2023-02-01 10:30:00', TRUE, '2023-02-28 18:45:00'),
(1, 5, '2023-02-15 14:20:00', TRUE, '2023-03-01 16:30:00'),
(1, 6, '2023-03-10 09:15:00', TRUE, '2023-04-05 20:10:00'),
(1, 15, '2023-04-20 11:45:00', FALSE, NULL),

-- Utilisateur 2 (Bob) - 3 cours
(2, 2, '2023-03-01 13:30:00', TRUE, '2023-03-25 19:20:00'),
(2, 3, '2023-03-15 16:45:00', TRUE, '2023-04-10 17:30:00'),
(2, 11, '2023-05-01 10:15:00', FALSE, NULL),

-- Utilisateur 3 (Catherine) - 5 cours
(3, 1, '2023-03-20 12:00:00', TRUE, '2023-04-15 14:30:00'),
(3, 4, '2023-04-05 15:30:00', TRUE, '2023-05-02 16:45:00'),
(3, 7, '2023-04-25 08:45:00', TRUE, '2023-05-20 12:15:00'),
(3, 9, '2023-05-15 14:20:00', FALSE, NULL),
(3, 12, '2023-06-01 11:10:00', TRUE, '2023-06-28 15:45:00'),

-- Utilisateur 4 (David) - 2 cours
(4, 8, '2023-04-10 09:30:00', TRUE, '2023-05-05 18:20:00'),
(4, 13, '2023-05-20 16:15:00', FALSE, NULL),

-- Utilisateur 5 (Emma) - 3 cours
(5, 2, '2023-04-25 11:45:00', TRUE, '2023-05-18 13:30:00'),
(5, 5, '2023-05-10 14:30:00', TRUE, '2023-05-25 16:45:00'),
(5, 10, '2023-06-15 10:20:00', FALSE, NULL),

-- Utilisateur 6 (François) - 4 cours
(6, 1, '2023-05-15 13:15:00', TRUE, '2023-06-08 17:30:00'),
(6, 3, '2023-06-01 15:45:00', TRUE, '2023-06-25 19:15:00'),
(6, 14, '2023-07-10 12:30:00', TRUE, '2023-08-05 14:45:00'),
(6, 15, '2023-08-20 09:45:00', FALSE, NULL),

-- Utilisateur 7 (Gabrielle) - 2 cours
(7, 6, '2023-06-05 14:20:00', TRUE, '2023-07-02 16:30:00'),
(7, 7, '2023-07-15 11:15:00', FALSE, NULL),

-- Utilisateur 8 (Hugo) - 3 cours
(8, 2, '2023-06-20 16:30:00', TRUE, '2023-07-12 18:45:00'),
(8, 4, '2023-08-05 10:45:00', TRUE, '2023-08-30 15:20:00'),
(8, 9, '2023-09-10 13:30:00', FALSE, NULL),

-- Utilisateur 9 (Isabelle) - 1 cours
(9, 12, '2023-07-15 12:45:00', TRUE, '2023-08-10 14:30:00'),

-- Utilisateur 10 (Julien) - 4 cours
(10, 1, '2023-08-01 09:30:00', TRUE, '2023-08-25 17:45:00'),
(10, 3, '2023-08-20 14:15:00', TRUE, '2023-09-15 16:30:00'),
(10, 5, '2023-09-05 11:45:00', TRUE, '2023-09-20 13:15:00'),
(10, 11, '2023-10-10 15:30:00', FALSE, NULL),

-- Utilisateur 11 (Karine) - 2 cours
(11, 8, '2023-08-15 13:20:00', TRUE, '2023-09-08 15:45:00'),
(11, 10, '2023-10-01 10:30:00', FALSE, NULL),

-- Utilisateur 12 (Laurent) - 3 cours
(12, 2, '2023-09-01 16:15:00', TRUE, '2023-09-28 18:30:00'),
(12, 6, '2023-10-15 12:45:00', TRUE, '2023-11-10 14:20:00'),
(12, 13, '2023-11-25 09:30:00', FALSE, NULL),

-- Utilisateur 13 (Marie) - 2 cours
(13, 7, '2023-09-20 14:45:00', TRUE, '2023-10-15 16:15:00'),
(13, 9, '2023-11-05 11:30:00', FALSE, NULL),

-- Utilisateur 14 (Nicolas) - 3 cours
(14, 1, '2023-10-05 15:20:00', TRUE, '2023-10-28 17:45:00'),
(14, 4, '2023-11-15 10:15:00', TRUE, '2023-12-10 13:30:00'),
(14, 14, '2023-12-20 14:45:00', FALSE, NULL),

-- Utilisateur 15 (Olivia) - 2 cours
(15, 5, '2023-10-25 12:30:00', TRUE, '2023-11-08 15:45:00'),
(15, 15, '2023-12-01 09:15:00', FALSE, NULL),

-- Utilisateur 16 (Pierre) - 3 cours
(16, 2, '2023-11-10 16:45:00', TRUE, '2023-12-05 18:20:00'),
(16, 11, '2023-12-15 11:30:00', TRUE, '2024-01-08 14:45:00'),
(16, 12, '2024-01-20 13:15:00', FALSE, NULL),

-- Utilisateur 17 (Quentin) - 2 cours
(17, 3, '2023-12-01 14:30:00', TRUE, '2023-12-28 16:45:00'),
(17, 8, '2024-01-15 10:20:00', FALSE, NULL),

-- Utilisateur 18 (Rose) - 4 cours
(18, 1, '2023-12-20 15:45:00', TRUE, '2024-01-12 17:30:00'),
(18, 6, '2024-02-01 12:15:00', TRUE, '2024-02-25 14:45:00'),
(18, 9, '2024-03-10 09:30:00', TRUE, '2024-04-02 11:15:00'),
(18, 13, '2024-04-15 16:20:00', FALSE, NULL),

-- Utilisateur 19 (Sébastien) - 1 cours
(19, 14, '2024-01-05 13:45:00', TRUE, '2024-02-08 15:30:00'),

-- Utilisateur 20 (Théo) - 2 cours
(20, 4, '2024-01-25 11:15:00', TRUE, '2024-02-18 13:45:00'),
(20, 7, '2024-03-05 14:30:00', FALSE, NULL),

-- Utilisateur 21 (Valérie) - 1 cours
(21, 10, '2024-03-01 16:45:00', FALSE, NULL),

-- Utilisateur 22 (William) - 2 cours
(22, 2, '2024-03-20 10:30:00', TRUE, '2024-04-15 12:45:00'),
(22, 5, '2024-05-01 14:15:00', FALSE, NULL),

-- Utilisateur 23 (Xavier) - 1 cours
(23, 15, '2024-05-05 09:45:00', FALSE, NULL),

-- Utilisateur 24 (Yasmine) - 0 cours (aucune inscription)

-- Utilisateur 25 (Zoé) - 1 cours
(25, 11, '2024-07-01 11:30:00', FALSE, NULL);
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
(1, 1, '5', 'Excellent cours ! Les explications sont claires et les exercices pratiques.'),
(1, 5, '4', 'Très bon pour débuter, quelques sections pourraient être plus détaillées.'),
(2, 2, '5', 'Parfait pour apprendre Python. Le formateur est pédagogue.'),
(3, 1, '4', 'Contenu de qualité, rythme adapté aux débutants.'),
(3, 4, '5', 'React expliqué de manière magistrale ! Je recommande vivement.'),
(4, 8, '3', 'Correct mais manque d\'exemples concrets dans certaines parties.'),
(5, 2, '4', 'Bon cours, structure claire et progression logique.'),
(6, 1, '5', 'Très satisfait, formation complète et bien organisée.'),
(6, 3, '4', 'Solide formation SQL, quelques concepts avancés difficiles à suivre.'),
(7, 6, '5', 'Formation Photoshop exceptionnelle ! Tutoriels très détaillés.'),
(8, 2, '2', 'Déçu, trop basique pour moi. Attendais plus de contenu avancé.'),
(9, 12, '4', 'Leadership bien expliqué avec de bons cas pratiques.'),
(10, 1, '5', 'Formation JavaScript parfaite pour débuter dans le développement web.'),
(12, 2, '3', 'Moyen, certains chapitres auraient mérité plus d\'approfondissement.'),
(13, 7, '5', 'Design UX/UI expliqué brillamment ! Méthodologie très claire.'),
(14, 1, '4', 'Très bon cours, instructeur compétent et disponible.'),
(16, 2, '1', 'Très déçu, contenu obsolète et mal structuré.'),
(18, 1, '5', 'Parfait ! Explications claires et projet final très formateur.');