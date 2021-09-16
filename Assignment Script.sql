-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Inventories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Inventories` (
  `inventory_id` INT NOT NULL,
  `code` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`inventory_id`),
  UNIQUE INDEX `inventory_id_UNIQUE` (`inventory_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Part Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Part Categories` (
  `category_id` INT NOT NULL,
  `category_name` VARCHAR(45) NOT NULL,
  `Inventories_inventory_id` INT NOT NULL,
  PRIMARY KEY (`category_id`, `Inventories_inventory_id`),
  UNIQUE INDEX `category_id_UNIQUE` (`category_id` ASC) VISIBLE,
  UNIQUE INDEX `category_name_UNIQUE` (`category_name` ASC) VISIBLE,
  INDEX `fk_Part Categories_Inventories1_idx` (`Inventories_inventory_id` ASC) VISIBLE,
  CONSTRAINT `fk_Part Categories_Inventories1`
    FOREIGN KEY (`Inventories_inventory_id`)
    REFERENCES `mydb`.`Inventories` (`inventory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Colours`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Colours` (
  `color_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `rbg` VARCHAR(45) NOT NULL,
  `Is_trans` VARCHAR(45) NOT NULL,
  `Part Categories_category_id` INT NOT NULL,
  `Part Categories_Inventories_inventory_id` INT NOT NULL,
  PRIMARY KEY (`color_id`, `Part Categories_category_id`, `Part Categories_Inventories_inventory_id`),
  UNIQUE INDEX `color_id_UNIQUE` (`color_id` ASC) VISIBLE,
  INDEX `fk_Colours_Part Categories1_idx` (`Part Categories_category_id` ASC, `Part Categories_Inventories_inventory_id` ASC) VISIBLE,
  CONSTRAINT `fk_Colours_Part Categories1`
    FOREIGN KEY (`Part Categories_category_id` , `Part Categories_Inventories_inventory_id`)
    REFERENCES `mydb`.`Part Categories` (`category_id` , `Inventories_inventory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Parts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Parts` (
  `Parts_ID` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `part_cat_id` INT NOT NULL,
  `inventory_id` INT NOT NULL,
  `color_id` INT NOT NULL,
  `Colours_color_id` INT NOT NULL,
  `Inventories_inventory_id` INT NOT NULL,
  PRIMARY KEY (`Parts_ID`, `Colours_color_id`, `Inventories_inventory_id`),
  UNIQUE INDEX `Parts_ID_UNIQUE` (`Parts_ID` ASC) VISIBLE,
  INDEX `fk_Parts_Colours_idx` (`Colours_color_id` ASC) VISIBLE,
  INDEX `fk_Parts_Inventories1_idx` (`Inventories_inventory_id` ASC) VISIBLE,
  CONSTRAINT `fk_Parts_Colours`
    FOREIGN KEY (`Colours_color_id`)
    REFERENCES `mydb`.`Colours` (`color_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Parts_Inventories1`
    FOREIGN KEY (`Inventories_inventory_id`)
    REFERENCES `mydb`.`Inventories` (`inventory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
