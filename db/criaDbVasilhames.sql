CREATE DATABASE IF NOT EXISTS `vasilhames`;

USE vasilhames;

CREATE TABLE `clientes` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`nome_razao` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`apelido_fantasia` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`documento` VARCHAR(14) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`rua` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`numero` VARCHAR(15) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`bairro` VARCHAR(64) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`cidade` VARCHAR(30) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`uf` CHAR(2) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`cep` VARCHAR(9) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`telefone` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`u_data` TIMESTAMP NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=56
;

CREATE TABLE `dados_empresa` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`cnpj` VARCHAR(20) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`fantasia` VARCHAR(64) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`razao_social` VARCHAR(64) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`ie` VARCHAR(12) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`endereco` VARCHAR(128) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`cidade` VARCHAR(64) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`uf` CHAR(2) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`telefone` VARCHAR(17) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`email` VARCHAR(64) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`logo` VARCHAR(128) NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=12
;

CREATE TABLE `ent_rec` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`vasilhame` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`cliente` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`quantidade_entregue` INT(11) NULL DEFAULT '0',
	`quantidade_recebida` INT(11) NULL DEFAULT '0',
	`quantidade_debito` INT(11) NULL DEFAULT '0',
	`bonus` CHAR(1) NULL DEFAULT 'N' COLLATE 'utf8mb4_general_ci',
	`u_data` TIMESTAMP NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=192
;

CREATE TABLE `recebimento_vasilhames` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`cliente` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`vasilhame` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`quantidade` INT(11) NULL DEFAULT NULL,
	`u_data` TIMESTAMP NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE
)
COMMENT='usado somente para o termo de devolução, dados divergentes da tabela ent_rec'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=124
;

CREATE TABLE `vasilhames` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`descricao` VARCHAR(128) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`marca` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`quantidade` INT(11) NULL DEFAULT NULL,
	`quantidade_a_rec` INT(11) NULL DEFAULT '0',
	`capacidade` INT(11) NULL DEFAULT NULL,
	`u_data` TIMESTAMP NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=31
;
