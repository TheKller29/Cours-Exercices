-- MySQL Script generated by MySQL Workbench
-- Thu Nov 21 15:06:53 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering


CREATE SCHEMA IF NOT EXISTS `Test` DEFAULT CHARACTER SET utf8 ;
USE `Test` ;

-- -----------------------------------------------------
-- Table `Test`.`Agence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Agence` (
  `idAgence` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(20) NOT NULL,
  `Stock_idStock` INT NOT NULL,
  PRIMARY KEY (`idAgence`, `Stock_idStock`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Adresse` (
  `idAdresse` INT NOT NULL AUTO_INCREMENT,
  `Numéro` VARCHAR(20) NULL,
  `Rue` VARCHAR(255) NOT NULL,
  `Code_postal` VARCHAR(255) NOT NULL,
  `Ville` VARCHAR(50) NOT NULL,
  `Pays` VARCHAR(255) NOT NULL,
  `Complement` VARCHAR(255) NOT NULL,
  `Agence_idAgence` INT NOT NULL,
  PRIMARY KEY (`idAdresse`, `Agence_idAgence`),
  INDEX `fk_Adresse_Agence1_idx` (`Agence_idAgence` ASC),
  CONSTRAINT `fk_Adresse_Agence1`
    FOREIGN KEY (`Agence_idAgence`)
    REFERENCES `Test`.`Agence` (`idAgence`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Banque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Banque` (
  `idBanque` INT NOT NULL,
  `Numéro_carte` VARCHAR(45) NOT NULL,
  `Nom` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idBanque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Client` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Prenom` VARCHAR(45) NOT NULL,
  `Sexe` ENUM('H,F') NULL,
  `Mail` VARCHAR(45) NOT NULL,
  `Téléphone` VARCHAR(45) NULL,
  `Adresse_idAdresse` INT NOT NULL,
  `Banque_idBanque` INT NOT NULL,
  PRIMARY KEY (`idClient`, `Adresse_idAdresse`, `Banque_idBanque`),
  INDEX `fk_Client_Adresse1_idx` (`Adresse_idAdresse` ASC),
  INDEX `fk_Client_Banque1_idx` (`Banque_idBanque` ASC),
  CONSTRAINT `fk_Client_Adresse1`
    FOREIGN KEY (`Adresse_idAdresse`)
    REFERENCES `Test`.`Adresse` (`idAdresse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_Banque1`
    FOREIGN KEY (`Banque_idBanque`)
    REFERENCES `Test`.`Banque` (`idBanque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`horaires`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`horaires` (
  `idhoraires` INT NOT NULL AUTO_INCREMENT,
  `h_début` FLOAT(4,2) NOT NULL,
  `h_fin` FLOAT(4,2) NOT NULL,
  `jour` ENUM('Lundi,Mardi,Mercredi,Jeudi,Vendredi,Samedi,Dimanche') NOT NULL,
  PRIMARY KEY (`idhoraires`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Fiche_achat_matière`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Fiche_achat_matière` (
  `idFiche_achat_matière` INT NOT NULL AUTO_INCREMENT,
  `date_achat` DATE NOT NULL,
  `prix` FLOAT(8,2) NOT NULL,
  PRIMARY KEY (`idFiche_achat_matière`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Ingrèdient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Ingrèdient` (
  `idIngrèdient` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(255) NOT NULL,
  `Quantité` INT(10) NOT NULL,
  PRIMARY KEY (`idIngrèdient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Pizza` (
  `idPizza` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(20) NOT NULL,
  `Prix` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idPizza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Recette_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Recette_pizza` (
  `idRecette_pizza` INT NOT NULL AUTO_INCREMENT,
  `Temps` TIME NULL,
  `Temps_cuisson` TIME NULL,
  `Pizza_idPizza` INT NOT NULL,
  PRIMARY KEY (`idRecette_pizza`, `Pizza_idPizza`),
  INDEX `fk_Recette_pizza_Pizza1_idx` (`Pizza_idPizza` ASC),
  CONSTRAINT `fk_Recette_pizza_Pizza1`
    FOREIGN KEY (`Pizza_idPizza`)
    REFERENCES `Test`.`Pizza` (`idPizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Etat_commande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Etat_commande` (
  `idEtat_commande` INT NOT NULL AUTO_INCREMENT,
  `Date_commande` DATE NOT NULL,
  `Etat_commande` ENUM('Préparé,En préparation,Cuisson,Prete') NOT NULL,
  `Etat_Paiment` ENUM('Payer,Annuler,En attente') NOT NULL,
  PRIMARY KEY (`idEtat_commande`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Modalité`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Modalité` (
  `idModalité` INT NOT NULL,
  `Sur_site_internet` TINYINT NULL,
  `Sur_place` TINYINT NULL,
  `Téléphone` TINYINT NULL,
  PRIMARY KEY (`idModalité`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Fiche_commande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Fiche_commande` (
  `idFiche_commande` INT NOT NULL AUTO_INCREMENT,
  `date_commande` DATE NOT NULL,
  `prix` FLOAT(8,2) NOT NULL,
  `Etat_commande_idEtat_commande` INT NOT NULL,
  `Client_idClient` INT NOT NULL,
  `Client_Adresse_idAdresse` INT NOT NULL,
  `Client_Banque_idBanque` INT NOT NULL,
  `Modalité_idModalité` INT NOT NULL,
  `Agence_idAgence` INT NOT NULL,
  PRIMARY KEY (`idFiche_commande`, `Etat_commande_idEtat_commande`, `Client_idClient`, `Client_Adresse_idAdresse`, `Client_Banque_idBanque`, `Modalité_idModalité`, `Agence_idAgence`),
  INDEX `fk_Fiche_commande_Etat_commande1_idx` (`Etat_commande_idEtat_commande` ASC),
  INDEX `fk_Fiche_commande_Client1_idx` (`Client_idClient` ASC, `Client_Adresse_idAdresse` ASC, `Client_Banque_idBanque` ASC),
  INDEX `fk_Fiche_commande_Modalité1_idx` (`Modalité_idModalité` ASC),
  INDEX `fk_Fiche_commande_Agence1_idx` (`Agence_idAgence` ASC),
  CONSTRAINT `fk_Fiche_commande_Etat_commande1`
    FOREIGN KEY (`Etat_commande_idEtat_commande`)
    REFERENCES `Test`.`Etat_commande` (`idEtat_commande`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fiche_commande_Client1`
    FOREIGN KEY (`Client_idClient` , `Client_Adresse_idAdresse` , `Client_Banque_idBanque`)
    REFERENCES `Test`.`Client` (`idClient` , `Adresse_idAdresse` , `Banque_idBanque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fiche_commande_Modalité1`
    FOREIGN KEY (`Modalité_idModalité`)
    REFERENCES `Test`.`Modalité` (`idModalité`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fiche_commande_Agence1`
    FOREIGN KEY (`Agence_idAgence`)
    REFERENCES `Test`.`Agence` (`idAgence`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Agence_has_horaires`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Agence_has_horaires` (
  `Agence_idAgence` INT NOT NULL,
  `horaires_idhoraires` INT NOT NULL,
  PRIMARY KEY (`Agence_idAgence`, `horaires_idhoraires`),
  INDEX `fk_Agence_has_horaires_horaires1_idx` (`horaires_idhoraires` ASC),
  INDEX `fk_Agence_has_horaires_Agence1_idx` (`Agence_idAgence` ASC),
  CONSTRAINT `fk_Agence_has_horaires_Agence1`
    FOREIGN KEY (`Agence_idAgence`)
    REFERENCES `Test`.`Agence` (`idAgence`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agence_has_horaires_horaires1`
    FOREIGN KEY (`horaires_idhoraires`)
    REFERENCES `Test`.`horaires` (`idhoraires`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Ingrèdient_has_Fiche_achat_matière`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Ingrèdient_has_Fiche_achat_matière` (
  `Ingrèdient_idIngrèdient` INT NOT NULL,
  `Fiche_achat_matière_idFiche_achat_matière` INT NOT NULL,
  PRIMARY KEY (`Ingrèdient_idIngrèdient`, `Fiche_achat_matière_idFiche_achat_matière`),
  INDEX `fk_Ingrèdient_has_Fiche_achat_matière_Fiche_achat_matièr_idx` (`Fiche_achat_matière_idFiche_achat_matière` ASC),
  INDEX `fk_Ingrèdient_has_Fiche_achat_matière_Ingrèdient1_idx` (`Ingrèdient_idIngrèdient` ASC),
  CONSTRAINT `fk_Ingrèdient_has_Fiche_achat_matière_Ingrèdient1`
    FOREIGN KEY (`Ingrèdient_idIngrèdient`)
    REFERENCES `Test`.`Ingrèdient` (`idIngrèdient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ingrèdient_has_Fiche_achat_matière_Fiche_achat_matière1`
    FOREIGN KEY (`Fiche_achat_matière_idFiche_achat_matière`)
    REFERENCES `Test`.`Fiche_achat_matière` (`idFiche_achat_matière`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Recette_pizza_has_Ingrèdient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Recette_pizza_has_Ingrèdient` (
  `Recette_pizza_idRecette_pizza` INT NOT NULL,
  `Ingrèdient_idIngrèdient` INT NOT NULL,
  PRIMARY KEY (`Recette_pizza_idRecette_pizza`, `Ingrèdient_idIngrèdient`),
  INDEX `fk_Recette_pizza_has_Ingrèdient_Ingrèdient1_idx` (`Ingrèdient_idIngrèdient` ASC),
  INDEX `fk_Recette_pizza_has_Ingrèdient_Recette_pizza1_idx` (`Recette_pizza_idRecette_pizza` ASC),
  CONSTRAINT `fk_Recette_pizza_has_Ingrèdient_Recette_pizza1`
    FOREIGN KEY (`Recette_pizza_idRecette_pizza`)
    REFERENCES `Test`.`Recette_pizza` (`idRecette_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recette_pizza_has_Ingrèdient_Ingrèdient1`
    FOREIGN KEY (`Ingrèdient_idIngrèdient`)
    REFERENCES `Test`.`Ingrèdient` (`idIngrèdient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Fiche_commande_has_Pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Fiche_commande_has_Pizza` (
  `Fiche_commande_idFiche_commande` INT NOT NULL,
  `Pizza_idPizza` INT NOT NULL,
  `Quantité` INT NOT NULL,
  PRIMARY KEY (`Fiche_commande_idFiche_commande`, `Pizza_idPizza`),
  INDEX `fk_Fiche_commande_has_Pizza_Pizza1_idx` (`Pizza_idPizza` ASC),
  INDEX `fk_Fiche_commande_has_Pizza_Fiche_commande1_idx` (`Fiche_commande_idFiche_commande` ASC),
  CONSTRAINT `fk_Fiche_commande_has_Pizza_Fiche_commande1`
    FOREIGN KEY (`Fiche_commande_idFiche_commande`)
    REFERENCES `Test`.`Fiche_commande` (`idFiche_commande`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fiche_commande_has_Pizza_Pizza1`
    FOREIGN KEY (`Pizza_idPizza`)
    REFERENCES `Test`.`Pizza` (`idPizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Pizza_has_Ingrèdient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Pizza_has_Ingrèdient` (
  `Pizza_idPizza` INT NOT NULL,
  `Ingrèdient_idIngrèdient` INT NOT NULL,
  PRIMARY KEY (`Pizza_idPizza`, `Ingrèdient_idIngrèdient`),
  INDEX `fk_Pizza_has_Ingrèdient_Ingrèdient1_idx` (`Ingrèdient_idIngrèdient` ASC),
  INDEX `fk_Pizza_has_Ingrèdient_Pizza1_idx` (`Pizza_idPizza` ASC),
  CONSTRAINT `fk_Pizza_has_Ingrèdient_Pizza1`
    FOREIGN KEY (`Pizza_idPizza`)
    REFERENCES `Test`.`Pizza` (`idPizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizza_has_Ingrèdient_Ingrèdient1`
    FOREIGN KEY (`Ingrèdient_idIngrèdient`)
    REFERENCES `Test`.`Ingrèdient` (`idIngrèdient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Test`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Test`.`Stock` (
  `Agence_idAgence` INT NOT NULL,
  `Agence_Stock_idStock` INT NOT NULL,
  `Ingrèdient_idIngrèdient` INT NOT NULL,
  PRIMARY KEY (`Agence_idAgence`, `Agence_Stock_idStock`, `Ingrèdient_idIngrèdient`),
  INDEX `fk_Agence_has_Ingrèdient_Ingrèdient1_idx` (`Ingrèdient_idIngrèdient` ASC),
  INDEX `fk_Agence_has_Ingrèdient_Agence1_idx` (`Agence_idAgence` ASC, `Agence_Stock_idStock` ASC),
  CONSTRAINT `fk_Agence_has_Ingrèdient_Agence1`
    FOREIGN KEY (`Agence_idAgence` , `Agence_Stock_idStock`)
    REFERENCES `Test`.`Agence` (`idAgence` , `Stock_idStock`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agence_has_Ingrèdient_Ingrèdient1`
    FOREIGN KEY (`Ingrèdient_idIngrèdient`)
    REFERENCES `Test`.`Ingrèdient` (`idIngrèdient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



