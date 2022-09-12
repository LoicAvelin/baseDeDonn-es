-- Création de la base de données avec l'encodage utf8mb4 qui contient les caractères de la langue, les symboles et les émojis.

CREATE DATABASE IF NOT EXISTS gaumont CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE gaumont;

-- Création des tables 

CREATE TABLE users 
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    password VARCHAR(100) NOT NULL, 
    firstname VARCHAR(50) NOT NULL, 
    lastname VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL, 
    email VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20)
) ENGINE = InnoDB;

CREATE TABLE cinemas
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    address VARCHAR(50) NOT NULL, 
    city VARCHAR(30) NOT NULL,
    department VARCHAR(30) NOT NULL,
    number_of_hall INT NOT NULL,
    phone_number VARCHAR(20) 
) ENGINE = InnoDB;

CREATE TABLE movies
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL, 
    length VARCHAR (20) NOT NULL,
    type VARCHAR(20),
    director VARCHAR(30),
    writer VARCHAR(30),
    production VARCHAR(30),
    main_actors VARCHAR(50),
    years INT
) ENGINE = InnoDB;

CREATE TABLE rates
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    description VARCHAR(50), 
    price FLOAT
) ENGINE = InnoDB;

CREATE TABLE sessions 
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    schedule DATETIME NOT NULL, 
    movie_id INT NOT NULL,
    CONSTRAINT fk_movies_sessions_id 
    FOREIGN KEY (movie_id) 
    REFERENCES movies (id) 
    ON DELETE CASCADE ON UPDATE CASCADE 
) ENGINE = InnoDB;

CREATE TABLE halls
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name_of_hall VARCHAR(30) NOT NULL,
    number_of_places INT NOT NULL, 
    cinema_id INT NOT NULL, 
    CONSTRAINT fk_cinemas_halls_id 
    FOREIGN KEY (cinema_id) 
    REFERENCES cinemas (id) 
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE halls_sessions 
(
    hall_id INT NOT NULL, 
    session_id INT NOT NULL, 
    CONSTRAINT fk_halls_halls_sessions
    FOREIGN KEY (hall_id)
    REFERENCES halls (id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_sessions_halls_sessions
    FOREIGN KEY (session_id)
    REFERENCES sessions (id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE rates_sessions
(
    rate_id INT NOT NULL, 
    session_id INT NOT NULL,
    CONSTRAINT fk_rates_rates_sessions 
    FOREIGN KEY (rate_id) 
    REFERENCES rates (id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_sessions_rates_sessions
    FOREIGN KEY (session_id) 
    REFERENCES sessions (id) 
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE sessions_users
(
    session_id INT NOT NULL, 
    user_id INT NOT NULL, 
    CONSTRAINT fk_sessions_sessions_users
    FOREIGN KEY (session_id) 
    REFERENCES sessions (id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_users_sessions_users
    FOREIGN KEY (user_id) 
    REFERENCES users (id) 
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Insertion des données

INSERT INTO 
    users (password, firstname, lastname, date_of_birth, email, phone_number)
VALUES 
    ('$2y$10$YyoHPLWdDpH.ZrQcqXJstucDAXyvlgWFePq8YA7A69NXquuEjxSxy', 'Pernell', 'Denerley', '1995-04-26', 'pdenerley0@mozilla.org', '0645265647'), 
    ('$2y$10$p8Nt6gRLpIaUDnGcQOoykuaqV2GvNVyb9uoVq.DGmwri0HSaO61Bu', 'Karil', 'Kennion', '2001-12-23', 'kkennion1@howstuffworks.com', '0754341788'),
    ('$2y$10$orXZGL53BKVt3E792t6TfePSYqGXHZmgYitcMpfZ5id7YdgUd8J32', 'Avrom', 'Strond', '1997-03-13', 'astrond2@rediff.com', '0654443378'),
    ('$2y$10$/o.73oaNZrkB8OVOXkbAbux6W5KpUByhf5gXa1TFiOze64tOHSL.S', 'Nadia', 'Klaes', '2002-07-30', 'nklaesa@eventbrite.com', '0777542190'), 
    ('$2y$10$l48w8u3b7Jz.D5c9iFDoBupGYNPF/JXQRdH6wqSUUGITugKYAo0Fa', 'Adah', 'Foot', '2006-08-11', 'affotn@geocities.jp', '0788903425');

INSERT INTO 
    movies (title, length, type, director, writer, production, main_actors, years)
VALUES
    ('La rivière verte', '230 minutes', 'action/romantique', 'Delabrossa Verde', 'Anthonio Ricardo', 'BlackStorm', 'Julien Delpech & Renaud Distorbe', 2022),
    ('Le lapin fait le singe', '180 minutes', 'comédie', 'Michel Ventreche', 'Rémi Sansfiltre', 'Studio Wagner', 'Bras De Pied & Rose Tendre', 2021),
    ('Sous le gâteau enchanté', '120 minutes', 'fantastique', 'Delabrossa Verde', 'Verdi Di Fromagio', 'Escapele De Fugi', 'Nathalie Portier', 2020),
    ('Un petit bateau sur la mer', '300 minutes', 'aventure', 'Grant Oliveira', 'Moustafa Youssef', 'Bros', 'Meal & Yourt', 2022);

INSERT INTO 
    rates (description, price)
VALUES
    ('Plein tarif', 9.20),
    ('Tarif étudiant', 7.60),
    ('Moins de 14 ans', 5.90), 
    ('Tarif printemps du cinéma', 5.50);

INSERT INTO 
    cinemas (address, city, department, number_of_hall, phone_number)
VALUES
    ('11 rue des piverts', 'Gastrombe', 'Cdificileàtrouver', 10, '0345238988'),
    ('5 rue la vilaine', 'La Passoire', 'Ilfosyfer', 4, '0245336724'),
    ('2 impasse la jolie', 'Làdoréfasi', 'ValOise', 8, '0178564433'), 
    ('34 rue des tuilleries', 'Saint-Jolie', 'Isère', 18, '0456337787');

INSERT INTO 
    sessions (schedule, movie_id)
VALUES
    ('2022-09-15 10:00', 1),
    ('2022-09-15 12:00', 1),
    ('2022-09-15 14:00', 1),
    ('2022-09-15 16:00', 1),
    ('2022-09-15 19:00', 1),
    ('2022-09-15 21:00', 1),
    ('2022-09-15 09:00', 2),
    ('2022-09-15 10:00', 2),
    ('2022-09-15 15:00', 2),
    ('2022-09-15 18:00', 2),
    ('2022-09-15 22:00', 2),
    ('2022-09-15 10:00', 3),
    ('2022-09-15 16:00', 3),
    ('2022-09-15 19:00', 4);

INSERT INTO 
    halls (name_of_hall, number_of_places, cinema_id)
VALUES
    ('Salle numéro 2', 230, 1),
    ('Salle numéro 2', 230, 2),
    ('Salle numéro 1', 340, 1),
    ('Salle numéro 4', 110, 3), 
    ('Salle numéro 3', 380, 4);

INSERT INTO 
    rates_sessions (rate_id, session_id)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (1, 4),
    (1, 5);

INSERT INTO
    sessions_users (session_id, user_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 3), 
    (2, 4), 
    (2, 5), 
    (7, 1), 
    (7, 2), 
    (12, 2);

INSERT INTO 
    halls_sessions (hall_id, session_id)
VALUES
    (1, 1),
    (2, 4), 
    (3, 1), 
    (5, 14);

-- Création d'un utilisateur administateur avec une vue sur toute la base de données

CREATE USER 'admin'@'localhost'
IDENTIFIED BY 'MotdePasse47';

GRANT ALL PRIVILEGES ON gaumont.* TO 'admin'@'localhost';


-- Création d'un utilisateur qui a la vue sur toute la base de données sans pouvoir la modifier

CREATE USER 'manager'@'localhost' 
IDENTIFIED BY 'maNage678jui';

GRANT SELECT ON gaumont.* TO 'manager'@'loaclhost';

-- On peut taper cette commande si les privilèges n'ont pas été pris en compte
FLUSH PRIVILEGES;

-- Effectuer une sauvegarde de la base de données dans un fichier
exit -- pour sortir de mysql dans le terminal et taper la commande ci-dessous pour la sauvegarde
mysqldump -u root -p gaumont > sauvegardeBDDgaumont.sql