-- Création de la base de données
DROP DATABASE IF EXISTS ExamenFinalFormatif_VersionCorrige;
CREATE DATABASE ExamenFinalFormatif_VersionCorrige;
USE ExamenFinalFormatif_VersionCorrige;


-- Création des tables


-- Table questionnaire
CREATE TABLE questionnaire (
	`id` INT auto_increment NOT NULL,
	`titre` varchar(50) NOT NULL,
	`description` varchar(255) NULL,
	`pointage_calcule` INT NULL,
	CONSTRAINT questionnaire_pk PRIMARY KEY (id)
);


-- Table type_question
CREATE TABLE type_question (
	`id` INT auto_increment NOT NULL,
	`nom` varchar(50) NULL,
	CONSTRAINT type_question_pk PRIMARY KEY (id)
);


-- Table question
CREATE TABLE question (
	`id` INT auto_increment NOT NULL,
	`questionnaire_id` INT NOT NULL,
	`type_question_id` INT NOT NULL,
	`texte_question` varchar(255) NULL,
	`obligatoire` TINYINT NULL,
	`ordre` INT NULL,
	`pointage` INT NULL,
	CONSTRAINT `question_pk` PRIMARY KEY (`id`),
	CONSTRAINT `questionnaire_FK` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire`(`id`),
	CONSTRAINT `type_question_FK` FOREIGN KEY (`type_question_id`) REFERENCES `type_question`(`id`)
);


-- Table question_choix
CREATE TABLE `question_choix` (
	`id` INT auto_increment NOT NULL,
	`question_id` INT NOT NULL,
	`texte_choix` varchar(50) NULL,
	`bonne_reponse` TINYINT NULL,
	`ordre` INT NULL,
	CONSTRAINT `question_choix_pk` PRIMARY KEY (`id`),
	CONSTRAINT `question_choix_FK` FOREIGN KEY (`question_id`) REFERENCES `question`(`id`)
);



-- Table question_texte_reponse
CREATE TABLE question_texte_reponse (
	id INT auto_increment NOT NULL,
	question_id INT NOT NULL,
	reponse varchar(255) NULL,
	CONSTRAINT question_texte_reponse_pk PRIMARY KEY (id),
	CONSTRAINT question_texte_reponse_FK FOREIGN KEY (question_id) REFERENCES question(id)
);


