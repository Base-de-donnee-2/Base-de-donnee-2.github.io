use examenfinalformatif_versioncorrige;

-- Création de l'usager
create user 'correcteur'@'localhost' IDENTIFIED by '!3ct3Ur';
-- Permissions
grant SELECT, UPDATE on examenfinal_versioncorrige.* to 'correcteur'@'localhost';
grant SELECT, UPDATE (`id`, `titre`, `description`) on examenfinal_versioncorrige.questionnaire to 'correcteur'@'localhost';