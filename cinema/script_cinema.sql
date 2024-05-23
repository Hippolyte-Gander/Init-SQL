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