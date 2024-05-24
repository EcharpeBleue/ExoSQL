-- https://fxjollois.github.io/cours-sql/ --

Chapitre 1

Exo 2:
SELECT * FROM Produit;

SELECT * FROM Produit LIMIT 10;

SELECT * FROM Produit ORDER BY PrixUnit ASC;

SELECT * FROM Produit ORDER BY PrixUnit DESC LIMIT 3;

Exo 3:
SELECT * FROM Client WHERE Ville = "Paris";

SELECT * FROM Client WHERE Pays IN ("Suisse", "Allemagne", "Belgique");

SELECT * FROM Client WHERE Fax IS NULL;

SELECT * FROM Client WHERE Societe LIKE '%restaurante%';

Exo 4:
SELECT DISTINCT Description FROM Categorie;

SELECT DISTINCT Pays FROM Client;

SELECT DISTINCT Pays,Ville FROM Client ORDER BY Pays ASC, Ville ASC;

Exo 5:
SELECT * FROM Produit WHERE QteParUnit LIKE '%canettes%' OR QteParUnit LIKE '%bouteilles%';

SELECT Societe, Contact, Ville FROM Fournisseur WHERE Pays = "France" ORDER BY Ville ASC;

SELECT Nomprod AS "Nom du Produit", NoFour AS "Identifiant du Fournisseur", QteParUnit AS "Quantité par unité", PrixUnit AS "Prix unitaire", UnitesStock AS "Unités en stock disponibles", UnitesCom AS "Unités Commandés", NiveauReap AS "Niveau Reapprovisionnement" FROM Produit WHERE NoFour = "8" AND PrixUnit BETWEEN 10 AND 100;

SELECT DISTINCT NoEmp AS "Numéro Employé" FROM Commande WHERE PaysLiv = "France" AND VilleLiv IN ("Lille","Lyon","Nantes") ORDER BY NoEmp ASC;

SELECT * FROM Produit WHERE (NomProd LIKE "%tofu%" OR NomProd LIKE "%choco%") AND PrixUnit < 100;


Chapitre 2

Exo 1 :
SELECT RefProd AS "Référence Produit", PrixUnit AS "Prix Unitaire", Qte AS "Quantité achetée", Remise AS "Remise", (PrixUnit*Qte)-((PrixUnit*Remise)*Qte) AS "Montant à Payer pour ce produit" FROM DetailCommande WHERE NoCom = "10251";

SELECT Adresse || " " || CodePostal || ", " || Ville || " " || Pays AS "Adresse Complète" FROM Client;

SELECT SUBSTR(CodeCli,3,2) AS "Dernier caractères" FROM Client;

SELECT LOWER(Societe) FROM Client;

SELECT Fonction,
    REPLACE(Fonction,"marketing","mercatique")
    AS "Fonction remplacée"
    FROM Client;

SELECT Fonction,
    INSTR(Fonction, "Chef")
    AS "La personne est-elle chef?"
    FROM Client;

Exo 3 :

SELECT DateCom,
       STRFTIME('%w', DateCom) AS "Jour de la semaine",
       STRFTIME('%W', DateCom) AS "Numéro de la semaine",
       STRFTIME('%m', DateCom) AS "Mois"
FROM Commande;

SELECT *,STRFTIME("%w", DateCom) as jour FROM Commande where jour = "0";

SELECT *,((STRFTIME('%s', ALivAvant) - STRFTIME('%s', DateCom))/86400) AS NbreJourRestantLivraison FROM Commande;

SELECT DateCom, DATE(DateCom, "+1 year", "+1 month", "+1 day") AS "Date de Contact"
    FROM Commande;

Exo 4 :

SELECT Refprod, Nomprod,
    CASE
        WHEN Indisponible = 1 THEN "Produit non disponible"
        ELSE "Produit Disponible"
    END AS "Disponibilité Produit"
FROM Produit;


SELECT *,
    CASE
        WHEN Remise = "0" THEN "Aucune remise"
        WHEN Remise BETWEEN 1 AND 5 THEN "Petite remise"
        WHEN Remise BETWEEN 6 AND 15 THEN "Remise modérée"
        ELSE "Remise Importante"
    END AS "Qualification Remise"
FROM DetailCommande;


SELECT NoCom, DateEnv, ALivAvant,
    CASE
        WHEN DateEnv >= ALivAvant THEN "Commande en retard"
        ELSE "Commande dans les temps"
    END AS "Etat Commande"
FROM Commande;

Exo 5 :

SELECT DateNaissance, DateEmbauche FROM Employe;

SELECT DateNaissance, DateEmbauche,
    (SUBSTR(DateEmbauche,6,4) - SUBSTR(DateNaissance,6,4)) AS AgeEmbauche,
    (STRFTIME("%Y", "now") - SUBSTR(DateEmbauche, 6, 4)) AS NbreAnnéeEnEntreprise
FROM Employe;

SELECT PrixUnit, Remise, PrixUnit-(PrixUnit*Remise) AS "Prix Unitaire avec remise", (PrixUnit*Remise) AS "Montant de la Remise" FROM DetailCommande WHERE Remise > 0.10 ;

SELECT DateCom, ALivAvant, DateEnv,
    ((STRFTIME("%s",DateEnv)-STRFTIME("%s",DateCom))/86400) AS "Délai d'envoi total",
    ((STRFTIME("%s",ALivAvant)-STRFTIME("%s",DateCom))/86400) AS "Délai d'envoi originel",
    ((STRFTIME("%s",DateEnv)-STRFTIME("%s",ALivAvant))/86400) AS "Nbre de jours en retard"
FROM Commande WHERE DateEnv > ALivAvant;

SELECT Societe,Contact FROM Client WHERE Societe LIKE "%"||Contact||"%";



Chapitre 3

Exo 1

1. SELECT COUNT(*)
    FROM Client
    WHERE Fonction = "Représentant(e)";

2. SELECT COUNT(*) 
    FROM Produit
    WHERE PrixUnit < 50;

3. SELECT COUNT(*) 
    FROM Produit
    WHERE UnitesStock > 10
    AND CodeCateg = 2;

4. SELECT COUNT(*) 
    FROM Produit
    WHERE (NoFour = 1 AND 18) 
    AND CodeCateg = 1;

5. SELECT COUNT(DISTINCT PaysLiv) 
    FROM Commande;

6. SELECT COUNT(*) AS "Nombre de commandes réalisées le 28/03/2016"
    FROM Commande
    WHERE STRFTIME('%Y-%m-%d', DateCom) = '2016-03-28';

Exo 2

1. SELECT AVG(Port) FROM Commande
    WHERE CodeCli LIKE "%QUICK%";

2. SELECT MIN(Port), MAX(Port) FROM Commande;

3. SELECT NoMess, SUM(Port) 
    FROM Commande 
    WHERE NoMess IN ("1", "2", "3")
    GROUP BY NoMess;

Exo 3

1. SELECT Fonction, COUNT(*)
    FROM Employe
    GROUP BY Fonction;

2. SELECT NoMess, AVG(Port)
    FROM Commande
    GROUP BY NoMess;

3. 