-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema wispbillv2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema wispbillv2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wispbillv2` DEFAULT CHARACTER SET utf8 ;
USE `wispbillv2` ;

-- -----------------------------------------------------
-- Table `wispbillv2`.`customer_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`customer_users` (
  `idcustomer_users` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `username` VARCHAR(255) NOT NULL COMMENT '',
  `password` VARCHAR(255) NOT NULL COMMENT '',
  `email` VARCHAR(255) NOT NULL COMMENT '',
  `stripeid` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idcustomer_users`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `wispbillv2`.`customer_plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`customer_plans` (
  `idcustomer_plans` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(255) NOT NULL COMMENT '',
  `max_bandwith_up_kilo` INT(11) NOT NULL COMMENT '',
  `max_bandwith_down_kilo` INT(11) NOT NULL COMMENT '',
  `price` TINYINT(4) NOT NULL COMMENT '',
  PRIMARY KEY (`idcustomer_plans`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `wispbillv2`.`contacts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`contacts` (
  `idcontacts` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `fname` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `lname` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `email` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `phone` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `org` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `address` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `city` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `state` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `zip` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idcontacts`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`location` (
  `idlocation` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `latitude` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `longitude` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `type` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `contacts_idcontacts` INT(11) NOT NULL COMMENT '',
  `ifconfig` VARCHAR(5) NOT NULL COMMENT '',
  `coverage` TEXT NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idlocation`)  COMMENT '',
  INDEX `fk_location_contacts1_idx` (`contacts_idcontacts` ASC)  COMMENT '',
  CONSTRAINT `fk_location_contacts1`
    FOREIGN KEY (`contacts_idcontacts`)
    REFERENCES `wispbillv2`.`contacts` (`idcontacts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`devices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`devices` (
  `iddevices` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `location_idlocation` INT(11) NULL DEFAULT NULL COMMENT '',
  `name` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `serial_number` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `manufacturer` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `model` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `type` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `librenms_id` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `field_status` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `mac` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`iddevices`)  COMMENT '',
  INDEX `fk_devices_location1_idx` (`location_idlocation` ASC)  COMMENT '',
  CONSTRAINT `fk_devices_location1`
    FOREIGN KEY (`location_idlocation`)
    REFERENCES `wispbillv2`.`location` (`idlocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`device_ports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`device_ports` (
  `iddevice_ports` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `port id` INT(11) NULL DEFAULT NULL COMMENT '',
  `use` VARCHAR(45) NOT NULL COMMENT '',
  `devices_iddevices` INT(11) NOT NULL COMMENT '',
  `name` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `ip_address` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `network` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `mac` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `desc` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`iddevice_ports`)  COMMENT '',
  INDEX `fk_device_ports_devices1_idx` (`devices_iddevices` ASC)  COMMENT '',
  CONSTRAINT `fk_device_ports_devices1`
    FOREIGN KEY (`devices_iddevices`)
    REFERENCES `wispbillv2`.`devices` (`iddevices`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 38
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`dhcp_servers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`dhcp_servers` (
  `idDHCP_Servers` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `DNS` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `Range_Start` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `Range_Stop` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `subnet` VARCHAR(45) NOT NULL COMMENT '',
  `name` VARCHAR(45) NOT NULL COMMENT '',
  `device_ports_iddevice_ports` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`idDHCP_Servers`)  COMMENT '',
  INDEX `fk_DHCP_Servers_device_ports1_idx` (`device_ports_iddevice_ports` ASC)  COMMENT '',
  CONSTRAINT `fk_DHCP_Servers_device_ports1`
    FOREIGN KEY (`device_ports_iddevice_ports`)
    REFERENCES `wispbillv2`.`device_ports` (`iddevice_ports`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`static_leases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`static_leases` (
  `idstatic_leases` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `ip` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `mac` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `DHCP_Servers_idDHCP_Servers` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`idstatic_leases`)  COMMENT '',
  INDEX `fk_static_leases_DHCP_Servers1_idx` (`DHCP_Servers_idDHCP_Servers` ASC)  COMMENT '',
  CONSTRAINT `fk_static_leases_DHCP_Servers1`
    FOREIGN KEY (`DHCP_Servers_idDHCP_Servers`)
    REFERENCES `wispbillv2`.`dhcp_servers` (`idDHCP_Servers`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`customer_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`customer_info` (
  `idcustomer_info` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `idcustomer_users` INT(11) NULL DEFAULT NULL COMMENT '',
  `idcustomer_plans` INT(11) NULL DEFAULT NULL COMMENT '',
  `devices_iddevices` INT(11) NULL DEFAULT NULL COMMENT '',
  `static_leases_idstatic_leases` INT(11) NULL DEFAULT NULL COMMENT '',
  `fname` VARCHAR(255) NOT NULL COMMENT '',
  `lname` VARCHAR(255) NOT NULL COMMENT '',
  `phone` VARCHAR(255) NOT NULL COMMENT '',
  `address` VARCHAR(255) NOT NULL COMMENT '',
  `city` VARCHAR(255) NOT NULL COMMENT '',
  `zip_code` VARCHAR(255) NOT NULL COMMENT '',
  `state` VARCHAR(255) NOT NULL COMMENT '',
  `email` VARCHAR(255) NOT NULL COMMENT '',
  `lat` VARCHAR(10) NULL DEFAULT NULL COMMENT '',
  `lon` VARCHAR(10) NULL DEFAULT NULL COMMENT '',
  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `source` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idcustomer_info`)  COMMENT '',
  UNIQUE INDEX `idcustomer_users` (`idcustomer_users` ASC, `idcustomer_plans` ASC)  COMMENT '',
  INDEX `idcustomer_plans` (`idcustomer_plans` ASC)  COMMENT '',
  INDEX `fk_customer_info_devices1_idx` (`devices_iddevices` ASC)  COMMENT '',
  INDEX `fk_customer_info_static_leases1_idx` (`static_leases_idstatic_leases` ASC)  COMMENT '',
  CONSTRAINT `customer_info_ibfk_1`
    FOREIGN KEY (`idcustomer_users`)
    REFERENCES `wispbillv2`.`customer_users` (`idcustomer_users`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `customer_info_ibfk_2`
    FOREIGN KEY (`idcustomer_plans`)
    REFERENCES `wispbillv2`.`customer_plans` (`idcustomer_plans`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_info_devices1`
    FOREIGN KEY (`devices_iddevices`)
    REFERENCES `wispbillv2`.`devices` (`iddevices`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_info_static_leases1`
    FOREIGN KEY (`static_leases_idstatic_leases`)
    REFERENCES `wispbillv2`.`static_leases` (`idstatic_leases`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `wispbillv2`.`firewall`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`firewall` (
  `idfirewall` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `default_action` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `description` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `reject_rule` INT(11) NULL DEFAULT NULL COMMENT '',
  `device_ports_iddevice_ports` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`idfirewall`)  COMMENT '',
  INDEX `fk_firewall_device_ports1_idx` (`device_ports_iddevice_ports` ASC)  COMMENT '',
  CONSTRAINT `fk_firewall_device_ports1`
    FOREIGN KEY (`device_ports_iddevice_ports`)
    REFERENCES `wispbillv2`.`device_ports` (`iddevice_ports`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`Firewall_Rules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`Firewall_Rules` (
  `idACL` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `rule_number` INT(11) NULL DEFAULT NULL COMMENT '',
  `mac` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `firewall_idfirewall` INT(11) NOT NULL COMMENT '',
  `customer_info_idcustomer_info` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`idACL`)  COMMENT '',
  INDEX `fk_ACL_firewall1_idx` (`firewall_idfirewall` ASC)  COMMENT '',
  INDEX `fk_ACL_customer_info1_idx` (`customer_info_idcustomer_info` ASC)  COMMENT '',
  CONSTRAINT `fk_ACL_customer_info1`
    FOREIGN KEY (`customer_info_idcustomer_info`)
    REFERENCES `wispbillv2`.`customer_info` (`idcustomer_info`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ACL_firewall1`
    FOREIGN KEY (`firewall_idfirewall`)
    REFERENCES `wispbillv2`.`firewall` (`idfirewall`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`admin_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`admin_users` (
  `idadmin` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `username` VARCHAR(255) NOT NULL COMMENT '',
  `password` VARCHAR(255) NOT NULL COMMENT '',
  `email` VARCHAR(255) NOT NULL COMMENT '',
  `fname` VARCHAR(45) NOT NULL COMMENT '',
  `lname` VARCHAR(45) NOT NULL COMMENT '',
  `hometel` VARCHAR(45) NOT NULL COMMENT '',
  `celltel` VARCHAR(45) NOT NULL COMMENT '',
  `img` TEXT NOT NULL COMMENT '',
  `privilege` TINYINT(4) NOT NULL COMMENT '',
  PRIMARY KEY (`idadmin`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `wispbillv2`.`contact_notes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`contact_notes` (
  `idcontact_notes` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `note` MEDIUMTEXT NULL DEFAULT NULL COMMENT '',
  `date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `contacts_idcontacts` INT(11) NOT NULL COMMENT '',
  `admin_users_idadmin` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`idcontact_notes`)  COMMENT '',
  INDEX `fk_contact_notes_contacts1_idx` (`contacts_idcontacts` ASC)  COMMENT '',
  INDEX `fk_contact_notes_admin_users1_idx` (`admin_users_idadmin` ASC)  COMMENT '',
  CONSTRAINT `fk_contact_notes_admin_users1`
    FOREIGN KEY (`admin_users_idadmin`)
    REFERENCES `wispbillv2`.`admin_users` (`idadmin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_notes_contacts1`
    FOREIGN KEY (`contacts_idcontacts`)
    REFERENCES `wispbillv2`.`contacts` (`idcontacts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`cpe_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`cpe_data` (
  `frequency` DECIMAL(10,3) NULL DEFAULT NULL COMMENT '',
  `txpower` INT(11) NULL DEFAULT NULL COMMENT '',
  `signallev` INT(11) NULL DEFAULT NULL COMMENT '',
  `noise` INT(11) NULL DEFAULT NULL COMMENT '',
  `ccq` INT(11) NULL DEFAULT NULL COMMENT '',
  `latency` INT(11) NULL DEFAULT NULL COMMENT '',
  `rxbtyes` BIGINT(20) NULL DEFAULT NULL COMMENT '',
  `txbtyes` BIGINT(20) NULL DEFAULT NULL COMMENT '',
  `rxrate` INT(11) NULL DEFAULT NULL COMMENT '',
  `txrate` INT(11) NULL DEFAULT NULL COMMENT '',
  `datetime` BIGINT(20) NULL DEFAULT NULL COMMENT '',
  `idcpedata` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `devices_iddevices` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`idcpedata`, `devices_iddevices`)  COMMENT '',
  UNIQUE INDEX `Time` (`datetime` ASC)  COMMENT '',
  INDEX `fk_cpe_data_devices1_idx` (`devices_iddevices` ASC)  COMMENT '',
  CONSTRAINT `fk_cpe_data_devices1`
    FOREIGN KEY (`devices_iddevices`)
    REFERENCES `wispbillv2`.`devices` (`iddevices`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 23350
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`customer_external`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`customer_external` (
  `customer_info_idcustomer_info` INT(11) NOT NULL COMMENT '',
  `billing` INT(11) NULL DEFAULT NULL COMMENT '',
  `communication_preferences` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `billing_mode` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`customer_info_idcustomer_info`)  COMMENT '',
  CONSTRAINT `fk_customer_external_customer_info1`
    FOREIGN KEY (`customer_info_idcustomer_info`)
    REFERENCES `wispbillv2`.`customer_info` (`idcustomer_info`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`device_credentials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`device_credentials` (
  `devices_iddevices` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `username` VARCHAR(45) NULL DEFAULT '0' COMMENT '',
  `password` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `IV` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`devices_iddevices`)  COMMENT '',
  CONSTRAINT `fk_device_credentials_devices1`
    FOREIGN KEY (`devices_iddevices`)
    REFERENCES `wispbillv2`.`devices` (`iddevices`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`ticket` (
  `idticket` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `issue` MEDIUMTEXT NULL DEFAULT NULL COMMENT '',
  `status` TINYINT(1) NULL DEFAULT NULL COMMENT '',
  `admin_users_idadmin` INT(11) NOT NULL COMMENT '',
  `customer_info_idcustomer_info` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`idticket`)  COMMENT '',
  INDEX `fk_ticket_admin_users1_idx` (`admin_users_idadmin` ASC)  COMMENT '',
  INDEX `fk_ticket_customer_info1_idx` (`customer_info_idcustomer_info` ASC)  COMMENT '',
  CONSTRAINT `fk_ticket_admin_users1`
    FOREIGN KEY (`admin_users_idadmin`)
    REFERENCES `wispbillv2`.`admin_users` (`idadmin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_customer_info1`
    FOREIGN KEY (`customer_info_idcustomer_info`)
    REFERENCES `wispbillv2`.`customer_info` (`idcustomer_info`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`history` (
  `idhistory` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `event` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `date` BIGINT(20) NULL DEFAULT NULL COMMENT '',
  `admin_users_idadmin` INT(11) NOT NULL COMMENT '',
  `customer_info_idcustomer_info` INT(11) NOT NULL COMMENT '',
  `ticket_idticket` INT(11) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idhistory`)  COMMENT '',
  INDEX `fk_history_admin_users1_idx` (`admin_users_idadmin` ASC)  COMMENT '',
  INDEX `fk_history_customer_info1_idx` (`customer_info_idcustomer_info` ASC)  COMMENT '',
  INDEX `fk_history_ticket1_idx` (`ticket_idticket` ASC)  COMMENT '',
  CONSTRAINT `fk_history_admin_users1`
    FOREIGN KEY (`admin_users_idadmin`)
    REFERENCES `wispbillv2`.`admin_users` (`idadmin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_history_customer_info1`
    FOREIGN KEY (`customer_info_idcustomer_info`)
    REFERENCES `wispbillv2`.`customer_info` (`idcustomer_info`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `history_ibfk_1`
    FOREIGN KEY (`ticket_idticket`)
    REFERENCES `wispbillv2`.`ticket` (`idticket`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`notifications` (
  `idnotifications` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `readyn` TINYINT(1) NULL DEFAULT NULL COMMENT '',
  `content` MEDIUMTEXT NULL DEFAULT NULL COMMENT '',
  `date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `fromwho` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `towho` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idnotifications`)  COMMENT '',
  INDEX `Read Status` (`readyn` ASC)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 108
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`port_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`port_data` (
  `idport_data` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `txbytes` BIGINT(45) NULL DEFAULT NULL COMMENT '',
  `rxbytes` BIGINT(45) NULL DEFAULT NULL COMMENT '',
  `txrate` BIGINT(45) NULL DEFAULT NULL COMMENT '',
  `rxrate` BIGINT(45) NULL DEFAULT NULL COMMENT '',
  `time` BIGINT(45) NULL DEFAULT NULL COMMENT '',
  `device_ports_iddevice_ports` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`idport_data`, `device_ports_iddevice_ports`)  COMMENT '',
  INDEX `fk_port_data_device_ports1_idx` (`device_ports_iddevice_ports` ASC)  COMMENT '',
  INDEX `Time` (`time` ASC)  COMMENT '',
  CONSTRAINT `fk_port_data_device_ports1`
    FOREIGN KEY (`device_ports_iddevice_ports`)
    REFERENCES `wispbillv2`.`device_ports` (`iddevice_ports`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 41598
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`tasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`tasks` (
  `idtasks` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `task` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `start_date_time` BIGINT(20) NULL DEFAULT NULL COMMENT '',
  `end_date_time` BIGINT(20) NULL DEFAULT NULL COMMENT '',
  `real_start_date_time` BIGINT(20) NULL DEFAULT NULL COMMENT '',
  `real_end_date_time` BIGINT(20) NULL DEFAULT NULL COMMENT '',
  `task_length` BIGINT(20) NULL DEFAULT NULL COMMENT '',
  `admin_users_idadmin` INT(11) NOT NULL COMMENT '',
  `ticket_idticket` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`idtasks`)  COMMENT '',
  INDEX `fk_tasks_admin_users1_idx` (`admin_users_idadmin` ASC)  COMMENT '',
  INDEX `fk_tasks_ticket1_idx` (`ticket_idticket` ASC)  COMMENT '',
  INDEX `Datetime` (`start_date_time` ASC, `real_start_date_time` ASC, `real_end_date_time` ASC)  COMMENT '',
  CONSTRAINT `fk_tasks_admin_users1`
    FOREIGN KEY (`admin_users_idadmin`)
    REFERENCES `wispbillv2`.`admin_users` (`idadmin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tasks_ticket1`
    FOREIGN KEY (`ticket_idticket`)
    REFERENCES `wispbillv2`.`ticket` (`idticket`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wispbillv2`.`ticket_notes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wispbillv2`.`ticket_notes` (
  `ticket_idticket` INT(11) NOT NULL COMMENT '',
  `note` MEDIUMTEXT NULL DEFAULT NULL COMMENT '',
  `date` BIGINT(20) NULL DEFAULT NULL COMMENT '',
  `admin_users_idadmin` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`ticket_idticket`)  COMMENT '',
  INDEX `fk_ticket_notes_admin_users1_idx` (`admin_users_idadmin` ASC)  COMMENT '',
  CONSTRAINT `fk_ticket_notes_admin_users1`
    FOREIGN KEY (`admin_users_idadmin`)
    REFERENCES `wispbillv2`.`admin_users` (`idadmin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ticket_notes_ibfk_1`
    FOREIGN KEY (`ticket_idticket`)
    REFERENCES `wispbillv2`.`ticket` (`idticket`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


