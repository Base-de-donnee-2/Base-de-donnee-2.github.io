-- 1. Usager citoyen alpha
-- a) Création de l'usager
CREATE USER IF NOT EXISTS 'mike'@'%' IDENTIFIED by '!alph2';
-- b) rôle
CREATE ROLE IF NOT EXISTS 'alpha';
-- c) Permissions
GRANT ALL ON credit_social.* to 'alpha';
GRANT GRANT OPTION ON credit_social.* to 'alpha';
GRANT CREATE USER ON *.* to 'alpha';
-- d)
GRANT 'alpha' TO 'mike';
SET DEFAULT ROLE 'alpha' FOR 'mike';
-- e) Tests
-- SELECT * FROM bd2_ex10.houblon;
-- ERROR 1142 (42000): SELECT command denied to user 'mike'@'172.16.238.10' for table `bd2_ex10`.`houblon`
-- oui

-- 2. Usager citoyen beta
-- a) Création de l'usager
CREATE USER IF NOT EXISTS 'john'@'%' IDENTIFIED by '!b3ta';
-- b) rôle
CREATE ROLE IF NOT EXISTS 'beta';
-- c) Permissions
GRANT SELECT, UPDATE, INSERT ON credit_social.citoyen TO 'beta';
GRANT SELECT, UPDATE, INSERT ON credit_social.evenement TO 'beta';
GRANT EXECUTE ON credit_social.* TO 'beta';
-- d)
GRANT 'beta' TO 'john';
SET DEFAULT ROLE 'beta' FOR 'john';
-- e) Tests
/*
DELETE FROM credit_social.evenement WHERE id = 6;
ERROR 1142 (42000): DELETE command denied to user 'john'@'172.16.238.10' for table `credit_social`.`evenement`

call participation_evenement(123);

UPDATE citoyen SET credit_initial = 800 WHERE id = 2107;
SELECT credit_initial FROM citoyen WHERE id = 2107;
*/

-- 3. Usager citoyen gamma
-- a) Création de l'usager
CREATE USER IF NOT EXISTS bob IDENTIFIED by '!g2mm2';
-- b) rôle
CREATE ROLE IF NOT EXISTS 'gamma';
-- c) Permissions
GRANT SELECT (nom, prenom, pin) ON credit_social.citoyen TO 'gamma';
GRANT EXECUTE ON PROCEDURE credit_social.update_classe TO 'gamma';
-- d)
GRANT 'gamma' TO 'bob';
SET DEFAULT ROLE 'gamma' FOR 'bob';
-- e) Tests
/*
SELECT nom, prenom FROM credit_social.citoyen WHERE id = 1111;
Non, car l'usager n'a pas accès à la colonne id de la table citoyen.
ERROR 1143 (42000): SELECT command denied to user 'bob'@'172.16.238.10' for column 'id' in table 'citoyen'

Depuis l'usager root: 
GRANT SELECT (id) ON credit_social.citoyen TO gamma;

Depuis l'usager root: 
CREATE VIEW credit_social.citoyen_classe AS select c.nom, c.prenom , c.pin, cl.titre AS classe FROM credit_social.citoyen c INNER JOIN credit_social.classe cl ON cl.id = c.classe_id;
GRANT select ON credit_social.citoyen_classe TO gamma;

SELECT * FROM credit_social.citoyen_classe WHERE pin = '39c0cf42-510c-4811-8c3c-47ab100443ce';
Jack Stevenson
*/
