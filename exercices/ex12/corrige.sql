-- 1. Usager citoyen alpha
-- a) Création de l'usager
create user 'citoyen_alpha'@'%' IDENTIFIED by '!alph2';
-- b) Permissions
grant all on credit_social.* to 'citoyen_alpha'@'%';
grant grant option ON credit_social.* to 'citoyen_alpha'@'%';
grant create user ON credit_social.* to 'citoyen_alpha'@'%';
-- c) Tests
-- ERROR 1142 (42000): SELECT command denied to user 'citoyen_alpha'@'localhost' for table 'epreuve'
-- oui

-- 2. Usager citoyen beta
-- a) Création de l'usager
create user 'citoyen_beta'@'localhost' IDENTIFIED by '!b3ta';
-- b) Permissions
grant select, update, insert on credit_social.citoyen to 'citoyen_beta'@'localhost';
grant select, update, insert on credit_social.evenement to 'citoyen_beta'@'localhost';
grant execute on credit_social.* to 'citoyen_beta'@'localhost';
-- c) Tests
/*
delete from evenement where id = 6;
ERROR 1142 (42000): DELETE command denied to user 'citoyen_beta'@'localhost' for table 'evenement'

call participation_evenement(123);

update citoyen set credit_initial = 800 where id = 2107;
*/

-- 3. Usager citoyen gamma
-- a) Création de l'usager
create user 'citoyen_gamma'@'localhost' IDENTIFIED by '!g2mm2';
-- b) Permissions
grant select (nom, prenom, pin) on credit_social.citoyen to 'citoyen_gamma'@'localhost';
grant execute on procedure credit_social.update_classe to 'citoyen_gamma'@'localhost';
-- c) Tests
/*
Non, car l'usager n'a pas accès à la colonne id de la table citoyen.

Depuis l'usager root: 
grant select (id) on credit_social.citoyen to citoyen_gamma@localhost;

Depuis l'usager root: 
create view citoyen_classe as select c.nom, c.prenom , c.pin, cl.titre as classe from credit_social.citoyen c inner join credit_social.classe cl on cl.id = c.classe_id;
grant select on credit_social.citoyen_classe to citoyen_gamma@localhost;

select * from citoyen_classe where pin = '39c0cf42-510c-4811-8c3c-47ab100443ce';
Jack Stevenson
*/
