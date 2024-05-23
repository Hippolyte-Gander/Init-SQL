CREATE DATABASE IF NOT EXISTS `cinema` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `cinema`;


------------------------- PERSONNE -------------------------
CREATE TABLE IF NOT EXISTS `personne` (
  `id_personne` int(11) NOT NULL AUTO_INCREMENT,
  `nom_personne` varchar(50) COLLATE utf8_bin NOT NULL,
  `prenom_personne` varchar(50) COLLATE utf8_bin NOT NULL,
  `sexe_personne` varchar(50) COLLATE utf8_bin NOT NULL,
  `date_naissance` date NOT NULL,
  PRIMARY KEY (`id_personne`),
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `personne` DISABLE KEYS */;
INSERT INTO `personne` (`id_personne`, `nom_personne`, `prenom_personne`, `sexe_personne`, `date_naissance`) VALUES
	('Spielberg', 'Steven','homme', 1948-12-18),
	('Lucas', 'George','homme', 1944-05-14),
	('Nolan', 'Christopher','homme', 1970-07-30),
	('Tarantino ', 'Quentin','homme', 1963-03-27),
	('Scorsese ', 'Martin','homme', 1942-11-17),
	('Cameron ', 'James','homme', 1954-08-16),
	('Scott ', 'Ridley','homme', 1937-11-30),
	('Villeneuve ', 'Denis','homme', 1967-10-03),
	('McGregor ', 'Ewan Gordon','homme', 1971-03-31),
	('Worthington ', 'Samuel','homme', 1976-08-02),
	('DiCaprio ', 'Leonardo','homme', 1974-11-11),
	('Winslet ', 'Kate','femme', 1975-10-05);
/*!40000 ALTER TABLE `personne` ENABLE KEYS */;


------------------------- GENRE -------------------------
CREATE TABLE IF NOT EXISTS `genre` (
`id_genre` int(11) NOT NULL AUTO_INCREMENT,
`nom_genre` varchar(255) COLLATE utf8_bin NOT NULL,
PRIMARY KEY (`id_genre`),
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` (`nom_genre`) VALUES
(`fantastique`),
(`romance`),
(`science-fiction`),
(`space-opera`),
(`action`),
(`policier`);
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;


------------------------- FILM -------------------------
CREATE TABLE IF NOT EXISTS `film` (
`id_film` int(11) NOT NULL AUTO_INCREMENT,
`id_realisateur` int(11) NOT NULL,
`nom_film` varchar(50) COLLATE utf8_bin NOT NULL,
`date_sortie` int(4) NOT NULL,
`duree` int(11) NOT NULL,
`synopsis` varchar(255) COLLATE utf8_bin,
`note` int(1),
`affiche` varchar(255) COLLATE utf8_bin,
PRIMARY KEY (`id_film`),
CONSTRAINT `FK_AUTO_REALISATEUR` FOREIGN KEY (`id_realisateur`) REFERENCES `realisateur` (`id_realisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `film` DISABLE KEYS */;
INSERT INTO `film` (`id_realisateur`, `nom_film`, `date_sortie`, `duree`, `synopsis` , `note`, `affiche`) VALUES
	(6, `Titanic`, `1997`, 194, `à la fin le bateau coule`, 3),
	(6, `Avatar`, `2009`, 162, `des grands hommes bleus contre des petits hommes`, 5),
	(2, `Star Wars: Episode I – The Phantom Menace`, `1999`, 136, `vive les sabres lasers`, 5),
	(3, `Inception`, `2010`, 148, `rien compris, à la fin elle tourne ou pas la toupie`, 4);
/*!40000 ALTER TABLE `film` ENABLE KEYS */;


------------------------- ROLE -------------------------
CREATE TABLE IF NOT EXISTS `role` (
`id_role` int(11) NOT NULL AUTO_INCREMENT,
`nom_role` varchar(50) COLLATE utf8_bin NOT NULL,
PRIMARY KEY (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`nom_role`) VALUES
(`Obi-wan Kenobi`),
(`Jake Sully`),
(`Rose Dewitt Bukater`),
(`Jack Dawnson`),
(`Cobb`);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;


------------------------- REALISATEUR -------------------------
CREATE TABLE IF NOT EXISTS `realisateur` (
`id_realisateur` int(11) NOT NULL AUTO_INCREMENT,
`id_personne` int(11) NOT NULL,
PRIMARY KEY (`id_realisateur`),
CONSTRAINT `FK_AUTO_PERSONNE` FOREIGN KEY (`id_personne`) REFERENCES `personne` (`id_personne`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `realisateur` DISABLE KEYS */;
INSERT INTO `casting` (`id_film`, `id_acteur`, `id_role`) VALUES
	(1, 4),
	(9, 5),
	(14, 42),
	(1, 44);
/*!40000 ALTER TABLE `realisateur` ENABLE KEYS */;


------------------------- ACTEUR -------------------------
CREATE TABLE IF NOT EXISTS `acteur` (
`id_acteur` int(11) NOT NULL AUTO_INCREMENT,
`id_personne` int(11) NOT NULL,
PRIMARY KEY (`id_acteur`),
CONSTRAINT `FK_AUTO_PERSONNE` FOREIGN KEY (`id_personne`) REFERENCES `personne` (`id_personne`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `acteur` DISABLE KEYS */;
INSERT INTO `acteur` (`id_personne`) VALUES
	(9),
	(10),
	(11),
	(12);
/*!40000 ALTER TABLE `acteur` ENABLE KEYS */;


------------------------- APPARTIENT -------------------------
CREATE TABLE IF NOT EXISTS `appartient` (
  `id_genre` int(11) NOT NULL,
  `id_film` int(11) NOT NULL,
  CONSTRAINT `FK_AUTO_GENRE` FOREIGN KEY (`id_genre`), REFERENCES `genre` (`id_genre`),
  CONSTRAINT `FK_AUTO_FILM` FOREIGN KEY (`id_film`), REFERENCES `film` (`id_film`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `casting` DISABLE KEYS */;
INSERT INTO `appartient` (`id_film`, `id_genre`) VALUES
	(1, 2),
	(2, 3),
	(3, 4),
	(4, 5);
/*!40000 ALTER TABLE `casting` ENABLE KEYS */;


------------------------- CASTING -------------------------
CREATE TABLE IF NOT EXISTS `casting` (
  `id_film` int(11) NOT NULL,
  `id_acteur` int(11) NOT NULL,
  `id_role` int(11) NOT NULL,
  CONSTRAINT `FK_AUTO_FILM` FOREIGN KEY (`id_film`) REFERENCES `film` (`id_film`),
  CONSTRAINT `FK_AUTO_ACTEUR` FOREIGN KEY (`id_acteur`) REFERENCES `acteur` (`id_acteur`)
  CONSTRAINT `FK_AUTO_ROLE` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `casting` DISABLE KEYS */;
INSERT INTO `casting` (`id_film`, `id_acteur`, `id_role`) VALUES
	(1, 3, 4),
	(1, 4, 3),
	(2, 2, 2),
	(3, 1, 1),
	(4, 3, 5);
/*!40000 ALTER TABLE `casting` ENABLE KEYS */;




/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;