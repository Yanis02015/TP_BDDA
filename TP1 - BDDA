CREATE TYPE adresse_type AS OBJECT (
    numeroRue int,
    nomRue VARCHAR2(50),
    codePostal VARCHAR2(50),
    ville VARCHAR2(50),
) NOT FINAL;

CREATE TYPE adresseWithEmail_type UNDER adresse_type (
    adresseEmail VARCHAR2(50),
);

CREATE TYPE personne_type AS OBJECT (
    numero VARCHAR2(50),
    nom VARCHAR2(50),
    prenom VARCHAR2(50),
    adresse adresse_type,
    age int,
) NOT FINAL;

CREATE TYPE etudiant_type UNDER personne_type (
    numCarteEtudiant VARCHAR2(50),
    anneeInscription VARCHAR2(50),
)

CREATE TYPE enseignant_type UNDER personne_type (
    grade VARCHAR2(50),
)

CREATE TABLE Personne OF personne_type (
    CONSTRAINT pk_personne PRIMARY KEY(numero),
    CONSTRAINT c_age CHECK (age BETWEEN 17 AND 60),
)

INSERT INTO Personne VALUES (personne_type(100, 'KADI', 'Sonia', adresse_type(5, 'BENBOUALI Hassiba Béjaia', '06000'), 30));
INSERT INTO Personne VALUES (enseignant_type('ENS-2010', 'ZAIDI', 'Kamel', adresseWithEmail_type(12, 'DIDOUCHE Mourad Sétif', '19000', 'kzaidi@gmail.com'), 42, 'Proffesseur des universités'));
INSERT INTO Personne VALUES (etudiant_type('MI-2017-100', 'SALMA', 'Nabil', adresseWithEmail_type(10, 'boulevard KRIM Belkacem Alger', '16000', 'nselmi@gmail.com'), 19, 'MI-100', '2018'));

SELECT * FROM Personne;
SELECT VALUES(Personne);
SELECT numero, nom, prenom, adresse.adresseEmail FROM Personne;
SELECT numero, nom, prenom, grade FROM Personne WHERE Personne IS OF (enseignant_type); -- WHERE grade IS NOT NULL;
SELECT numero, nom, prenom, numCarteEtudiant, anneeInscription FROM Personne WHERE numCarteEtudiant IS NOT NULL;

SELECT * FROM Personne WHERE Personne IS NOT OF (enseignant_type) AND Personne IS NOT OF (etudiant_type);