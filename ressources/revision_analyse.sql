DROP DATABASE IF EXISTS bd2_garage;
CREATE DATABASE bd2_garage
COLLATE = 'utf8mb4_unicode_ci';

USE bd2_garage;

/**
 * Création des tables
 */
CREATE TABLE IF NOT EXISTS `client` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `code` VARCHAR(20) NOT NULL,
    `prenom` VARCHAR(30) NOT NULL,
    `nom` VARCHAR(30) NOT NULL,
    `adresse` VARCHAR(100) NULL,
    `ville` VARCHAR(50) NULL,
    `province` VARCHAR(50) NULL,
    `code_postal` VARCHAR(10) NULL,
    `tel_cellulaire` VARCHAR(20) NULL,
    `tel_travail` VARCHAR(20) NULL,
    `tel_maison` VARCHAR(20) NULL,
    `telecopieur` VARCHAR(20) NULL,
    `courriel` VARCHAR(255) NULL
);

CREATE TABLE IF NOT EXISTS `voiture` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `client_id` INT NOT NULL,
    `description` VARCHAR(100) NOT NULL,
    `plaque` VARCHAR(20) NULL
);

CREATE TABLE IF NOT EXISTS `facture` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
	`no_facture` INT NOT NULL,
    `client_id` INT NOT NULL,
    `voiture_id` INT NOT NULL,
    `date_facture` DATE NOT NULL,
    `terme_paiement_id` INT NOT NULL,
    `temps_arrive` DATETIME NOT NULL,
    `odo_entree` INT NOT NULL,
    `odo_auto` INT NOT NULL,
    `odo_sortie` INT NOT NULL,
    `tps_tvh` DECIMAL(8,2) NOT NULL,
    `tvq` DECIMAL(8,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS `terme_paiement` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `description` VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS `facture_paiement` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `facture_id` INT NOT NULL,
    `mode_paiement_id` INT NOT NULL,
    `montant` DECIMAL(8,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS `mode_paiement` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `description` VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `facture_detail` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `facture_id` INT NOT NULL,
    `ordre` INT NOT NULL,
    `produit_id` INT NULL,
    `quantite` DECIMAL(8,2) NULL,
    `prix_unitaire` DECIMAL(8,2) NULL,
    `message_ligne` VARCHAR(255) NULL
);

CREATE TABLE IF NOT EXISTS `produit` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `categorie_produit_id` INT NOT NULL,
    `code_produit` VARCHAR(20) NOT NULL,
    `description` VARCHAR(100) NOT NULL,
    `prix_unitaire` DECIMAL(8,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS `categorie_produit` (
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `description` VARCHAR(50) NOT NULL
);

/**
 * Ajout des clés étrangères
 */

ALTER TABLE `facture`
	ADD CONSTRAINT `client_id_fk` FOREIGN KEY (`client_id`) REFERENCES client (`id`) ON UPDATE RESTRICT ON DELETE CASCADE,
   	ADD CONSTRAINT `voiture_id_fk` FOREIGN KEY (`voiture_id`) REFERENCES voiture (`id`) ON UPDATE RESTRICT ON DELETE CASCADE,
   	ADD CONSTRAINT `terme_paiement_id_fk` FOREIGN KEY (`terme_paiement_id`) REFERENCES terme_paiement (`id`) ON UPDATE RESTRICT ON DELETE CASCADE;

ALTER TABLE `facture_paiement`
	ADD CONSTRAINT `facture_id_fk` FOREIGN KEY (`facture_id`) REFERENCES facture (`id`) ON UPDATE RESTRICT ON DELETE CASCADE,
	ADD CONSTRAINT `mode_paiement_id_fk` FOREIGN KEY (`mode_paiement_id`) REFERENCES mode_paiement (`id`) ON UPDATE RESTRICT ON DELETE CASCADE;

ALTER TABLE `facture_detail`
	ADD CONSTRAINT `factured_id_fk` FOREIGN KEY (`facture_id`) REFERENCES facture (`id`) ON UPDATE RESTRICT ON DELETE CASCADE,
	ADD CONSTRAINT `produit_id_fk` FOREIGN KEY (`produit_id`) REFERENCES produit (`id`) ON UPDATE RESTRICT ON DELETE CASCADE;
	
ALTER TABLE `produit`
	ADD CONSTRAINT `categorie_produit_id_fk` FOREIGN KEY (`categorie_produit_id`) REFERENCES categorie_produit (`id`) ON UPDATE RESTRICT ON DELETE CASCADE;

ALTER TABLE `voiture`
	ADD CONSTRAINT `clientv_id_fk` FOREIGN KEY (`client_id`) REFERENCES client (`id`) ON UPDATE RESTRICT ON DELETE CASCADE;

/**
 * Insertion des données
 */
INSERT INTO client (id, code, nom, prenom, adresse, ville, province, code_postal, tel_cellulaire, courriel)
VALUES (1, '2134521', 'Fréchette', 'Mathieu', '123 rue du cégep', 'Victoriaville', 'Québec', 'G0P1B0', '819-740-1111', 'frechette.mathieu@cegepvicto.ca');

INSERT INTO voiture (id, client_id, description)
VALUES (1, 1, '2011 Mazda 2 i.5 L 1498 CC L4 DOHC 16 Valve');

INSERT INTO terme_paiement(id, description)
VALUES (1, 'Net 30 JOURS'), (2, 'Net 60 JOURS');

INSERT INTO facture (id, no_facture, client_id, voiture_id, date_facture, terme_paiement_id, temps_arrive, odo_entree, odo_auto, odo_sortie, tps_tvh, tvq)
VALUES (1, 105036, 1, 1, '2020-10-21', 1, '2020-10-21 15:00', 238832, 238832, 238832, 31.79, 63.41);

INSERT INTO mode_paiement  (id, description)
VALUES (1, 'Visa'), (2, 'Debit'), (3, 'Comptant');

INSERT INTO facture_paiement (facture_id, mode_paiement_id, montant)
VALUES (1, 1, 730.92);

INSERT INTO categorie_produit (id, description)
VALUES (1, 'Pièces'), (2, 'M.O.'), (3, 'Autre');

INSERT INTO produit(id, categorie_produit_id, code_produit, description, prix_unitaire)
VALUES (1, 1, 'YOK 110115322', 'YOKO ICEGUARD IG53 82H 185/55R15', 139.93), 
	   (2, 2, '1PBN1', 'POSE + BALANCE PNEUS NEUF 29', 16.00),
	   (3, 3, 'TP', 'Taxe d\'environnement Pneus', 3.00);

INSERT INTO facture_detail (facture_id, ordre, produit_id, quantite, prix_unitaire, message_ligne)
VALUES (1, 1, NULL, NULL, NULL, 'REMETTRE PNEUS DANS L\'AUTO'),
	   (1, 2, 1, 4, 139.93, NULL),
	   (1, 3, 2, 4, 16.00, NULL),
	   (1, 4, 3, 4, 3.00, NULL),
	   (1, 5, NULL, NULL, NULL, 'N\'OUBLIEZ PAS LA ROTATION'),
	   (1, 6, NULL, NULL, NULL, 'L\'ALIGNEMENT EST RECOMMENDÉ');
