-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.22-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Copiando estrutura para tabela creativev4.gregos_members
CREATE TABLE IF NOT EXISTS `shark_gm_members` (
	`user_id` INT(11) NOT NULL,
	`name` VARCHAR(55) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`cargo` VARCHAR(55) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`status` VARCHAR(3) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`organization` VARCHAR(55) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`login` INT(11) NULL DEFAULT '0',
	PRIMARY KEY (`user_id`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela creativev4.gregos_organizacao
CREATE TABLE IF NOT EXISTS `shark_gm_organization` (
	`organization` VARCHAR(55) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`mensagem` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`membros` VARCHAR(10) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci'
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `shark_gm_blacklist` (
	`id` INT(10) NULL DEFAULT NULL,
	`blacklist` INT(20) NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- Exportação de dados foi desmarcado.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
