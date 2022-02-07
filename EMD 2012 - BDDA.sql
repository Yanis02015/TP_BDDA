CREATE TYPE moteur_type AS OBJECT (
    nom VARCHAR2(50),
    numero NUMBER,
    model VARCHAR2(50)
)

CREATE TYPE roue_type AS OBJECT (
    nom VARCHAR2(50),
    num NUMBER,
    marque VARCHAR2(50),
    model VARCHAR2(50)
)

CREATE TYPE modelAvion_type AS OBJECT (
    nom VARCHAR2(50),
    moteur ref moteur_type,
    roue ref roue_type
)

CREATE TABLE EnsModeleRoue OF roue_type (
    nom VARCHAR2(50)
)

CREATE TABLE EnsModeleMoteur OF moteur_type (
    nom VARCHAR2(50)
)

CREATE TABLE EnsModeleAvion OF avion_type (
    nom VARCHAR2(50)
)

CREATE TYPE avion_type AS OBJECT (
    num NUMBER,
    model ref modelAvion_type,
)

CREATE TABLE EnsAvion OF avion_type (
    CONSTRAINT fk_ref_avion
)