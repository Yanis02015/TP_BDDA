CREATE TYPE salle_type AS OBJECT (
    numero VARCHAR2(20),
    videopr CHAR(1)
) NOT FINAL;

CREATE TYPE salle_cours_type UNDER salle_type (
    capacite NUMBER(3),
    retropro CHAR(1),
    micro CHAR(1)
);

CREATE TYPE salle_info_type UNDER salle_type (
    nb_ordi NUMBER(2),
    OS VARCHAR2(20)
);

CREATE TYPE ensm_type AS OBJECT (
    code VARCHAR2(20),
    effectif NUMBER(3),
    videopr CHAR(1)
) NOT FINAL;

CREATE TYPE cr_type UNDER ensm_type (
    retropro CHAR(1)
);

CREATE TYPE td_type UNDER ensm_type (
    machine CHAR(1)
);

CREATE TYPE pgEnseignant_type AS OBJECT (
    ref_ensm ref ensm_type,
    ref_salle ref salle_type,
    jour VARCHAR2(10),
    heure_debut NUMBER(4,1),
    heure_fin NUMBER(4,1)
);

CREATE TABLE salle OF salle_type (
    CONSTRAINT pk_numero PRIMARY KEY(numero)
);

CREATE TABLE ensm OF ensm_type (
    CONSTRAINT pk_code PRIMARY KEY(code)
);

CREATE TABLE pg_ensm OF pgEnseignant_type (
    CONSTRAINT nn_ref_salle CHECK (ref_salle IS NOT NULL),
    CONSTRAINT fk_ref_salle ref_salle REFERENCES salle,
    CONSTRAINT nn_ref_ensm CHECK (ref_ensm IS NOT NULL),
    CONSTRAINT fk_ref_ensm ref_ensm REFERENCES ensm
);

INSERT INTO ensm VALUES(cr_type('BDDA', 250, 'O', 'N'));

INSERT INTO salle VALUES(salle_cours_type('B8S22', 'N', 300, 'O', 'N'));

INSERT  INTO pg_ensm VALUES( (SELECT REF(e) FROM ensm e WHERE e.CODE = 'BDDA'), (SELECT REF(p) FROM salle p WHERE p.NUMERO = 'B8S22'), 'Dimanche', 8.0, 9.3);

SELECT p.ref_ensm.code, p.ref_salle.numero FROM pg_ensm p WHERE p.ref_ensm.videopr = 'O' AND p.ref_salle.videopr = 'N';

SELECT DISTINCT(COUNT(p.ref_ensm.code)), p.ref_salle.numero
FROM pg_ensm p
GROUP BY (p.ref_salle.numero);

SELECT TREAT(p.ref_salle as REF salle_cours_type).capacite AS "CAPACITÉ"
FROM pg_ensm p
WHERE p.jour = "Dimanche";