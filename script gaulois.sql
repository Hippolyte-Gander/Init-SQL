-- 1. Nom des lieux qui finissent par 'um'
SELECT nom_lieu
FROM lieu
WHERE nom_lieu = '%um'

-- 2. Nombre de personnages par lieu (trié par nombre de personnages décroissant).
SELECT COUNT(personnage.nom_personnage) AS nbPerso, lieu.nom_lieu
FROM personnage
INNER JOIN lieu ON personnage.id_lieu = lieu.id_lieu
GROUP BY lieu.id_lieu
ORDER BY nbPerso DESC

-- 3. Nom des personnages + spécialité + adresse et lieu d'habitation, triés par lieu puis par nom de personnage.
SELECT nom_personnage, id_specialite, adresse_personnage, id_lieu
FROM personnage
ORDER BY id_lieu, nom_personnage

-- 4. Nom des spécialités avec nombre de personnages par spécialité (trié par nombre de personnages décroissant).
SELECT COUNT(personnage.id_personnage) AS nbPersonnages, specialite.nom_specialite
FROM personnage
INNER JOIN specialite ON personnage.id_specialite = specialite.id_specialite
GROUP BY specialite.id_specialite
ORDER BY nbPersonnages DESC

-- 5. Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates affichées au format jj/mm/aaaa).
SELECT bataille.nom_bataille, DATE_FORMAT(bataille.date_bataille, "%d %m %Y") AS dateB, lieu.nom_lieu
FROM bataille
INNER JOIN lieu ON bataille.id_lieu = lieu.id_lieu
GROUP BY bataille.id_bataille
ORDER BY bataille.date_bataille DESC

-- 6. Nom des potions + coût de réalisation de la potion (trié par coût décroissant).
SELECT potion.nom_potion, SUM(ingredient.cout_ingredient * composer.qte) AS prixTot
FROM  composer
INNER JOIN ingredient ON ingredient.id_ingredient = composer.id_ingredient
INNER JOIN potion ON composer.id_potion = potion.id_potion
GROUP BY potion.nom_potion
ORDER BY prixTot DESC

-- 7. Nom des ingrédients + coût + quantité de chaque ingrédient qui composent la potion 'Santé'.
SELECT i.nom_ingredient, i.cout_ingredient, c.qte
FROM composer c
INNER JOIN ingredient i ON i.id_ingredient = c.id_ingredient
INNER JOIN potion p ON c.id_potion = p.id_potion
WHERE p.nom_potion = 'Santé'

-- 8. Nom du ou des personnages qui ont pris le plus de casques dans la bataille 'Bataille du village gaulois'.
SELECT  p.nom_personnage, MAX(pc.qte) AS recordCasques
FROM prendre_casque pc
INNER JOIN personnage p ON p.id_personnage = pc.id_personnage
INNER JOIN bataille b ON b.id_bataille = pc.id_bataille
WHERE b.nom_bataille = 'Bataille du village gaulois' 
    AND pc.qte = (SELECT MAX(pc.qte)
                FROM prendre_casque pc
                INNER JOIN bataille b ON b.id_bataille = pc.id_bataille
                WHERE b.nom_bataille = 'Bataille du village gaulois')
GROUP BY p.nom_personnage

-- 9. Nom des personnages et leur quantité de potion bue (en les classant du plus grand buveur au plus petit).
SELECT p.nom_personnage, SUM(b.id_personnage * b.dose_boire) AS qtePotionBue
FROM boire b
INNER JOIN personnage p ON p.id_personnage = b.id_personnage
GROUP BY p.nom_personnage
ORDER BY qtePotionBue DESC

-- 10. Nom de la bataille où le nombre de casques pris a été le plus important.
SELECT b.nom_bataille, SUM(pc.qte) AS qteTotCasques
FROM prendre_casque pc
INNER JOIN bataille b ON b.id_bataille = pc.id_bataille
GROUP BY b.nom_bataille
HAVING qteTotCasques = (SELECT MAX(qteTot)
                FROM (SELECT SUM(pc.qte) AS qteTot
                    FROM prendre_casque pc
                    INNER JOIN bataille b ON b.id_bataille = pc.id_bataille
                    GROUP BY b.nom_bataille)
                    AS subquery)

-- 11. Combien existe-t-il de casques de chaque type et quel est leur coût total ? (classés par nombre décroissant)
SELECT tc.nom_type_casque, COUNT(c.nom_casque) AS nbCasque, SUM(c.cout_casque) AS prixTot
FROM casque c
INNER JOIN type_casque tc ON tc.id_type_casque = c.id_type_casque
GROUP BY tc.nom_type_casque
ORDER BY prixTot DESC

-- 12. Nom des potions dont un des ingrédients est le poisson frais.
SELECT p.nom_potion
FROM composer c
INNER JOIN ingredient i ON i.id_ingredient = c.id_ingredient
INNER JOIN potion p ON p.id_potion = c.id_potion
WHERE i.nom_ingredient = 'Poisson frais'

-- 13. Nom du / des lieu(x) possédant le plus d'habitants, en dehors du village gaulois.
SELECT l.nom_lieu, COUNT(p.id_lieu) AS nbHabitants
FROM personnage p
INNER JOIN lieu l ON l.id_lieu = p.id_lieu
GROUP BY l.nom_lieu
HAVING COUNT(p.id_lieu) = (SELECT MAX(nbHab)
                        FROM ( SELECT COUNT(p.id_lieu) AS nbHab
                            FROM personnage p
                            INNER JOIN lieu l ON l.id_lieu = p.id_lieu
                            GROUP BY l.nom_lieu)
                            AS subquery)

-- 14. Nom des personnages qui n'ont jamais bu aucune potion.
SELECT p.nom_personnage
FROM personnage p
WHERE id_personnage NOT IN (
    SELECT id_personnage
    FROM boire b
    WHERE b.dose_boire > 0
)

-- 15. Nom du / des personnages qui n'ont pas le droit de boire de la potion 'Magique'.
SELECT p.nom_personnage
FROM personnage p
WHERE id_personnage NOT IN (
    SELECT id_personnage
    FROM autoriser_boire ab
    INNER JOIN potion p ON p.id_potion = ab.id_potion
    WHERE p.nom_potion = 'Magique'
)

-- A. Ajoutez le personnage suivant : Champdeblix, agriculteur résidant à la ferme Hantassion de Rotomagus.


-- B. Autorisez Bonemine à boire de la potion magique, elle est jalouse d'Iélosubmarine...


-- C. Supprimez les casques grecs qui n'ont jamais été pris lors d'une bataille.


-- D. Modifiez l'adresse de Zérozérosix : il a été mis en prison à Condate.


-- E. La potion 'Soupe' ne doit plus contenir de persil.


-- F. Obélix s'est trompé : ce sont 42 casques Weisenau, et non Ostrogoths, qu'il a pris lors de la bataille 'Attaque de la banque postale'. Corrigez son erreur !