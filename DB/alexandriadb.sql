-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema alexandriaDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `alexandriaDB` ;

-- -----------------------------------------------------
-- Schema alexandriaDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `alexandriaDB` DEFAULT CHARACTER SET utf8 ;
USE `alexandriaDB` ;

-- -----------------------------------------------------
-- Table `language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `language` ;

CREATE TABLE IF NOT EXISTS `language` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `author` ;

CREATE TABLE IF NOT EXISTS `author` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `middle_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `image_url` VARCHAR(2000) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book` ;

CREATE TABLE IF NOT EXISTS `book` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cover_url` VARCHAR(2000) NULL,
  `title` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `pages` INT NULL,
  `published_year` INT NULL,
  `price` DECIMAL(6,2) NULL,
  `isbn` CHAR(13) NULL,
  `language_id` INT NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_book_language1_idx` (`language_id` ASC),
  INDEX `fk_book_author1_idx` (`author_id` ASC),
  CONSTRAINT `fk_book_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `genre` ;

CREATE TABLE IF NOT EXISTS `genre` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `role` VARCHAR(45) NULL,
  `image_url` VARCHAR(2000) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `about_me` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_review` ;

CREATE TABLE IF NOT EXISTS `book_review` (
  `rating` INT NOT NULL,
  `review` TEXT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  `book_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  INDEX `fk_review_book1_idx` (`book_id` ASC),
  INDEX `fk_review_user1_idx` (`user_id` ASC),
  PRIMARY KEY (`book_id`, `user_id`),
  CONSTRAINT `fk_review_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `booklist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `booklist` ;

CREATE TABLE IF NOT EXISTS `booklist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(2000) NOT NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_booklist_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_booklist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club` ;

CREATE TABLE IF NOT EXISTS `club` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `owner_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_club_user1_idx` (`owner_id` ASC),
  CONSTRAINT `fk_club_user1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `booklist_has_book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `booklist_has_book` ;

CREATE TABLE IF NOT EXISTS `booklist_has_book` (
  `booklist_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`booklist_id`, `book_id`),
  INDEX `fk_booklist_has_book_book1_idx` (`book_id` ASC),
  INDEX `fk_booklist_has_book_booklist1_idx` (`booklist_id` ASC),
  CONSTRAINT `fk_booklist_has_book_booklist1`
    FOREIGN KEY (`booklist_id`)
    REFERENCES `booklist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_booklist_has_book_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_club` ;

CREATE TABLE IF NOT EXISTS `user_has_club` (
  `user_id` INT NOT NULL,
  `club_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `club_id`),
  INDEX `fk_user_has_club_club1_idx` (`club_id` ASC),
  INDEX `fk_user_has_club_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_club_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_club_club1`
    FOREIGN KEY (`club_id`)
    REFERENCES `club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_favorite_book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_favorite_book` ;

CREATE TABLE IF NOT EXISTS `user_has_favorite_book` (
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `book_id`),
  INDEX `fk_user_has_book_book1_idx` (`book_id` ASC),
  INDEX `fk_user_has_book_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_book_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_book_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `club_has_book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_has_book` ;

CREATE TABLE IF NOT EXISTS `club_has_book` (
  `club_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`club_id`, `book_id`),
  INDEX `fk_club_has_book_book1_idx` (`book_id` ASC),
  INDEX `fk_club_has_book_club1_idx` (`club_id` ASC),
  CONSTRAINT `fk_club_has_book_club1`
    FOREIGN KEY (`club_id`)
    REFERENCES `club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_has_book_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_has_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_has_genre` ;

CREATE TABLE IF NOT EXISTS `book_has_genre` (
  `book_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`book_id`, `genre_id`),
  INDEX `fk_book_has_genre_genre1_idx` (`genre_id` ASC),
  INDEX `fk_book_has_genre_book1_idx` (`book_id` ASC),
  CONSTRAINT `fk_book_has_genre_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_genre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `club_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_comment` ;

CREATE TABLE IF NOT EXISTS `club_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `club_comment` TEXT NULL,
  `comment_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  `club_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_club_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_club_comment_club1_idx` (`club_id` ASC),
  INDEX `fk_club_comment_club_comment1_idx` (`in_reply_to_id` ASC),
  CONSTRAINT `fk_club_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_comment_club1`
    FOREIGN KEY (`club_id`)
    REFERENCES `club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_club_comment_club_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `club_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_comment` ;

CREATE TABLE IF NOT EXISTS `book_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `book_comment` TEXT NULL,
  `comment_date` DATETIME NULL,
  `book_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_book_comment_book1_idx` (`book_id` ASC),
  INDEX `fk_book_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_book_comment_book_comment1_idx` (`in_reply_to_id` ASC),
  CONSTRAINT `fk_book_comment_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_comment_book_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `book_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS admin@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'admin'@'localhost';
SET SQL_MODE = '';
DROP USER IF EXISTS user1;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'user1';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `language`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `language` (`id`, `name`) VALUES (1, 'English');

COMMIT;


-- -----------------------------------------------------
-- Data for table `author`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `author` (`id`, `first_name`, `middle_name`, `last_name`, `image_url`, `description`) VALUES (1, 'Orson', 'Scott', 'Card', NULL, 'Orson Scott Card is an American writer known best for his science fiction works. He is the first and only person to win both a Hugo Award and a Nebula Award in consecutive years, winning both awards for both his novel Ender\'s Game and its sequel Speaker for the Dead.');
INSERT INTO `author` (`id`, `first_name`, `middle_name`, `last_name`, `image_url`, `description`) VALUES (2, 'Joanne', 'Kathleen', 'Rowling', NULL, 'J. K. Rowling, is a British author and philanthropist. She wrote Harry Potter, a seven-volume children\'s fantasy series.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (1, '', 'Ender\'s Game', 'When hostile aliens called the Formics attack Earth, only the legendary heroics of Mazer Rackham (Ben Kingsley) manage to attain a victory.', 300, 2013, 9.99, '0765337320', 1, 1);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (2, NULL, 'Harry Potter and the Sorcerer\'s Stone', 'An orphaned boy enrolls in a school of wizardry, where he learns the truth about himself, his family and the terrible evil that haunts the magical world.', 456, 1997, 29.99, '9780545582889', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (3, NULL, 'Harry Potter and the Chamber of Secrets', 'The Dursleys were so mean that hideous that summer that all Harry Potter wanted was to get back to the Hogwarts School for Witchcraft and Wizardry. But just as he\'s packing his bags, Harry receives a warning from a strange, impish creature named Dobby who says that if Harry Potter returns to Hogwarts, disaster will strike.', 341, 1998, 6.98, '0439064872', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (4, NULL, 'Harry Potter and the Prisoner of Azkaban', 'Harry Potter & The Prisoner of Azkaban is about Harry\'s 3rd year at Hogwarts. Along with friends Ron and Hermione, Harry investigates the case of Sirius Black, an escaped prisoner from Azkaban, the wizard prison.', 317, 1999, 9.99, '0-7475-4215-5', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (5, NULL, 'Harry Potter and the Goblet of Fire', 'Fourteen-year-old Harry Potter joins the Weasleys at the Quidditch World Cup, then enters his fourth year at Hogwarts Academy where he is mysteriously entered in an unusual contest that challenges his wizarding skills, amid signs that an old enemy is growing stronger.', 752, 2000, 11.69, '9780439139601', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (6, NULL, 'Harry Potter and the Order of the Phoenix', 'Harry Potter is due to start his fifth year at Hogwarts School of Witchcraft and Wizardry. He is desperate to get back to school and find out why his friends Ron and Hermione have been so secretive all summer.', 766, 2003, 14.99, '9781338299182', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (7, NULL, 'Harry Potter and the Half-Blood Prince', 'The war against Voldemort is not going well; even the Muggles have been affected. Dumbledore is absent from Hogwarts for long stretches of time, and the Order of the Phoenix has already suffered losses. And yet . . . As with all wars, life goes on. Sixth-year students learn to Apparate.', 607, 2005, 12.99, '0-7475-8108-8', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (8, NULL, 'Harry Potter and the Deathly Hallows', 'After years of battling against the evil Lord Voldemort, 17-year-old Harry Potter is finally an adult wizard, and he and his best friends Ron Weasley and Hermione Granger must set out on a dangerous mission to stop Voldemort once and for all.', 607, 2007, 9.98, '0545139708', 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `genre` (`id`, `name`, `image_url`) VALUES (1, 'sci-fi', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `image_url`, `first_name`, `last_name`, `about_me`) VALUES (1, 'admin', 'admin', 1, 'admin', NULL, 'kenny', 'Yan', 'I like ramen');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_review`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `book_review` (`rating`, `review`, `create_date`, `last_update`, `book_id`, `user_id`) VALUES (10, 'Great Book', '2023-03-17', '2023-03-17', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `booklist`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `booklist` (`id`, `name`, `description`, `image_url`, `user_id`) VALUES (1, 'Ender\'s Game', 'User\'s favorite book\'s', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `club`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `club` (`id`, `name`, `description`, `owner_id`, `create_date`, `image_url`) VALUES (1, 'Alexandria', 'Book club', 1, '2023-03-17', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `club_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `club_comment` (`id`, `club_comment`, `comment_date`, `user_id`, `club_id`, `in_reply_to_id`) VALUES (1, 'Great club!', '2023-03-17', 1, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `book_comment` (`id`, `book_comment`, `comment_date`, `book_id`, `user_id`, `in_reply_to_id`) VALUES (1, 'Fun to read', '2023-03-17', 1, 1, NULL);

COMMIT;

