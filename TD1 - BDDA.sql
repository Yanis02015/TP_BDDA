-- Exo 1

CREATE TYPE compte_type AS OBJECT (
    nCompte VARCHAR2(50),
    solde int,
    dateOuv date,
    client VARCHAR2(50),
) NOT FINAL;

CREATE TYPE cptEpargne_type UNDER compte_type (
    txInteret DOUBLE(2,2)
);

CREATE TYPE cptCourant_type UNDER compte_type (
    nbOpCB int,
)

CREATE TYPE mouvement_type AS OBJECT (
    client int,
    cptCourant VARCHAR2(50),
    dateOp date,
    mountant int,
)

CREATE TYPE client_type AS OBJECT (
    num int,
    nom VARCHAR2(50),
    adresse VARCHAR2(50),
    numTel VARCHAR2(50),
)

CREATE TABLE Clients OF client_type (

)

CREATE TABLE Mouvements OF mouvement_type (
    
)

CREATE TABLE cptEpargne OF cptEpargne_type (
    
)

CREATE TABLE cptCourant OF cptCourant_type (
    
)

INSERT INTO Clients VALUES(1, 'Sadi', 'Farid', '+21377');
INSERT INTO Clients VALUES(2, 'Kaid', 'Imane', '+33416');
INSERT INTO Clients VALUES(3, 'Baloudl', 'Riad', '+13445');
INSERT INTO Clients VALUES(4, 'Adi', 'Nawel', '+21278');

INSERT INTO cptCourant VALUES('CC1', 4030, '01-02-2001', 1, 509);
INSERT INTO cptCourant VALUES('CC2', 3000, '01-02-2001', 1, 509);
INSERT INTO cptCourant VALUES('CC3', 460, '01-02-2001', 4, 509);
INSERT INTO cptCourant VALUES('CC4', 730, '01-02-2001', 4, 509);

INSERT INTO cptEpargne VALUES('CE1', 600, '05-02-1965', 2, 2.7);
INSERT INTO cptEpargne VALUES('CE2', 4500, '04-12-1998', 2, 2.9);
INSERT INTO cptEpargne VALUES('CE3', 500, '05-03-2000', 4, 2.9);
INSERT INTO cptEpargne VALUES('CE4', 3300, '23-08-1997', 3, 3.3);

INSERT INTO Mouvements VALUES(1, 'CC1', '05-03-2003', 100);
INSERT INTO Mouvements VALUES(1, 'CC1', '17-10-2005', -60);
INSERT INTO Mouvements VALUES(2, 'CC2', '12-11-2004', -50);
INSERT INTO Mouvements VALUES(4, 'CC4', '23-05-2007', 10);

SELECT cptCourant, COUNT(cptCourant) FROM Mouvements GROUP BY cptCourant;

-- Exo 2

CREATE TYPE adresse_type AS OBJECT(
    numRue int,
    nomRue VARCHAR2(50),
    nomVille VARCHAR2(50),
)

CREATE TYPE coordonnee_type AS OBJECT(
    adresse adresse_type,
    numTel VARCHAR2(50),
    email VARCHAR2(50),
)

CREATE TYPE personne_type AS OBJECT(
    numero int,
    nom VARCHAR2(50),
    prenom VARCHAR2(50),
    coordonnee coordonnee_type,
) NOT FINAL;

CREATE TYPE travailleur_type UNDER personne_type (
    salaire int,
)

CREATE TABLE Personnes OF personne_type(

)

INSERT INTO Personnes VALUES(personne_type(700, 'Poitier', 'Alain', coordonnee_type(adresse_type(2, 'rue Voltaire', 'Paris'), '+33770010203', 'palain@gmail.com')));
INSERT INTO Personnes VALUES(travailleur_type(800, 'Paul', 'Jean', coordonnee_type(adresse_type(3, 'Bd Gorge V', 'Bordeaux'), '+33663040506', 'pjean@gmail.com', 35000)));
INSERT INTO Personnes VALUES(travailleur_type(900, 'Andree', 'Lara', coordonnee_type(adresse_type(4, 'rue Ravat', 'Lyon'), NULL, NULL), 43000));

SELECT * FROM Personne WHERE (coordonnee.email IS NOT NULL) AND (coordonnee.numTel IS NOT NULL);

UPDATE Personne p SET p.coordonnee.adresse.numRue = 21, p.coordonnee.adresse.nomRue = 'allé Charles de Gaulle', p.coordonnee.adresse.nomVille = 'Montpellier' WHERE p.numero = 700;

SELECT nom, coordonnee.adresse.nomVille, coordonnee.numTel FROM Personne;

SELECT numero, nom, salaire FROM Personne p WHERE (salaire IS NOT NULL) AND (p.coordonnee.adresse.nomVille = 'PARIS' OR p.coordonnee.adresse.nomVille = 'Bordeaux')