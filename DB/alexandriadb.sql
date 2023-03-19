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
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `author` ;

CREATE TABLE IF NOT EXISTS `author` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
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
  `isbn` CHAR(16) NULL,
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
  `id` INT NOT NULL AUTO_INCREMENT,
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
  `id` INT NOT NULL AUTO_INCREMENT,
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

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `language`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `language` (`id`, `name`) VALUES (1, 'English');
INSERT INTO `language` (`id`, `name`) VALUES (2, 'Japanese');

COMMIT;


-- -----------------------------------------------------
-- Data for table `author`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (1, 'Orson Scott', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (2, 'JK Rowling', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (3, 'Shusaku Endo', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (4, 'H.P Lovecraft', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (5, 'Julius Evola', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (6, 'Plato', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (7, 'Marcus Aurelius', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (8, 'Dante Alighieri', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (9, 'Dale Carnegie', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (10, 'Fyodor Dostoyevsky', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (12, 'George Orwell', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (16, 'Sir Thomas More', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (17, 'Seneca', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (18, 'Aldous Huxley', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (19, 'Fyodor Dostoyevsky', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (22, 'Aleksandr Solzhenitsyn', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (23, 'Alexandre Dumas', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (24, 'Eric Matthes', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (25, 'Mahmoud Al-Batal', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (26, 'John Milton', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (28, 'Philip K. Dick', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (29, 'Dashiell Hammett', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (30, 'Terrence McKenna', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (31, 'Jocko Willink', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (32, 'Hezi Brosh', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (33, 'Friedrick Nietzsche', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (34, 'Philip Zimbardo', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (35, 'Sylvain Neuvel', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (36, 'Robert Coram', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (37, 'Yuval Noah Harari', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (38, 'Richard Evelyn Byrd', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (39, 'Niccolo Machiavelli', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (40, 'Liao Yiwu', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (41, 'Homer', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (42, 'Padmasambhava', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (43, 'Karl Marx', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (45, 'Jean-Paul Sartre', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (46, 'Franz Kafka', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (49, 'Fanon Frantz', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (50, 'Peter Kemp', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (51, 'Junji Ito', '', '');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (52, 'Thomas Nelson', '', '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (1, '', 'Ender\'s Game', 'When hostile aliens called the Formics attack Earth, only the legendary heroics of Mazer Rackham (Ben Kingsley) manage to attain a victory.', 300, 1985, 9.99, '0765337320', 1, 1);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (2, 'https://m.media-amazon.com/images/I/51ihv5SnMnL._SY344_BO1,204,203,200_.jpg', 'Orthodox Study Bible', 'Commissioned in 1975 by Thomas Nelson, 130 international and multi-denominational Bible scholars, church leaders, and lay Christians worked for seven years to create a completely new, modern translation of Scripture that retained the purity and stylistic beauty of the King James Version', 1856, 2008, 36.49, '718003594', 1, 52);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (3, 'https://m.media-amazon.com/images/I/51wTS7XDq+L._SY344_BO1,204,203,200_.jpg', 'Silence', 'Seventeenth-century Japan: Two Portuguese Jesuit priests travel to a country hostile to their religion, where feudal lords force the faithful to publicly renounce their beliefs. Eventually captured and forced to watch their Japanese Christian brothers lay down their lives for their faith, the priests bear witness to unimaginable cruelties that test their own beliefs.', 256, 1966, 12.19, '1250082242', 1, 3);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (4, 'https://m.media-amazon.com/images/I/51jjZA38RgL._SX331_BO1,204,203,200_.jpg', 'Great Tales of Horror', 'Beginning with The Call of the Cthulhu, the first story of the Cthulhu Mythos, and demonstrating the highly original combination of the supernatural, horror and science fiction that was to influence generations of fantasy writers, this collection of 20 short stories by HP Lovecraft (1890-1937) presents his best-known tales, including The Dunwich Horror, The Rats in the Walls and the novella set in the wastes of Antarctica, At the Mountains of Madness.', 599, 2012, 10.49, '1435140370', 1, 4);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (5, 'https://m.media-amazon.com/images/I/51RemzIhvDL._SY344_BO1,204,203,200_.jpg', 'Revolt Against the Modern World', 'With unflinching gaze and uncompromising intensity Julius Evola analyzes the spiritual and cultural malaise at the heart of Western civilization and all that passes for progress in the modern world. As a gadfly, Evola spares no one and nothing in his survey of what we have lost and where we are headed.', 375, 1934, 26.68, '089281506X', 1, 5);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (6, 'https://m.media-amazon.com/images/I/413HlIU9zhL._SY344_BO1,204,203,200_.jpg', 'The Republic', 'Presented in the form of a dialogue between Socrates and three different interlocutors, it is an inquiry into the notion of a perfect community and the ideal individual within it. During the conversation other questions are raised: what is goodness; what is reality; what is knowledge? The Republic also addresses the purpose of education and the role of both women and men as guardians\' of the people.\'', 416, -375, 11.70, '140455116', 1, 6);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (7, 'https://m.media-amazon.com/images/I/411-wdledbL._SY344_BO1,204,203,200_.jpg', 'Meditations', 'Written in Greek by an intellectual Roman emperor without any intention of publication, the Meditations of Marcus Aurelius  offer a wide range of fascinating spiritual reflections and exercises developed as the leader struggled to understand himself and make sense of the universe', 304, 1634, 9.90, '140449337', 1, 7);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (8, 'https://kbimages1-a.akamaihd.net/68229b42-3d06-4e3e-a26c-347144ee829f/353/569/90/False/the-divine-comedy-163.jpg', 'The Divine Comedy', 'Dante\'s masterpiece of literature is well matched by the peerless art of Gustave Dore. Dante and his guides, Virgil and Beatrice, journey through the cantos in an allegory of the passage of the soul through the Afterlife, with the subtle engraving of Dore\'s illustrations perfectly complementing the movement from darkness through to light.', 432, 1472, 30.00, '1786648113', 1, 8);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (9, 'https://m.media-amazon.com/images/I/71vK0WVQ4rL._AC_UF1000,1000_QL80_.jpg', 'How to Win Friends & Influence People', 'Dale Carnegie\'s rock-solid, time-tested advice has carried countless people up the ladder of success in their business and personal lives.', 320, 1936, 10.30, '671027034', 1, 9);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (10, 'https://m.media-amazon.com/images/P/1250788455.01._SCLZZZZZZZ_SX500_.jpg', 'The Brothers Karamazov', 'The Brothers Karamasov is a murder mystery, a courtroom drama, and an exploration of erotic rivalry in a series of triangular love affairs involving the \'wicked and sentimental\' Fyodor Pavlovich Karamazov and his three sons-the impulsive and sensual Dmitri; the coldly rational Ivan; and the healthy, red-cheeked young novice Alyosha.', 880, 1880, 16.99, '1250788455', 1, 10);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (12, 'https://m.media-amazon.com/images/I/41pK6jIGlKL._SX330_BO1,204,203,200_.jpg', 'Homage to Catalonia', 'In 1936, originally intending merely to report on the Spanish Civil War as a journalist, George Orwell found himself embroiled as a participant-as a member of the Workers\' Party of Marxist Unity. Fighting against the Fascists, he described in painfully vivid and occasionally comic detail life in the trenches-with a \'democratic army\' composed of men with no ranks, no titles, and often no weapons-and his near fatal wounding. As the politics became tangled, Orwell was pulled into a heartbreaking conflict between his own personal ideals and the complicated realities of political power struggles.', 304, 1938, 10.89, '544382048', 1, 12);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (13, 'https://m.media-amazon.com/images/I/41f+CKvPEpL._SX258_BO1,204,203,200_.jpg', '1984', 'In 1984, London is a grim city in the totalitarian state of Oceania where Big Brother is always watching you and the Thought Police can practically read your mind. Winston Smith is a man in grave danger for the simple reason that his memory still functions. Drawn into a forbidden love affair, Winston finds the courage to join a secret revolutionary organization called the Brotherhood, dedicated to the destruction of the Party. Together with his beloved Julia, he hazards his life in a deadly match against the powers that be.', 224, 1949, 18.49, '358359929', 1, 12);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (16, 'https://m.media-amazon.com/images/I/51kRWJZ97pL._SX331_BO1,204,203,200_.jpg', 'Utopia', 'In his most famous and controversial book, Utopia, Thomas More imagines a perfect island nation where thousands live in peace and harmony, men and women are both educated, and all property is communal. Through dialogue and correspondence between the protagonist Raphael Hythloday and his friends and contemporaries, More explores the theories behind war, political disagreements, social quarrels, and wealth distribution and imagines the day-to-day lives of those citizens enjoying freedom from fear, oppression, violence, and suffering.', 176, 1516, 11.99, '9780140449105', 1, 16);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (17, 'https://m.media-amazon.com/images/I/510RH1nJgQL._SY344_BO1,204,203,200_.jpg', 'Letters from a Stoic', 'For several years of his turbulent life, Seneca was the guiding hand of the Roman Empire. His inspired reasoning derived mainly from the Stoic principles, which had originally been developed some centuries earlier in Athens. This selection of Seneca\'s letters shows him upholding the austere ethical ideals of Stoicism-the wisdom of the self-possessed person immune to overmastering emotions and life\'s setbacks-while valuing friendship and the courage of ordinary men, and criticizing the harsh treatment  of slaves and the cruelties in the gladiatorial arena. The humanity and wit revealed in Seneca\'s interpretation of Stoicism is a moving and inspiring declaration of the dignity of the individual mind.', 254, 64, 13.99, '9780140442106', 1, 17);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (18, 'https://m.media-amazon.com/images/I/41-n-3hZMeL._SY344_BO1,204,203,200_.jpg', 'Brave New World', 'Aldous Huxley\'s profoundly important classic of world literature, Brave New World is a searching vision of an unequal, technologically-advanced future where humans are genetically bred, socially indoctrinated, and pharmaceutically anesthetized to passively uphold an authoritarian ruling order-all at the cost of our freedom, full humanity, and perhaps also our souls.', 288, 1932, 11.47, '60850523', 1, 18);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (19, 'https://m.media-amazon.com/images/I/41K1QqtKyNL._SY344_BO1,204,203,200_.jpg', 'The Idiot', 'After his great portrayal of a guilty man in Crime and Punishment, Dostoevsky set out in The Idiot to portray a man of pure innocence. The twenty-six-year-old Prince Myshkin, following a stay of several years in a Swiss sanatorium, returns to Russia to collect an inheritance and \'be among people.\' Even before he reaches home he meets the dark Rogozhin, a rich merchant\'s son whose obsession with the beautiful Nastasya Filippovna eventually draws all three of them into a tragic denouement. In Petersburg the prince finds himself a stranger in a society obsessed with money, power, and manipulation. Scandal escalates to murder as Dostoevsky traces the surprising effect of this \'positively beautiful man\' on the people around him, leading to a final scene that is one of the most powerful in all of world literature.', 656, 1868, 16.29, '375702245', 1, 19);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (20, 'https://m.media-amazon.com/images/I/41novGr34wL._SY344_BO1,204,203,200_.jpg', 'Notes from Underground', 'One of the most remarkable characters in literature, the unnamed narrator of Dostoevsky\'s most revolutionary novel is a former official who has defiantly withdrawn into an underground existence. In full retreat from society, he scrawls a passionate, obsessive, self-contradictory narrative that serves as a devastating attack on social utopianism and an assertion of man\'s essentially irrational nature.', 136, 1864, 12.54, '067973452X', 1, 19);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (21, 'https://m.media-amazon.com/images/I/41WYXBA5mrL._SX320_BO1,204,203,200_.jpg', 'Crime and Punishment', 'When Raskolnikov, an impoverished student living in the St. Petersburg of the tsars, commits an act of murder and theft, he sets into motion a story that is almost unequalled in world literature for its excruciating suspense, its atmospheric vividness, and its depth of characterization and vision. Dostoevsky\'s drama of sin, guilt, and redemption transforms the sordid story of an old woman\'s murder into the nineteenth century\'s profoundest and most compelling philosophical novel.', 565, 1866, 15.99, '679734503', 1, 19);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (22, 'https://m.media-amazon.com/images/I/41MQggAwO8L._SX328_BO1,204,203,200_.jpg', 'The Gulag Archipelago', 'The Gulag Archipelago is an exhaustive and compelling account based on Solzhenitsyn\'s own eight years in Soviet prison camps, on other prisoners\' stories committed to his photographic memory while in detention, and on letters and historical sources. The work represents the author\'s attempt to compile a literary and historical record of the Soviet regime\'s comprehensive but deeply irrational use of terror against its own population. A testimonial to Stalinist atrocities, The Gulag Archipelago devastated readers outside the Soviet Union with its descriptions of the brutality of the Soviet regime.', 701, 1973, 13.99, '9780061253713', 1, 22);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (23, 'https://m.media-amazon.com/images/I/51uSVURMnVL._SY344_BO1,204,203,200_.jpg', 'The Count of Monte Cristo', 'This beloved novel tells the story of Edmond Dantes, wrongfully imprisoned for life in the supposedly impregnable sea fortress, the Chateau d\'If. After a daring escape, and after unearthing a hidden treasure revealed to him by a fellow prisoner, he devotes the rest of his life to tracking down and punishing the enemies who wronged him.', 1240, 1846, 29.07, '307271129', 1, 23);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (24, 'https://m.media-amazon.com/images/I/514cSQ0O9OL._SX258_BO1,204,203,200_.jpg', 'Python Crash Course, 3rd Edition', 'Python Crash Course is the world\'s best-selling guide to the Python programming language. This fast-paced, thorough introduction will have you writing programs, solving problems, and developing functioning applications in no time.', 552, 2022, 40.49, '1718502702', 1, 24);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (25, 'https://m.media-amazon.com/images/I/41FBtYZ8AfS._SX384_BO1,204,203,200_.jpg', 'Alif Baa', 'Alif Baa is the first volume of the best-selling Al-Kitaab Arabic Language Program, now in its third edition. In this edition of Alif Baa: Introduction to Arabic Letters and Sounds with Website, English-speaking students will use the integrated method of learning colloquial and formal (spoken and written) Arabic together. Alif Baa provides learners with all the material necessary to learn the sounds of Arabic, write its letters, and begin speaking Arabic.The accompanying companion website-included with the book-offers fully integrated exercises to use alongside the text.', 272, 2021, 14.94, '1647121817', 1, 25);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (26, 'https://m.media-amazon.com/images/I/31c4U69DLDL._SY344_BO1,204,203,200_.jpg', 'Paradise Lost', 'Paradise Lost is an epic poem in blank verse by the 17th-century English poet John Milton (1608-1674). It is considered to be Milton\'s major work, and it helped solidify his reputation as one of the greatest English poets of his time. The poem concerns the biblical story of the Fall of Man: the temptation of Adam and Eve by the fallen angel Satan and their expulsion from the Garden of Eden. Milton\'s purpose, as stated in Book I, is to justify the ways of God to men.\'', 205, 1667, 7.99, '979-8670888615', 1, 26);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (28, 'https://m.media-amazon.com/images/I/41fIOsug3PL._SY344_BO1,204,203,200_.jpg', 'Ubik', 'Named one of Time\'s 100 Best Books, Ubik is a mind-bending, classic novel about the perception of reality from Philip K. Dick, the Hugo Award-winning author of The Man in the High Castle. \'From the stuff of space opera, Dick spins a deeply unsettling existential horror story, a nightmare you\'ll never be sure you\'ve woken up from.\'-Lev Grossman, Time Glen Runciter runs a lucrative business - deploying his teams of anti-psychics to corporate clients who want privacy and security from psychic spies. But when he and his top team are ambushed by a rival, he is gravely injured and placed in \'half-life,\' a dreamlike state of suspended animation. Soon, though, the surviving members of the team begin experiencing some strange phenomena, such as Runciter\'s face appearing on coins and the world seeming to move backward in time.', 240, 1969, 11.99, '547572298', 1, 28);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (29, 'https://m.media-amazon.com/images/I/51kDq26MsEL._SY344_BO1,204,203,200_.jpg', 'The Maltese Falcon', 'A treasure worth killing for. Sam Spade, a slightly shopworn private eye with his own solitary code of ethics. A perfumed grafter named Joel Cairo, a fat man name Gutman, and Brigid O\'Shaughnessy, a beautiful and treacherous woman whose loyalties shift at the drop of a dime. These are the ingredients of Dashiell Hammett\'s iconic, influential, and beloved The Maltese Falcon.', 217, 1929, 14.49, '679722645', 1, 29);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (30, 'https://m.media-amazon.com/images/I/51OjtMiKQTL._SX328_BO1,204,203,200_.jpg', 'Food of the Gods: The Search for the Original Tree of Knowledge', 'Why, as a species, are humans so fascinated by altered states of consciousness? Can altered states reveal something to us about our origins and our place in nature? In Food of the Gods, ethnobotanist Terence McKenna\'s research on man\'s ancient relationship with chemicals opens a doorway to the divine, and perhaps a solution for saving our troubled world. McKenna provides a revisionist look at the historical role of drugs in the East and the West, from ancient spice, sugar, and rum trades to marijuana, cocaine, synthetics, and even television-illustrating the human desire for the \'food of the gods\' and the powerful potential to replace abuse of illegal drugs with a shamanic understanding, insistence on community, reverence for nature, and increased self-awareness.', 311, 1993, 17.99, '553371304', 1, 30);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (31, 'https://m.media-amazon.com/images/I/51yoHjJDQ3L._SY344_BO1,204,203,200_.jpg', 'Extreme Ownership', 'Combat, the most intense and dynamic environment imaginable, teaches the toughest leadership lessons, with absolutely everything at stake. Jocko Willink and Leif Babin learned this reality first-hand on the most violent and dangerous battlefield in Iraq. As leaders of SEAL Team Three\'s Task Unit Bruiser, their mission was one many thought impossible: help U.S. forces secure Ramadi, a violent, insurgent-held city deemed \'all but lost.\' In gripping, firsthand accounts of heroism, tragic loss, and hard-won victories, they learned that leadership-at every level-is the most important factor in whether a team succeeds or fails.', 384, 2017, 17.99, '9781250183866', 1, 31);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (32, 'https://m.media-amazon.com/images/I/41oGA1RNwXL._SY344_BO1,204,203,200_.jpg', 'Arabic Stories for Language Learners: Traditional Middle Eastern Tales In Arabic and English', 'The traditional stories of a country are invaluable at providing insight into understanding the culture, history and language of a people. A great way to learn Arabic, the sixty-six stories found in Arabic Stories for Language Learners present the vocabulary and grammar used every day in Arabic-speaking countries. Pulled from a wide variety of sources that have been edited and simplified for learning purposes, these stories are presented in parallel Arabic and English, facilitating language learning in the classroom and via self-study. Each story is followed by a series of questions in Arabic and English to test comprehension and encourage discussion.', 256, 2013, 19.95, '804843007', 1, 32);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (33, 'https://m.media-amazon.com/images/I/414yS8wldNL._SY344_BO1,204,203,200_.jpg', 'Beyond Good and Evil', 'Beyond Good and Evil: Prelude to a Philosophy of the Future is a book by philosopher Friedrich Nietzsche, first published in 1886. It draws on and expands the ideas of his previous work, Thus Spoke Zarathustra, but with a more critical and polemical approach. In Beyond Good and Evil, Nietzsche accuses past philosophers of lacking critical sense and blindly accepting dogmatic premises in their consideration of morality. Specifically, he accuses them of founding grand metaphysical systems upon the faith that the good man is the opposite of the evil man, rather than just a different expression of the same basic impulses that find more direct expression in the evil man. The work moves into the realm beyond good and evil\' in the sense of leaving behind the traditional morality which Nietzsche subjects to a destructive critique in favour of what he regards as an affirmative approach that fearlessly confronts the perspectival nature of knowledge and the perilous condition of the modern individual.\'', 116, 1886, 6.99, '9781503250888', 1, 33);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (34, 'https://m.media-amazon.com/images/I/51WcKZ4NQPL._SY344_BO1,204,203,200_.jpg', 'The Lucifer Effect: Understanding How Good People Turn Evil', 'Renowned social psychologist and creator of the Stanford Prison Experiment Philip Zimbardo explores the mechanisms that make good people do bad things, how moral people can be seduced into acting immorally, and what this says about the line separating good from evil.\n\nThe Lucifer Effect explains how-and the myriad reasons why-we are all susceptible to the lure of \'the dark side.\' Drawing on examples from history as well as his own trailblazing research, Zimbardo details how situational forces and group dynamics can work in concert to make monsters out of decent men and women. ', 576, 2008, 17.99, '812974441', 1, 34);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (35, 'https://m.media-amazon.com/images/I/51dxRfIejrL._SY344_BO1,204,203,200_.jpg', 'Sleeping Giants', 'A girl named Rose is riding her new bike near her home in Deadwood, South Dakota, when she falls through the earth. She wakes up at the bottom of a square hole, its walls glowing with intricate carvings. But the firemen who come to save her peer down upon something even stranger: a little girl in the palm of a giant metal hand.\n\nSeventeen years later, the mystery of the bizarre artifact remains unsolved-its origins, architects, and purpose unknown. Its carbon dating defies belief; military reports are redacted; theories are floated, then rejected.\n\nBut some can never stop searching for answers.', 336, 2017, 16.73, '1101886714', 1, 35);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (36, 'https://m.media-amazon.com/images/I/51dU1i1+AiL._SX331_BO1,204,203,200_.jpg', 'Boyd: The Fighter Pilot Who Changed the Art of War', 'John Boyd may be the most remarkable unsung hero in all of American military history. Some remember him as the greatest U.S. fighter pilot ever -- the man who, in simulated air-to-air combat, defeated every challenger in less than forty seconds. Some recall him as the father of our country\'s most legendary fighter aircraft -- the F-15 and F-16. Still others think of Boyd as the most influential military theorist since Sun Tzu. They know only half the story.', 504, 2004, 19.99, '316796883', 1, 36);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (37, 'https://m.media-amazon.com/images/I/41lZKXt1+ML._SY344_BO1,204,203,200_.jpg', 'Sapiens: A Brief History of Humankind', 'From examining the role evolving humans have played in the global ecosystem to charting the rise of empires, Sapiens integrates history and science to reconsider accepted narratives, connect past developments with contemporary concerns, and examine specific events within the context of larger ideas. Dr. Harari also compels us to look ahead, because over the last few decades humans have begun to bend laws of natural selection that have governed life for the past four billion years. We are acquiring the ability to design not only the world around us, but also ourselves. Where is this leading us, and what do we want to become?', 578, 2018, 15.00, '9780062316110', 1, 37);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (38, 'https://m.media-amazon.com/images/I/4169yIOsEaL._SY344_BO1,204,203,200_.jpg', 'Alone: A Classic Polar Adventure', 'When Admiral Richard E. Byrd set out on his second Antarctic expedition in 1934, he was already an international hero for having piloted the first flights over the North and South Poles. His plan for this latest adventure was to spend six months alone near the bottom of the world, gathering weather data and indulging his desire \'to taste peace and quiet long enough to know how good they really are.\' But early on things went terribly wrong. Isolated in the pervasive polar night with no hope of release until spring, Byrd began suffering inexplicable symptoms of mental and physical illness. By the time he discovered that carbon monoxide from a defective stovepipe was poisoning him, Byrd was already engaged in a monumental struggle to save his life and preserve his sanity.', 310, 2003, 35.00, '1559634634', 1, 38);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (39, 'https://m.media-amazon.com/images/I/31gHMQMqCAL._SY344_BO1,204,203,200_.jpg', 'The Prince', 'The Prince is a 16th-century political treatise written by Italian diplomat and political theorist Niccolo Machiavelli as an instruction guide for new princes and royals. The general theme of The Prince is of accepting that the aims of princes - such as glory and survival - can justify the use of immoral means to achieve those ends.', 114, 1532, 7.99, '979-8712157877', 1, 39);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (40, 'https://m.media-amazon.com/images/I/41UK+xizvyL._SY344_BO1,204,203,200_.jpg', 'Bullets and Opium: Real-Life Stories of China After the Tiananmen Square Massacre', 'Much has been written about the Tiananmen Square protests, but very little exists in the words of those who were actually there.\n\nFor over seven years, Liao Yiwu-a master of contemporary Chinese literature, imprisoned and persecuted as a counter-revolutionary until he fled the country in 2011-secretly interviewed survivors of the devastating 1989 Tiananmen Square massacre. Tortured, imprisoned, and forced into silence and the margins of Chinese society for thirty years, their harrowing and unforgettable stories are now finally revealed in this \'indispensable historical document\' (Kirkus Reviews, starred review).', 320, 2012, 16.94, '1982126655', 1, 40);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (41, 'https://m.media-amazon.com/images/I/41+IcE1BGXL._SY344_BO1,204,203,200_.jpg', 'The Iliad', 'Dating to the ninth century B.C., Homer\'s timeless poem still vividly conveys the horror and heroism of men and gods wrestling with towering emotions and battling amidst devastation and destruction, as it moves inexorably to the wrenching, tragic conclusion of the Trojan War. Renowned classicist Bernard Knox observes in his superb introduction that although the violence of the Iliad is grim and relentless, it coexists with both images of civilized life and a poignant yearning for peace.', 704, -900, 12.99, '9780140275360', 1, 41);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (42, 'https://m.media-amazon.com/images/I/51raOBsi-CL._SY344_BO1,204,203,200_.jpg', 'The Tibetan Book of the Dead', 'Translated with the close support of leading contemporary masters and hailed as \'a tremendous accomplishment,\' this book faithfully presents the insights and intentions of the original work. It includes one of the most detailed and compelling descriptions of the after-death state in world literature, practices that can transform our experience of daily life, guidance on helping those who are dying, and an inspirational perspective on coping with bereavement.', 535, 750, 21.49, '143104942', 1, 42);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (43, 'https://m.media-amazon.com/images/I/512g4Ejpt7L._SY344_BO1,204,203,200_.jpg', 'Das Kapital', 'Das Kapital is a revolutionary book; forged during the political and industrial revolutions of the nineteenth century, it became the keystone of many Communist revolutions of the twentieth century. In this comprehensive analysis of capitalist economics and articulation of his theory of class conflict, Karl Marx (1818-1883) relentlessly argues that the accumulation of capital can only be achieved by bourgeoisie exploitation of the working classes. Das Kapital has not only changed history, but also human thought, becoming a foundational text in materialist philosophy, economics and politics.', 594, 1867, 29.99, '1789430658', 1, 43);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (45, 'https://m.media-amazon.com/images/I/419G6JyTj-L._SX331_BO1,204,203,200_.jpg', 'Being and Nothingness', 'In 1943, Jean-Paul Sartre published his masterpiece, Being and Nothingness, and laid the foundation of his legacy as one of the greatest twentieth century philosophers. A brilliant and radical account of the human condition, Being and Nothingness explores what gives our lives significance.\n\nIn a new and more accessible translation, this foundational text argues that we alone create our values and our existence is characterized by freedom and the inescapability of choice. Far from being an internal, passive container for our thoughts and experiences, human consciousness is constantly projecting itself into the outside world and imbuing it with meaning.', 928, 1943, 16.79, '1982105453', 1, 45);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (46, 'https://m.media-amazon.com/images/I/415tB5UC7IL._SY344_BO1,204,203,200_.jpg', 'The Metamorphosis', 'Metamorphosis is a novella written by Franz Kafka which was first published in 1915. One of Kafka\'s best-known works, The Metamorphosis tells the story of salesman Gregor Samsa who wakes one morning to find himself inexplicably transformed into a huge insect, subsequently struggling to adjust to this new condition. The novella has been widely discussed among literary critics, with differing interpretations being offered.', 52, 1915, 4.99, '1680920715', 1, 46);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (49, 'https://m.media-amazon.com/images/I/51Ni04O2s4L._SX318_BO1,204,203,200_.jpg', 'The Wretched of the Earth', 'First published in 1961, and reissued in this sixtieth anniversary edition with a powerful new introduction by Cornel West, Frantz Fanon\'s The Wretched of the Earth is a masterfuland timeless interrogation of race, colonialism, psychological trauma, and revolutionary struggle, and a continuing influence on movements from Black Lives Matter to decolonization. A landmark text for revolutionaries and activists, The Wretched of the Earth is an eternal touchstone for civil rights, anti-colonialism, psychiatric studies, and Black consciousness movements around the world. Alongside Cornel West\'s introduction, the book features critical essays by Jean-Paul Sartre and Homi K. Bhabha. This sixtieth anniversary edition of Fanon\'s most famous text stands proudly alongside such pillars of anti-colonialism and anti-racism as Edward Said\'s Orientalism and The Autobiography of Malcolm X.', 336, 1961, 12.69, '802158633', 1, 49);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (50, 'https://m.media-amazon.com/images/I/416ASRyA6UL._SX331_BO1,204,203,200_.jpg', 'Mine Were of Trouble: A Nationalist Account of the Spanish Civil War', 'Spain, 1936. Escalating violence between left- and right-wing political factions boils over. Military officers stage a coup against a democratically elected, Soviet-backed, government. The country is thrown into chaos as centuries-old tensions return to the forefront. Hundreds of thousands of Spaniards choose sides and engage in the most devastating combat since the First World War. For loyalists to the Republic, the fight is seen as one for equality and their idea of progress. For the rebels, the struggle is a preemptive strike by tradition against an attempted communist takeover.\n\nThousands of foreigners, too, join the struggle. Most fight with the Soviet-sponsored International Brigades or other militias aligned with the loyalist \'Republicans\'. Only a few side with the rebel \'Nationalists\'. One of these rare volunteers for the Nationalists was Peter Kemp, a young British law student. Kemp, despite having little training or command of the Spanish language, was moved by the Nationalist struggle against international Communism. Using forged documents, he sneaked into Spain and joined a traditionalist militia, the Requetes, with which he saw intense fighting. Later, he volunteered to join the legendary and ruthless Spanish Foreign Legion, where he distinguished himself with heroism. Because of this bravery, he was one of the few foreign volunteers granted a private audience with Generalissimo Francisco Franco.', 171, 1936, 9.99, '979-8624731721', 1, 50);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (52, NULL, 'Harry Potter and the Sorcerer\'s Stone', 'An orphaned boy enrolls in a school of wizardry, where he learns the truth about himself, his family and the terrible evil that haunts the magical world.', 456, 1997, 29.99, '9780545582889', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (53, NULL, 'Harry Potter and the Chamber of Secrets', 'The Dursleys were so mean that hideous that summer that all Harry Potter wanted was to get back to the Hogwarts School for Witchcraft and Wizardry. But just as he\'s packing his bags, Harry receives a warning from a strange, impish creature named Dobby who says that if Harry Potter returns to Hogwarts, disaster will strike.', 341, 1998, 6.98, '0439064872', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (54, NULL, 'Harry Potter and the Prisoner of Azkaban', 'Harry Potter & The Prisoner of Azkaban is about Harry\'s 3rd year at Hogwarts. Along with friends Ron and Hermione, Harry investigates the case of Sirius Black, an escaped prisoner from Azkaban, the wizard prison.', 317, 1999, 9.99, '0-7475-4215-5', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (55, NULL, 'Harry Potter and the Goblet of Fire', 'Fourteen-year-old Harry Potter joins the Weasleys at the Quidditch World Cup, then enters his fourth year at Hogwarts Academy where he is mysteriously entered in an unusual contest that challenges his wizarding skills, amid signs that an old enemy is growing stronger.', 752, 2000, 11.69, '9780439139601', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (56, NULL, 'Harry Potter and the Order of the Phoenix', 'Harry Potter is due to start his fifth year at Hogwarts School of Witchcraft and Wizardry. He is desperate to get back to school and find out why his friends Ron and Hermione have been so secretive all summer.', 766, 2003, 14.99, '9781338299182', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (57, NULL, 'Harry Potter and the Half-Blood Prince', 'The war against Voldemort is not going well; even the Muggles have been affected. Dumbledore is absent from Hogwarts for long stretches of time, and the Order of the Phoenix has already suffered losses. And yet . . . As with all wars, life goes on. Sixth-year students learn to Apparate.', 607, 2005, 12.99, '0-7475-8108-8', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (58, NULL, 'Harry Potter and the Deathly Hallows', 'After years of battling against the evil Lord Voldemort, 17-year-old Harry Potter is finally an adult wizard, and he and his best friends Ron Weasley and Hermione Granger must set out on a dangerous mission to stop Voldemort once and for all.', 607, 2007, 9.98, '0545139708', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (51, 'https://m.media-amazon.com/images/I/41Ci-WtNGWL._SY344_BO1,204,203,200_.jpg', 'No Longer Human', 'The poignant and fascinating story of a young man who is caught between the breakup of the traditions of a northern Japanese aristocratic family and the impact of Western ideas.', 616, 2019, 30.25, '1974707091', 1, 51);

COMMIT;


-- -----------------------------------------------------
-- Data for table `genre`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `genre` (`id`, `name`, `image_url`) VALUES (1, 'Science fiction', NULL);
INSERT INTO `genre` (`id`, `name`, `image_url`) VALUES (2, 'Drama', NULL);
INSERT INTO `genre` (`id`, `name`, `image_url`) VALUES (3, 'Non-fiction', NULL);
INSERT INTO `genre` (`id`, `name`, `image_url`) VALUES (4, 'Fiction', NULL);
INSERT INTO `genre` (`id`, `name`, `image_url`) VALUES (5, 'Romance', NULL);
INSERT INTO `genre` (`id`, `name`, `image_url`) VALUES (6, 'Action', NULL);
INSERT INTO `genre` (`id`, `name`, `image_url`) VALUES (7, 'Mystery', NULL);

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
INSERT INTO `book_review` (`rating`, `review`, `create_date`, `last_update`, `book_id`, `user_id`) VALUES (9, 'Awesome read', '2023-03-19', '2023-03-19', 2, 1);

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

