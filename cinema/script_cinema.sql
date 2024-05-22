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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `personne` DISABLE KEYS */;
INSERT INTO `personne` (`id_personne`, `nom_personne`, `prenom_personne`, `sexe_personne`, `date_naissance`) VALUES
	(1, 'Spielberg', 'Steven','homme', 1948-12-18),
	(2, 'Lucas', 'George','homme', 1944-05-14),
	(3, 'Nolan', 'Christopher','homme', 1970-07-30),
	(4, 'Tarantino ', 'Quentin ','homme', 1963-03-27),
	(5, 'Scorsese ', 'Martin ','homme', 1942-11-17),
	(6, 'Cameron ', 'James ','homme', 1954-08-16),
	(7, 'Scott ', 'Ridley ','homme', 1937-11-30),
	(8, 'Villeneuve ', 'Denis ','homme', 1967-10-03),
/*!40000 ALTER TABLE `personne` ENABLE KEYS */;


------------------------- GENRE -------------------------
CREATE TABLE IF NOT EXISTS `genre` (
`id_genre` int(11) NOT NULL AUTO_INCREMENT,
`nom_genre` varchar(50) COLLATE utf8_bin NOT NULL,
PRIMARY KEY (`id_genre`),
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `genre` DISABLE KEYS */;

/*!40000 ALTER TABLE `genre` ENABLE KEYS */;


------------------------- ROLE -------------------------
CREATE TABLE IF NOT EXISTS `role` (
`id_role` int(11) NOT NULL AUTO_INCREMENT,
`nom_role` varchar(50) COLLATE utf8_bin NOT NULL,
PRIMARY KEY (`id_role`),
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `role` DISABLE KEYS */;

/*!40000 ALTER TABLE `role` ENABLE KEYS */;


------------------------- APPARTIENT -------------------------
CREATE TEBLE IF NOT EXISTS `appartient` (
  `id_genre` int(11) NOT NULL,
  `id_film` int(11) NOT NULL,
  CONSTRAINT `FK_AUTO_GENRE` FOREIGN KEY (`id_genre`), REFERENCES `genre` (`id_genre`),
  CONSTRAINT `FK_AUTO_FILM` FOREIGN KEY (`id_film`), REFERENCES `film` (`id_film`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `casting` DISABLE KEYS */;
INSERT INTO `casting` (`id_genre`, `id_film`) VALUES
	(1, 4),
	(9, 5),
	(14, 42),
	(1, 44);
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
	(1, 4),
	(9, 5),
	(14, 42),
	(1, 44);
/*!40000 ALTER TABLE `casting` ENABLE KEYS */;


------------------------- REALISATEUR -------------------------
CREATE TABLE IF NOT EXISTS `realisateur` (
`id_realisateur` int(11) NOT NULL AUTO_INCREMENT,
`id_personne` int(11) NOT NULL,
PRIMARY KEY (`id_realisateur`),
CONSTRAINT `FK_AUTO_PERSONNE` FOREIGN KEY (`id_personne`) REFERENCES `personne` (`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40000 ALTER TABLE `acteur` DISABLE KEYS */;
INSERT INTO `casting` (`id_film`, `id_acteur`, `id_role`) VALUES
	(1, 4),
	(9, 5),
	(14, 42),
	(1, 44);
/*!40000 ALTER TABLE `acteur` ENABLE KEYS */;







/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;