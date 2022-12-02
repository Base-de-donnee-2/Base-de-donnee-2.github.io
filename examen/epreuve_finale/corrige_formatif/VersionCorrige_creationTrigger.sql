USE ExamenFinalFormatif_VersionCorrige;

DROP TRIGGER IF EXISTS after_insert_question;
DROP TRIGGER IF EXISTS after_update_question;
DROP TRIGGER IF EXISTS after_delete_question;


DELIMITER $$
$$
CREATE TRIGGER `after_insert_question` 
AFTER INSERT 
ON `question` 
FOR EACH ROW 
begin 

	if (new.pointage is not null) then
	
		update questionnaire 
		set pointage_calcule = ifnull(pointage_calcule, 0) + new.pointage 
		where id = NEW.questionnaire_id;
	
	end if;
	
end$$
DELIMITER ;


DELIMITER $$
$$
CREATE TRIGGER `after_update_question` 
AFTER UPDATE 
ON `question` 
FOR EACH ROW 
begin 

	if (new.pointage is not null) then
	
		update questionnaire 
		set pointage_calcule = ifnull(pointage_calcule, 0) + new.pointage 
		where id = NEW.questionnaire_id;
	
	end if;	
	
end$$
DELIMITER ;


DELIMITER $$
$$
CREATE TRIGGER after_delete_question
AFTER DELETE
ON question FOR EACH ROW
begin 
	if (old.pointage is not null) then
	
		update questionnaire 
		set pointage_calcule = ifnull(pointage_calcule, 0) - old.pointage 
		where id = old.questionnaire_id;
	
	end if;	
end$$
DELIMITER ;


