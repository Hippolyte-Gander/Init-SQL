-- Exercice : remplir la base de données


------------------------- PERSONNE -------------------------
INSERT INTO personne (nom, prenom, sexe, date_naissance) VALUES
	('Spielberg', 'Steven','homme', '1948-12-18'),
	('Lucas', 'George','homme', '1944-05-14'),
	('Nolan', 'Christopher','homme', '1970-07-30'),
	('Tarantino ', 'Quentin','homme', '1963-03-27'),
	('Scorsese ', 'Martin','homme', '1942-11-17'),
	('Cameron ', 'James','homme', '1954-08-16'),
	('Scott ', 'Ridley','homme', '1937-11-30'),
	('Villeneuve ', 'Denis','homme', '1967-10-03'),
	('McGregor ', 'Ewan Gordon','homme', '1971-03-31'),
	('Worthington ', 'Samuel','homme', '1976-08-02'),
	('DiCaprio ', 'Leonardo','homme', '1974-11-11'),
	('Winslet ', 'Kate','femme', '1975-10-05');

------------------------- GENRE -------------------------
INSERT INTO genre (nom_genre) VALUES
('fantastique'),
('romance'),
('science-fiction'),
('space-opera'),
('action'),
('policier');

------------------------- ROLE -------------------------
INSERT INTO role (nom_role) VALUES
('Obi-wan Kenobi'),
('Jake Sully'),
('Rose Dewitt Bukater'),
('Jack Dawnson'),
('Cobb');

------------------------- REALISATEUR -------------------------
INSERT INTO realisateur (id_personne) VALUES
	(1),
	(2),
	(3),
	(4),
	(5),
	(6),
	(7),
	(8);


------------------------- ACTEUR -------------------------
INSERT INTO acteur (id_personne) VALUES
	(9),
	(10),
	(11),
	(12);

------------------------- FILM -------------------------
INSERT INTO film (id_realisateur, nom_film, annee_sortie, duree, synopsis , note, affiche) VALUES
	(6, 'Titanic', '1997', 194, 'à la fin le bateau coule', 3,''),
	(6, 'Avatar', '2009', 162, 'des grands hommes bleus contre des petits hommes', 5,''),
	(2, 'Star Wars: Episode I – The Phantom Menace', '1999', 136, 'vive les sabres lasers', 5,''),
	(3, 'Inception', '2010', 148, 'rien compris, à la fin elle tourne ou pas la toupie', 4,'');

------------------------- APPARTIENT -------------------------
INSERT INTO appartient (id_film, id_genre) VALUES
	(1, 2),
	(2, 3),
	(3, 4),
	(4, 5);

------------------------- CASTING -------------------------
INSERT INTO casting (id_film, id_acteur, id_role) VALUES
	(1, 3, 4),
	(1, 4, 3),
	(2, 2, 2),
	(3, 1, 1),
	(4, 3, 5);


------------------------- Ajouté par la suite -------------------------
INSERT INTO personne (nom, prenom, sexe, date_naissance) VALUES
	('Chabat', 'Alain', 'homme', '1958-11-24');
INSERT INTO genre (nom_genre) VALUES
	('humour');
INSERT INTO role (nom_role) VALUES
	('Jules César');
INSERT INTO realisateur (id_personne) VALUES
	(13);
INSERT INTO acteur (id_personne) VALUES
	(13);
INSERT INTO film (id_realisateur, nom_film, annee_sortie, duree, synopsis , note, affiche) VALUES
	(9, 'Astéric et Obélix Mission Cléopâtre', '2002', 112, "c'est drôle", 5,'');
INSERT INTO appartient (id_film, id_genre) VALUES
	(5, 7);
INSERT INTO casting (id_film, id_acteur, id_role) VALUES
	(5, 5, 5);



-- Exercice : réaliser des requêtes

-- a. Informations d’un film (id_film) : titre, année, durée (au format HH:MM) et réalisateur

SELECT f.nom_film, f.annee_sortie,
		CONCAT(FLOOR(f.duree / 60), ':', LPAD(f.duree % 60, 2, '0')) AS duree_formattee,
		p.prenom, p.nom
FROM film f
INNER JOIN realisateur r ON r.id_realisateur = f.id_realisateur
INNER JOIN personne p ON p.id_personne = r.id_personne
WHERE f.nom_film = 'Inception';

-- b. Liste des films dont la durée excède 2h15 classés par durée (du + long au + court)

SELECT f.nom_film,
		CONCAT(FLOOR(f.duree / 60), ':', LPAD(f.duree % 60, 2, '0')) AS duree_formattee
FROM film f
WHERE f.duree > 135
ORDER BY f.duree DESC;

-- c. Liste des films d’un réalisateur (en précisant l’année de sortie)

SELECT f.nom_film, f.annee_sortie
FROM film f
INNER JOIN realisateur r ON r.id_realisateur = f.id_realisateur
INNER JOIN personne p ON p.id_personne = r.id_personne
WHERE p.nom = 'Lucas';

-- d. Nombre de films par genre (classés dans l’ordre décroissant)

SELECT g.nom_genre, COUNT(a.id_genre) AS nbrFilm
FROM genre g
INNER JOIN appartient a ON a.id_genre = g.id_genre
INNER JOIN film f ON f.id_film = a.id_film
GROUP BY g.nom_genre
ORDER BY nbrFilm DESC;

-- e. Nombre de films par réalisateur (classés dans l’ordre décroissant)

SELECT p.prenom, p.nom, COUNT(f.id_realisateur) AS nbrFilmRealises
FROM personne p
INNER JOIN realisateur r ON r.id_personne = p.id_personne
INNER JOIN film f ON f.id_realisateur = r.id_realisateur
GROUP BY p.nom
ORDER BY nbrFilmRealises DESC;


-- f. Casting d’un film en particulier (id_film) : nom, prénom des acteurs + sexe

SELECT p.prenom, p.nom, p.sexe
FROM personne p
INNER JOIN acteur a ON a.id_personne = p.id_personne
INNER JOIN casting c ON c.id_acteur = a.id_acteur
INNER JOIN film f ON f.id_film = c.id_film
WHERE f.nom_film = 'Titanic'; -- fait avec f.nom_film mais f.id_film fonctionne aussi

-- g. Films tournés par un acteur en particulier (id_acteur) avec leur rôle et l’année de sortie (du film le plus récent au plus ancien)

SELECT f.nom_film, r.nom_role, f.annee_sortie
FROM role r
INNER JOIN casting c ON c.id_role = r.id_role
INNER JOIN acteur a ON a.id_acteur = c.id_acteur
INNER JOIN film f ON f.id_film = c.id_film
WHERE a.id_acteur = '3'
ORDER BY f.annee_sortie DESC

-- h. Liste des personnes qui sont à la fois acteurs et réalisateurs

SELECT p.prenom, p.nom
FROM personne p
INNER JOIN realisateur r ON r.id_personne = p.id_personne
INNER JOIN acteur a ON a.id_personne = p.id_personne
WHERE a.id_personne = r.id_personne;

-- i. Liste des films qui ont moins de 5 ans (classés du plus récent au plus ancien)

SELECT f.nom_film, f.annee_sortie
FROM film f
WHERE f.annee_sortie >= YEAR(CURDATE()) - 5
ORDER BY f.annee_sortie DESC;

-- j. Nombre d’hommes et de femmes parmi les acteurs

SELECT p.sexe, COUNT(a.id_acteur) AS nbr
FROM acteur a
INNER JOIN personne p ON p.id_personne = a.id_personne
GROUP BY p.sexe;

-- k. Liste des acteurs ayant plus de 50 ans (âge révolu et non révolu)

SELECT p.prenom, p.nom, p.date_naissance
FROM personne p
WHERE TIMESTAMPDIFF(YEAR, p.date_naissance, CURDATE()) > 50; -- on met >= 50 pour l'âge non révolu

-- l. Acteurs ayant joué dans 3 films ou plus

SELECT p.prenom, p.nom, COUNT(c.id_acteur) AS nbrFilms
FROM personne p
INNER JOIN acteur a ON a.id_personne = p.id_personne
INNER JOIN casting c ON c.id_acteur = a.id_acteur
GROUP BY p.prenom
HAVING nbrFilms >= 3;