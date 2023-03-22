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
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (1, 'Orson Scott', 'https://m.media-amazon.com/images/M/MV5BODU4ZTczOGUtOWMyZC00MDQzLTkzOWItMWQ2NmM0YzZjMDEwXkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg', 'Orson Scott Card was born in Richland in the state of Washington. He has also lived in California, Arizona, and Utah. He is a member of The Church of Jesus Christ of Latter-day Saints and served a two year mission for The Church in Brazil. He received a degree from Brigham Young University in 1975 and a degree from the University of Utah in 1981.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (2, 'JK Rowling', 'https://www.imdb.com/name/nm0746830/mediaviewer/rm944604928/?ref_=nm_ov_ph', 'Joanne Rowling was born in Yate, near Bristol, a few miles south of a town called Dursley (\"Harry Potter\"\'s Muggle-family). Her father Peter Rowling was an engineer for Rolls Royce in Bristol at this time. Her mother, Anne, was half-French and half-Scottish. They met on a train as it left King\'s Cross Station in London. Her sister Diana is about 2 years younger than Joanne. In 1971, Peter Rowling moved his family to the nearby village of Winterbourne (still in the Bristol vicinity). During the family\'s residence in Winterbourne, Jo and Di Rowling were friends with neighborhood children, Ian and Vikki Potter. In 1974, the Rowling family moved yet again, this time to Tutshill, near the Welsh border-town of Chepstow in the Forest of Dean and across the Severn River from the greater Bristol area. Rowling admits to having been a bit of a daydreamer as a child and began writing stories at the age of six. After leaving Exeter University, where she read French and Classics, she started work as a teacher but daydreamed about becoming a writer. One day, stuck on a delayed train for four hours between Manchester and London, she dreamed up a boy called \"Harry Potter\". That was in 1990. It took her six years to write the book. In the meantime, she went to teach in Portugal, married a Portuguese television journalist, had her daughter, Jessica, divorced her husband and returned to Britain when Jessica was just three months old. She went to live in Edinburgh to be near her sister, Di. Her sudden penury made her realize that it was \"back-against-the-wall time\" and she decided to finish her \"Harry Potter\" book. She sent the manuscript to two agents and one publisher, looking up likely prospects in the library. One of these agents that she picked at random based on the fact that she liked his name, Christopher Little, was immediately captivated by the manuscript and signed her on as his client within three days. During the 1995-1996 time-frame, while hoping to get the manuscript for \"Harry Potter & The Philosopher\'s Stone\" published, Rowling worked as a French teacher in Edinburgh. Several publishers turned down the manuscript before Bloomsbury agreed to purchase it in 1996.\n');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (3, 'Shusaku Endo', 'https://images.gr-assets.com/authors/1242087808p8/14164.jpg', 'Shusaku Endo (遠藤周作), born in Tokyo in 1923, was raised by his mother and an aunt in Kobe where he converted to Roman Catholicism at the age of eleven. At Tokyo\'s Keio University he majored in French literature, graduating BA in 1949, before furthering his studies in French Catholic literature at the University of Lyon in France between 1950 and 1953. A major theme running through his books, which have been translated into many languages, including English, French, Russian and Swedish, is the failure of Japanese soil to nurture the growth of Christianity. Before his death in 1996, Endo was the recipient of a number of outstanding Japanese literary awards: the Akutagawa Prize, Mainichi Cultural Prize, Shincho Prize, and Tanizaki Prize.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (4, 'H.P Lovecraft', 'https://upload.wikimedia.org/wikipedia/commons/1/10/H._P._Lovecraft%2C_June_1934.jpg', 'Howard Phillips Lovecraft was an American writer of weird, science, fantasy, and horror fiction. He is best known for his creation of the Cthulhu Mythos.[a]  Born in Providence, Rhode Island, Lovecraft spent most of his life in New England. After his father\'s institutionalization in 1893, he lived affluently until his family\'s wealth dissipated after the death of his grandfather. Lovecraft then lived with his mother, in reduced financial security, until her institutionalization in 1919. He began to write essays for the United Amateur Press Association, and in 1913 wrote a critical letter to a pulp magazine that ultimately led to his involvement in pulp fiction. He became active in the speculative fiction community and was published in several pulp magazines. Lovecraft moved to New York City, marrying Sonia Greene in 1924, and later became the center of a wider group of authors known as the \"Lovecraft Circle\". They introduced him to Weird Tales, which would become his most prominent publisher. Lovecraft\'s time in New York took a toll on his mental state and financial conditions. He returned to Providence in 1926 and produced some of his most popular works, including The Call of Cthulhu, At the Mountains of Madness, The Shadow over Innsmouth, and The Shadow Out of Time. He would remain active as a writer for 11 years until his death from intestinal cancer at the age of 46.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (5, 'Julius Evola', 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Evola.jpg/195px-Evola.jpg', 'Giulio Cesare Andrea \"Julius\" Evola was an Italian philosopher, poet, painter, esotericist, and radical-right ideologue. Evola regarded his values as aristocratic, monarchist, masculine, traditionalist, heroic, and defiantly reactionary. An eccentric thinker in Fascist Italy, he also had ties to Nazi Germany; in the post-war era, he was known as an ideological mentor of the Italian neo-fascist and militant right.\n\nEvola was born in Rome. He served as an artillery officer in the First World War. He became a Dada artist but gave up painting in his twenties. He said he considered suicide until he had a revelation while reading a Buddhist text. In the 1920s he delved into the occult; he wrote on Western esotericism and of Eastern mysticism, developing his doctrine of \"magical idealism\".');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (6, 'Plato', 'https://images.saymedia-content.com/.image/t_share/MTgwMDE1OTM1MjA4NjI5Mzcw/the-ancient-greek-philosopher-plato-his-life-and-works.jpg', 'Plato was an ancient Greek philosopher born in Athens during the Classical period in Ancient Greece. In Athens, Plato founded the Academy, a philosophical school where he taught the philosophical doctrines that would later became known as Platonism. Plato (or Platon) was a pen name derived from his nickname given to him by his wrestling coach – allegedly a reference to his physical broadness. According to Alexander of Miletus quoted by Diogenes of Sinope his actual name was Aristocles, son of Ariston, of the deme Collytus.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (7, 'Marcus Aurelius', 'https://hips.hearstapps.com/hmg-prod/images/marcus-aurelius-gettyimages-122316830.jpg', 'Marcus Aurelius Antoninus was Roman emperor from 161 to 180 AD and a Stoic philosopher. He was the last of the rulers known as the Five Good Emperors  and the last emperor of the Pax Romana, an age of relative peace, calmness and stability for the Roman Empire lasting from 27 BC to 180 AD. He served as Roman consul in 140, 145, and 161.\nMarcus Aurelius was born during the reign of Hadrian to the emperor\'s nephew, the praetor Marcus Annius Verus, and the heiress Domitia Calvilla. His father died when he was three, and his mother and grandfather raised him. After Hadrian\'s adoptive son, Aelius Caesar, died in 138, the emperor adopted Marcus\'s uncle Antoninus Pius as his new heir. In turn, Antoninus adopted Marcus and Lucius, the son of Aelius. Hadrian died that year, and Antoninus became emperor. Now heir to the throne, Marcus studied Greek and Latin under tutors such as Herodes Atticus and Marcus Cornelius Fronto. He married Antoninus\' daughter Faustina in 145.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (8, 'Dante Alighieri', 'https://www.worldhistory.org/img/r/p/500x600/10259.jpg?v=1662636785', 'Dante Alighieri, probably baptized Durante di Alighiero degli Alighieri and often referred to as Dante, was an Italian poet, writer and philosopher. His Divine Comedy, originally called Comedìa and later christened Divina by Giovanni Boccaccio, is widely considered one of the most important poems of the Middle Ages and the greatest literary work in the Italian language.\nDante is known for establishing the use of the vernacular in literature at a time when most poetry was written in Latin, which was accessible only to educated readers. His De vulgari eloquentia was one of the first scholarly defenses of the vernacular. His use of the Florentine dialect for works such as The New Life (1295) and Divine Comedy helped establish the modern-day standardized Italian language. His work set a precedent that important Italian writers such as Petrarch and Boccaccio would later follow.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (9, 'Dale Carnegie', 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTMfBZ2QntBqsFSp9wJ0sJLZF6X0_rW2Q5MWOHyTBLZgXP5z_mA', 'Dale Carnegie was an American writer and lecturer, and the developer of courses in self-improvement, salesmanship, corporate training, public speaking, and interpersonal skills. Born into poverty on a farm in Missouri, he was the author of How to Win Friends and Influence People (1936), a bestseller that remains popular today. He also wrote How to Stop Worrying and Start Living (1948), Lincoln the Unknown (1932), and several other books.\nOne of the core ideas in his books is that it is possible to change other people\'s behavior by changing one\'s behavior towards them.\n');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (10, 'Fyodor Dostoyevsky', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Vasily_Perov_-_%D0%9F%D0%BE%D1%80%D1%82%D1%80%D0%B5%D1%82_%D0%A4.%D0%9C.%D0%94%D0%BE%D1%81%D1%82%D0%BE%D0%B5%D0%B2%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_-_Google_Art_Project.jpg/240px-Vasily_Perov_-_%D0%9F%D0%BE%D1%80%D1%82%D1%80%D0%B5%D1%82_%D0%A4.%D0%9C.%D0%94%D0%BE%D1%81%D1%82%D0%BE%D0%B5%D0%B2%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_-_Google_Art_Project.jpg', 'Born in Moscow in 1821, Dostoevsky was introduced to literature at an early age through fairy tales and legends, and through books by Russian and foreign authors. His mother died in 1837 when he was 15, and around the same time, he left school to enter the Nikolayev Military Engineering Institute. After graduating, he worked as an engineer and briefly enjoyed a lavish lifestyle, translating books to earn extra money. In the mid-1840s he wrote his first novel, Poor Folk, which gained him entry into Saint Petersburg\'s literary circles. However, he was arrested in 1849 for belonging to a literary group, the Petrashevsky Circle, that discussed banned books critical of Tsarist Russia. Dostoevsky was sentenced to death but the sentence was commuted at the last moment. He spent four years in a Siberian prison camp, followed by six years of compulsory military service in exile. In the following years, Dostoevsky worked as a journalist, publishing and editing several magazines of his own and later A Writer\'s Diary, a collection of his writings. He began to travel around western Europe and developed a gambling addiction, which led to financial hardship. For a time, he had to beg for money, but he eventually became one of the most widely read and highly regarded Russian writers.\n');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (12, 'George Orwell', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/George_Orwell_press_photo.jpg/220px-George_Orwell_press_photo.jpg', 'Eric Arthur Blair , better known by his pen name George Orwell, was an English novelist, essayist, journalist, and critic.[1] His work is characterised by lucid prose, social criticism, opposition to totalitarianism, and support of democratic socialism.\nOrwell produced literary criticism, poetry, fiction and polemical journalism. He is known for the allegorical novella Animal Farm (1945) and the dystopian novel Nineteen Eighty-Four (1949). His non-fiction works, including The Road to Wigan Pier (1937), documenting his experience of working-class life in the industrial north of England, and Homage to Catalonia (1938), an account of his experiences soldiering for the Republican faction of the Spanish Civil War (1936–1939), are as critically respected as his essays on politics, literature, language and culture.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (16, 'Sir Thomas More', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Hans_Holbein%2C_the_Younger_-_Sir_Thomas_More_-_Google_Art_Project.jpg/220px-Hans_Holbein%2C_the_Younger_-_Sir_Thomas_More_-_Google_Art_Project.jpg', 'Sir Thomas More (7 February 1478 – 6 July 1535), venerated in the Catholic Church as Saint Thomas More, was an English lawyer, judge, social philosopher, author, statesman, and noted Renaissance humanist. He also served Henry VIII as Lord High Chancellor of England from October 1529 to May 1532. He wrote Utopia, published in 1516, which describes the political system of an imaginary island state.\nMore opposed the Protestant Reformation, directing polemics against the theology of Martin Luther, Huldrych Zwingli, John Calvin and William Tyndale. More also opposed Henry VIII\'s separation from the Catholic Church, refusing to acknowledge Henry as supreme head of the Church of England and the annulment of his marriage to Catherine of Aragon. After refusing to take the Oath of Supremacy, he was convicted of treason and executed. On his execution, he was reported to have said: \"I die the King\'s good servant, and God\'s first\".\nPope Pius XI canonised More in 1935 as a martyr. Pope John Paul II in 2000 declared him the patron saint of statesmen and politicians.\n');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (17, 'Seneca', 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Duble_herma_of_Socrates_and_Seneca_Antikensammlung_Berlin_07.jpg/220px-Duble_herma_of_Socrates_and_Seneca_Antikensammlung_Berlin_07.jpg', 'Lucius Annaeus Seneca the Younger (4 BC – 65 AD), usually known mononymously as Seneca, was a Stoic philosopher of Ancient Rome, a statesman, dramatist, and, in one work, satirist, from the post-Augustan age of Latin literature.\nSeneca was born in Córdoba in Hispania, and raised in Rome, where he was trained in rhetoric and philosophy. His father was Seneca the Elder, his elder brother was Lucius Junius Gallio Annaeanus, and his nephew was the poet Lucan. In AD 41, Seneca was exiled to the island of Corsica under emperor Claudius, but was allowed to return in 49 to become a tutor to Nero. When Nero became emperor in 54, Seneca became his advisor and, together with the praetorian prefect Sextus Afranius Burrus, provided competent government for the first five years of Nero\'s reign. Seneca\'s influence over Nero declined with time, and in 65 Seneca was forced to take his own life for alleged complicity in the Pisonian conspiracy to assassinate Nero, in which he was probably innocent. His stoic and calm suicide has become the subject of numerous paintings.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (18, 'Aldous Huxley', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Aldous_Huxley_psychical_researcher.png/220px-Aldous_Huxley_psychical_researcher.png', 'Aldous Leonard Huxley (26 July 1894 – 22 November 1963) was an English writer and philosopher. His bibliography spans nearly 50 books, including novels and non-fiction works, as well as essays, narratives, and poems.\nBorn into the prominent Huxley family, he graduated from Balliol College, Oxford, with an undergraduate degree in English literature. Early in his career, he published short stories and poetry and edited the literary magazine Oxford Poetry, before going on to publish travel writing, satire, and screenplays. He spent the latter part of his life in the United States, living in Los Angeles from 1937 until his death. By the end of his life, Huxley was widely acknowledged as one of the foremost intellectuals of his time. He was nominated for the Nobel Prize in Literature nine times, and was elected Companion of Literature by the Royal Society of Literature in 1962.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (22, 'Aleksandr Solzhenitsyn', 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Aleksandr_Solzhenitsyn_1974crop.jpg/220px-Aleksandr_Solzhenitsyn_1974crop.jpg', 'Aleksandr Isayevich Solzhenitsyn (11 December 1918 – 3 August 2008) was a Russian novelist. A prominent Soviet dissident, Solzhenitsyn was an outspoken critic of communism and helped to raise global awareness of political repression in the Soviet Union, in particular the Gulag system.\nSolzhenitsyn was born into a family that defied the Soviet anti-religious campaign in the 1920s and remained devout members of the Russian Orthodox Church. However, Solzhenitsyn lost his faith in Christianity, became an atheist, and embraced Marxism–Leninism. While serving as a captain in the Red Army during World War II, Solzhenitsyn was arrested by the SMERSH and sentenced to eight years in the Gulag and then internal exile for criticizing Soviet leader Joseph Stalin in a private letter. As a result of his experience in prison and the camps, he gradually became a philosophically-minded Eastern Orthodox Christian.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (23, 'Alexandre Dumas', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Alexander_Dumas_p%C3%A8re_par_Nadar_-_Google_Art_Project.jpg/220px-Alexander_Dumas_p%C3%A8re_par_Nadar_-_Google_Art_Project.jpg', 'Alexandre Dumas born Dumas Davy de la Pailleterie , 24 July 1802 – 5 December 1870), also known as Alexandre Dumas père (where père is French for \'father\', to distinguish him from his son Alexandre Dumas fils), was a French novelist and playwright. His works have been translated into many languages and he is one of the most widely read French authors. Many of his historical novels of adventure were originally published as serials, including The Count of Monte Cristo, The Three Musketeers, Twenty Years After and The Vicomte of Bragelonne: Ten Years Later. His novels have been adapted since the early twentieth century into nearly 200 films.\nProlific in several genres, Dumas began his career by writing plays, which were successfully produced from the first. He also wrote numerous magazine articles and travel books; his published works totalled 100,000 pages. In the 1840s, Dumas founded the Théâtre Historique in Paris.\nHis father, General Thomas-Alexandre Dumas Davy de la Pailleterie, was born in the French colony of Saint-Domingue (present-day Haiti) to Alexandre Antoine Davy de la Pailleterie, a French nobleman, and Marie-Cessette Dumas, an African slave. At age 14, Thomas-Alexandre was taken by his father to France, where he was educated in a military academy and entered the military for what became an illustrious career.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (24, 'Eric Matthes', 'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/51OOCVBfCQL._SX218_BO1,204,203,200_QL40_FMwebp_.jpg', 'Eric Matthews grew up in Nashua, NH. Nashua feels like a suburb of Boston, but in the late 1970s and early 1980s I could hop on my bike with a friend and explore back roads through small towns for entire summer days. I went to college at UNH, where I studied physics because I wanted to understand how the Universe works at the most fundamental levels. I wanted to be a particle physicist, but I didn’t want to be a student until I was 30, so I looked for something else to try. I loved my experiences tutoring other math and science students, so I gave teaching a try. I found the challenges of trying to reach every student in a class as intellectually stimulating as hard science, and even more satisfying.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (25, 'Mahmoud Al-Batal', 'https://www.arabichonorsociety.com/sites/default/files/styles/board_photo/public/board-member/Mahmoud%20Al-Batal.jpg?itok=TnoTfUt1', 'Dr. Al-Batal is a specialist in language pedagogy and his research focuses in particular on the theories and practices of Teaching Arabic as a Foreign Language (TAFL). He has published in the areas of Applied Linguistics, Discourse Analysis and Pragmatics, and is a co-author of Al-KitaabArabic textbook series. He has recently finished editing a volume titled Arabic as One Language: Integrating Dialect in the Arabic FL Curriculum. This volume will come out in Fall 2017 and will be published by Georgetown University Press. Dr. Al-Batal has contributed two chapters to this volume: “Dialect Integration in the Arabic Foreign Language Curriculum: Vision, Rationale, and Models,” and “Dialect Integration: Students’ Perspectives within an Integrated Program” with Christian Glakas. In addition, he has contributed a chapter on the theory and practice of teaching the listening skill in TAFL to a volume published by King Abdulla Center for Arabic in Riyadh, Saudi Arabic.Dr. Al-Batal is currently working on a research project aimed at analyzing the negative attitudes of college-level Arab students towards Arabic and the extent to which these attitudes could be reversed through alternative pedagogies of teaching Arabic t aligned with principles of learner-centered and content-based teaching.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (26, 'John Milton', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/John-milton.jpg/220px-John-milton.jpg', 'John Milton (9 December 1608 – 8 November 1674) was an English poet and intellectual. His 1667 epic poem Paradise Lost, written in blank verse and including over ten chapters, was written in a time of immense religious flux and political upheaval. It addressed the fall of man, including the temptation of Adam and Eve by the fallen angel Satan and God\'s expulsion of them from the Garden of Eden. Paradise Lost elevated Milton\'s reputation as one of history\'s greatest poets. He also served as a civil servant for the Commonwealth of England under its Council of State and later under Oliver Cromwell.\nMilton achieved fame and recognition during his lifetime, his celebrated Areopagitica (1644), written in condemnation of pre-publication censorship, is among history\'s most influential and impassioned defences of freedom of speech and freedom of the press. His desire for freedom extended beyond his philosophy and was reflected in his style, which included his introduction of new words (coined from Latin and Ancient Greek) to the English language. He was the first modern writer to employ unrhymed verse outside of the theatre or translations.\n');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (28, 'Philip K. Dick', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Philip_K_Dick_in_early_1960s_%28photo_by_Arthur_Knight%29_%28cropped%29.jpg/220px-Philip_K_Dick_in_early_1960s_%28photo_by_Arthur_Knight%29_%28cropped%29.jpg', 'Philip Kindred Dick (December 16, 1928 – March 2, 1982), often referred to by his initials PKD, was an American science fiction writer. He wrote 44 novels and about 121 short stories, most of which appeared in science fiction magazines during his lifetime. His fiction explored varied philosophical and social questions such as the nature of reality, perception, human nature, and identity, and commonly featured characters struggling against elements such as alternate realities, illusory environments, monopolistic corporations, drug abuse, authoritarian governments, and altered states of consciousness.\nBorn in Chicago, Dick moved to the San Francisco Bay Area with his family at a young age. He began publishing science fiction stories in 1952, at age 23. He found little commercial success until his alternative history novel The Man in the High Castle (1962) earned him acclaim, including a Hugo Award for Best Novel, when he was 33. He followed with science fiction novels such as Do Androids Dream of Electric Sheep? (1968) and Ubik (1969). His 1974 novel Flow My Tears, the Policeman Said won the John W. Campbell Memorial Award for Best Science Fiction Novel.\n');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (29, 'Dashiell Hammett', 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Dashiell_Hammett_%22Thin_Man%22_portrait_%28cropped%29.jpg/220px-Dashiell_Hammett_%22Thin_Man%22_portrait_%28cropped%29.jpg', 'Samuel Dashiell Hammett (May 27, 1894 – January 10, 1961) was an American writer of hard-boiled detective novels and short stories. He was also a screenwriter and political activist. Among the enduring characters he created are Sam Spade (The Maltese Falcon), Nick and Nora Charles (The Thin Man), The Continental Op (Red Harvest and The Dain Curse) and the comic strip character Secret Agent X-9.\nHammett \"is now widely regarded as one of the finest mystery writers of all time\". In his obituary in The New York Times, he was described as \"the dean of the... \'hard-boiled\' school of detective fiction.\" Time included Hammett\'s 1929 novel Red Harvest on its list of the 100 best English-language novels published between 1923 and 2005. In 1990, the Crime Writers\' Association picked three of his five novels for their list of The Top 100 Crime Novels of All Time. Five years later, four out of five of his novels made The Top 100 Mystery Novels of All Time as selected by the Mystery Writers of America. His novels and stories also had a significant influence on films, including the genres of private eye/detective fiction, mystery thrillers, and film noir.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (30, 'Terrence McKenna', 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Mckenna1.jpg', 'Terence Kemp McKenna (November 16, 1946 – April 3, 2000) was an American ethnobotanist and mystic who advocated the responsible use of naturally occurring psychedelic plants. He spoke and wrote about a variety of subjects, including psychedelic drugs, plant based entheogens, shamanism, metaphysics, alchemy, language, philosophy, culture, technology, environmentalism, and the theoretical origins of human consciousness. He was called the \"Timothy Leary of the \'90s\", \"one of the leading authorities on the ontological foundations of shamanism\", and the \"intellectual voice of rave culture\". \nMcKenna formulated a concept about the nature of time based on fractal patterns he claimed to have discovered in the I Ching, which he called novelty theory,[3][5] proposing that this predicted the end of time, and a transition of consciousness in the year 2012. His promotion of novelty theory and its connection to the Maya calendar is credited as one of the factors leading to the widespread beliefs about the 2012 phenomenon. Novelty theory is considered pseudoscience.\n');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (31, 'Jocko Willink', 'https://upload.wikimedia.org/wikipedia/commons/f/ff/Jocko-Willink-SEAL.jpg', 'John Gretton \"Jocko\" Willink (born September 8, 1971) is an American author, podcaster, and retired United States Navy officer who served in the Navy SEALs and is a former member of SEAL Team 3.\nWillink\'s military service includes combat actions in the Iraq War, where he commanded SEAL Team 3\'s Task Unit Bruiser, the unit that fought in the battle against the Iraqi insurgents in Ramadi. Willink was honored with the Silver Star and Bronze Star Medal for his service. He achieved the rank of lieutenant commander.\nWillink co-authored the books Extreme Ownership and The Dichotomy of Leadership (with fellow retired SEAL Leif Babin) and co-founded the management consulting firm Echelon Front, LLC. Willink hosts a weekly podcast with Brazilian jiu-jitsu practitioner Echo Charles, called the Jocko Podcast. He holds a B.A. in English from the University of San Diego.\n');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (32, 'Hezi Brosh', 'https://media.licdn.com/dms/image/C5622AQHpRPtzpiKDIQ/feedshare-shrink_800/0/1552939873352?e=2147483647&v=beta&t=iVvoAGzBuophreuqcDmvubKG3VnYZ_LX0T8k7mJfdEg', 'Hezi Brosh, Ph.D., currently the Arabic Program Coordinator at the United States Naval Academy is an educator and researcher with decades of experience teaching Arabic. His innovative teaching materials on Arabic as a foreign language have benefited thousands of learners and teachers. He has worked in many educational institutions in the Middle East and North America, ranging from junior high school to university level. His specialization area is Second Language Acquisition, focusing on Arabic teaching and learning as a foreign language. He has published widely on Arabic pedagogy and significantly contributed to curriculum planning and development.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (33, 'Friedrick Nietzsche', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Nietzsche187a.jpg/220px-Nietzsche187a.jpg', 'Friedrich Wilhelm Nietzsche was a German philosopher, prose poet, cultural critic, philologist, and composer whose work has exerted a profound influence on contemporary philosophy. He began his career as a classical philologist before turning to philosophy. He became the youngest person ever to hold the Chair of Classical Philology at the University of Basel in 1869 at the age of 24. Nietzsche resigned in 1879 due to health problems that plagued him most of his life; he completed much of his core writing in the following decade. In 1889, at age 44, he suffered a collapse and afterward a complete loss of his mental faculties, with paralysis and probably vascular dementia. He lived his remaining years in the care of his mother until her death in 1897 and then with his sister Elisabeth Förster-Nietzsche. Nietzsche died in 1900, after experiencing pneumonia and multiple strokes.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (34, 'Philip Zimbardo', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Philip_Zimbardo_%28cropped%29.jpg/220px-Philip_Zimbardo_%28cropped%29.jpg', 'Philip George Zimbardo is an American psychologist and a professor emeritus at Stanford University. He became known for his 1971 Stanford prison experiment, which was later severely criticized for both ethical and scientific reasons. He has authored various introductory psychology textbooks for college students, and other notable works, including The Lucifer Effect, The Time Paradox, and The Time Cure. He is also the founder and president of the Heroic Imagination Project.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (35, 'Sylvain Neuvel', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/Sylvain_Neuvel_by_Gage_Skidmore.jpg/220px-Sylvain_Neuvel_by_Gage_Skidmore.jpg', 'Sylvain Neuvel is a Canadian science fiction writer, known as the author of The Themis Files. He was born in Quebec City and raised in the suburb of L\'Ancienne-Lorette. Neuvel was educated at the Université de Montréal and the University of Chicago, and runs his own professional translation agency.\nThe Themis Files trilogy begins with his debut novel Sleeping Giants. It follows a group of scientists, led by a physicist named Rose Franklin, as they track down and assemble a giant robot of mysterious origins, scattered across the Earth. The idea for Sleeping Giants first came to him when his son asked him to build a toy robot. Not just any toy robot, he wanted one with an extended back story, wanted to know where the robot came from and what it did. The novel is written in an atypical format, laid out in back-and-forth dialogues, journal entries and documentation rather than through traditional narration. ');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (36, 'Robert Coram', 'https://m.media-amazon.com/images/S/amzn-author-media-prod/82rlksbb2mubm79oc85t1vg1db._SX450_.jpg', 'Robert Coram’s career as a writer began in Edison, GA, a town of about 1200 located deep in the southwestern part of the state. Edison is a farming town. Most young people leave as soon as possible and take up a variety of careers. Coram is the only person from Edison ever to become a professional writer.\n\nCoram was hired as a reporter for The Atlanta Journal when he was a sophomore in college. Like many who suddenly discover their life’s work, he was enthusiastic and prolific. He was a general assignment reporter but also wrote features, book reviews, travel stories, and aviation stories. He covered the civil rights movement in Atlanta during the 1960s and he wrote freelance magazine articles; first for the then-new Atlanta Magazine, then for aviation publications, then for national magazines.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (37, 'Yuval Noah Harari', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Yuval_Noah_Harari_cropped.jpg/220px-Yuval_Noah_Harari_cropped.jpg', 'Yuval Noah Harari (Hebrew: יובל נח הררי [juˈval ˈnoaχ haˈʁaʁi]; born 1976) is an Israeli public intellectual, historian and professor in the Department of History at the Hebrew University of Jerusalem. He is the author of the popular science bestsellers Sapiens: A Brief History of Humankind (2014), Homo Deus: A Brief History of Tomorrow (2016), and 21 Lessons for the 21st Century (2018). His writings examine free will, consciousness, intelligence, happiness, and suffering.\nHarari writes about a \"cognitive revolution\" that supposedly occurred roughly 70,000 years ago when Homo sapiens supplanted the rival Neanderthals and other species of the genus Homo, developed language skills and structured societies, and ascended as apex predators, aided by the agricultural revolution and accelerated by the scientific revolution, which have allowed humans to approach near mastery over their environment. His books also examine the possible consequences of a futuristic biotechnological world in which intelligent biological organisms are surpassed by their own creations; he has said, \"Homo sapiens as we know them will disappear in a century or so\".\nIn Sapiens: A Brief History of Humankind, Harari surveys human history from the evolutionary emergence of Homo sapiens to 21st-century political and technological revolutions. The book is based on his lectures to an undergraduate world history class.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (38, 'Richard Evelyn Byrd', 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Richard_E._Byrd_cph.3b17378.jpg/220px-Richard_E._Byrd_cph.3b17378.jpg', 'Richard Evelyn Byrd Jr. (October 25, 1888 – March 11, 1957) was an American naval officer and explorer. He was a recipient of the Medal of Honor, the highest honor for valor given by the United States, and was a pioneering American aviator, polar explorer, and organizer of polar logistics. Aircraft flights in which he served as a navigator and expedition leader crossed the Atlantic Ocean, a segment of the Arctic Ocean, and a segment of the Antarctic Plateau. Byrd said that his expeditions had been the first to reach both the North Pole and the South Pole by air. His belief to have reached the North Pole is disputed. He is also known for discovering Mount Sidley, the largest dormant volcano in Antarctica.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (39, 'Niccolo Machiavelli', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Portrait_of_Niccol%C3%B2_Machiavelli.jpg/220px-Portrait_of_Niccol%C3%B2_Machiavelli.jpg', 'Niccolò di Bernardo dei Machiavelli, was an Italian diplomat, author, philosopher and historian who lived during the Renaissance. He is best known for his political treatise The Prince (Il Principe), written around 1513 but not published until 1532. He has often been called the father of modern political philosophy and political science.\nFor many years he served as a senior official in the Florentine Republic with responsibilities in diplomatic and military affairs. He wrote comedies, carnival songs, and poetry. His personal correspondence is also important to historians and scholars of Italian correspondence. He worked as secretary to the Second Chancery of the Republic of Florence from 1498 to 1512, when the Medici were out of power.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (40, 'Liao Yiwu', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Liao_Yiwu_2010_Cologne.jpg/220px-Liao_Yiwu_2010_Cologne.jpg', 'Liao Yiwu is a Chinese author, reporter, musician, and poet. He is a critic of China\'s Communist regime, for which he was imprisoned in 1990. His books, several of which are collections of interviews with ordinary people from the lower rungs of Chinese society, were published in Taiwan and Hong Kong but are banned in mainland China; some have been translated into Spanish, English, French, German, Polish and Czech. He has been living in Germany since April 2011.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (41, 'Homer', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/Homer_British_Museum.jpg/220px-Homer_British_Museum.jpg', 'Homer was a Greek poet who is credited as the author of the Iliad and the Odyssey, two epic poems that are foundational works of ancient Greek literature. Homer is considered one of the most revered and influential authors in history.\nHomer\'s Iliad centers on a quarrel between King Agamemnon and the warrior Achilles during the last year of the Trojan War. The Odyssey chronicles the ten-year journey of Odysseus, king of Ithaca, back to his home after the fall of Troy. The poems are in Homeric Greek, also known as Epic Greek, a literary language which shows a mixture of features of the Ionic and Aeolic dialects from different centuries; the predominant influence is Eastern Ionic. Most researchers believe that the poems were originally transmitted orally.\n');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (42, 'Padmasambhava', 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Guru_-_Boudha.jpg/200px-Guru_-_Boudha.jpg', 'Padmasambhava (\"Born from a Lotus\"), also known as Guru Rinpoche (Precious Guru) and the Lotus from Oḍḍiyāna, was a tantric Buddhist Vajra master from India who taught Vajrayana in Tibet (circa 8th – 9th centuries).[1][2][3][4] According to some early Tibetan sources like the Testament of Ba, he came to Tibet in the 8th century and helped construct Samye Monastery, the first Buddhist monastery in Tibet. However, little is known about the actual historical figure other than his ties to Vajrayana and Indian Buddhism.\nPadmasambhava later came to be viewed as a central figure in the transmission of Buddhism to Tibet. Starting from around the 12th century, hagiographies concerning Padmasambhava were written. These works expanded the profile and activities of Padmasambhava, now seen as taming all the Tibetan spirits and gods, and concealing various secret texts (terma) for future tertöns. Nyangral Nyima Özer (1124–1192) was the author of the Zangling-ma (Jeweled Rosary), the earliest biography of Padmasambhava. He has been called \"one of the main architects of the Padmasambhava mythos – who first linked Padmasambhava to the Great Perfection in a high-profile manner.\"\n\n');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (43, 'Karl Marx', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Karl_Marx_001.jpg/220px-Karl_Marx_001.jpg', 'Karl Heinrich Marx was a German philosopher, economist, historian, sociologist, political theorist, journalist, critic of political economy, and socialist revolutionary. His best-known titles are the 1848 pamphlet The Communist Manifesto and the four-volume Das Kapital (1867–1883). Marx\'s political and philosophical thought had enormous influence on subsequent intellectual, economic, and political history. His name has been used as an adjective, a noun, and a school of social theory.\nBorn in Trier, Germany, Marx studied law and philosophy at the universities of Bonn and Berlin. He married German theatre critic and political activist Jenny von Westphalen in 1843. Due to his political publications, Marx became stateless and lived in exile with his wife and children in London for decades, where he continued to develop his thought in collaboration with German philosopher Friedrich Engels and publish his writings, researching in the British Museum Reading Room.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (45, 'Jean-Paul Sartre', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Sartre_1967_crop.jpg/220px-Sartre_1967_crop.jpg', 'Jean-Paul Charles Aymard Sartre was a French playwright, novelist, screenwriter, political activist, biographer, and literary critic, as well as a leading figure in 20th-century French philosophy and Marxism. Sartre was one of the key figures in the philosophy of existentialism (and phenomenology). His work has influenced sociology, critical theory, post-colonial theory, and literary studies, and continues to do so. He was awarded the 1964 Nobel Prize in Literature despite attempting to refuse it, saying that he always declined official honors and that \"a writer should not allow himself to be turned into an institution.\"\n');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (46, 'Franz Kafka', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Franz_Kafka%2C_1923.jpg/220px-Franz_Kafka%2C_1923.jpg', 'Franz Kafka was a German-speaking Bohemian novelist and short-story writer based in Prague, widely regarded as one of the major figures of 20th-century literature. His work fuses elements of realism and the fantastic. It typically features isolated protagonists facing bizarre or surrealistic predicaments and incomprehensible socio-bureaucratic powers. It has been interpreted as exploring themes of alienation, existential anxiety, guilt, and absurdity. His best known works include the short story \"The Metamorphosis\" and novels The Trial and The Castle. The term Kafkaesque has entered English to describe absurd situations, like those depicted in his writing.\nKafka was born into a middle-class German-speaking Czech Jewish family in Prague, the capital of the Kingdom of Bohemia, then part of the Austro-Hungarian Empire, today the capital of the Czech Republic. He trained as a lawyer and after completing his legal education was employed full-time by an insurance company, forcing him to relegate writing to his spare time. Over the course of his life, Kafka wrote hundreds of letters to family and close friends, including his father, with whom he had a strained and formal relationship. He became engaged to several women but never married. He died in obscurity in 1924 at the age of 40 from tuberculosis.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (49, 'Fanon Frantz', 'https://upload.wikimedia.org/wikipedia/en/thumb/0/0f/Frantz_Fanon.jpg/220px-Frantz_Fanon.jpg', 'Frantz Omar Fanon also known as Ibrahim Frantz Fanon, was a Marxist, French West Indian psychiatrist and political philosopher from the French colony of Martinique (today a French department). His works have become influential in the fields of post-colonial studies, critical theory, and Marxism. As well as being an intellectual, Fanon was a political radical, Pan-Africanist, and Marxist humanist concerned with the psychopathology of colonization and the human, social, and cultural consequences of decolonization.\nIn the course of his work as a physician and psychiatrist, Fanon supported the Algerian War of independence from France and was a member of the Algerian National Liberation Front. Fanon has been described as \"the most influential anticolonial thinker of his time\". For more than five decades, the life and works of Fanon have inspired national liberation movements and other radical political organizations in Palestine, Sri Lanka, South Africa, and the United States. He formulated a model for community psychology, believing that many mental health patients would do better if they were integrated into their family and community instead of being treated with institutionalized care. He also helped found the field of institutional psychotherapy while working at Saint-Alban under Francois Tosquelles and Jean Oury.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (50, 'Peter Kemp', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Service_of_Major_David_Smiley_With_the_Special_Operations_Executive_%28soe%29_in_Albania%2C_1943_-_1944._HU65147.jpg/425px-Service_of_Major_David_Smiley_With_the_Special_Operations_Executive_%28soe%29_in_Albania%2C_1943_-_1944._HU65147.jpg', 'Peter Mant MacIntyre Kemp (19 August 1913 – 30 October 1993) was an English soldier and writer. He became notable for his participation in the Spanish Civil War and, during World War II, as a member of the Special Operations Executive (SOE).\nThe son of a judge in British India, Kemp was educated at Wellington College. He studied classics and law at Trinity College, Cambridge, where he was secretary of the Conservative Association.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (51, 'Junji Ito', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Junji_Ito_-_Lucca_Comics_%26_Games_2018_02.jpg/220px-Junji_Ito_-_Lucca_Comics_%26_Games_2018_02.jpg', 'Junji Ito is a Japanese horror manga artist. Some of his most notable works include Tomie, a series chronicling an immortal girl who drives her stricken admirers to madness; Uzumaki, a three-volume series about a town obsessed with spirals; and Gyo, a two-volume story in which fish are controlled by a strain of sentient bacteria called \"the death stench.\" His other works include The Junji Ito Horror Comic Collection, a collection of his many short stories, and Junji Ito\'s Cat Diary: Yon & Mu, a self-parody about him and his wife living in a house with two cats. Ito\'s work has developed a substantial cult following, with some deeming him a significant figure in recent horror iconography.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (52, 'Thomas Nelson', 'https://d3iqwsql9z4qvn.cloudfront.net/wp-content/uploads/2018/03/23154056/1798-1818-Thomas-Nelson-250x375.png', 'Thomas Nelson is a world leading publisher and provider of Christian content.\n\nWith over 250 new, original books and Bibles published each year and distributed in more than 100 countries, translating content in more than 65 different languages, Thomas Nelson is committed to one central mission: inspiring the world by meeting the needs of people with content that promotes biblical principles and honors Jesus Christ.\n\nToday, Thomas Nelson is also the house of iconic authors, such as Billy Graham, Max Lucado, Dr. David Jeremiah, Lysa TerKeurst, Bob Goff, Sarah Young, Colleen Coble, Dave Ramsey, and Jen Hatmaker, and houses several different imprints, including Tommy Nelson, Nelson Books, W Publishing Group, Emanate Books, NEXT Leadership Network, and Grupo Nelson. As part of HarperCollins Christian Publishing, Inc., the publishing group provides multiple formats of award-winning Bibles, books, gift books, cookbooks, curricula and digital content, with distribution of its products in more than 100 countries.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (53, 'Robert C. Bartlett', 'https://images.gr-assets.com/authors/1590173531p8/15934810.jpg', 'Robert C. Bartlett is Behrakis Professor in Hellenic Political Studies at Boston College and has authored numerous studies on the history of political thought, including recent editions of Aristotle\'s Nicomachean Ethics (with Susan Collins) and the Art of Rhetoric.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (54, 'Albert Camus', 'https://m.media-amazon.com/images/I/61T-yL4GwyL._SX300_CR0%2C0%2C0%2C0_.jpg', 'Albert Camus was a French philosopher, author, and journalist. His views contributed to the rise of the philosophy known as absurdism. He wrote in his essay The Rebel that his whole life was devoted to opposing the philosophy of nihilism while still delving deeply into individual freedom. He won the Nobel Prize in Literature in 1957.');
INSERT INTO `author` (`id`, `name`, `image_url`, `description`) VALUES (55, 'Gabriel Garcia Marquez', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Gabriel_Garcia_Marquez.jpg/200px-Gabriel_Garcia_Marquez.jpg', 'Gabriel José de la Concordia García Márquez was a Colombian novelist, short-story writer, screenwriter, and journalist, known affectionately as Gabo or Gabito throughout Latin America. Considered one of the most significant authors of the 20th century, particularly in the Spanish language, he was awarded the 1972 Neustadt International Prize for Literature and the 1982 Nobel Prize in Literature. He pursued a self-directed education that resulted in leaving law school for a career in journalism. From early on he showed no inhibitions in his criticism of Colombian and foreign politics. In 1958, he married Mercedes Barcha Pardo; they had two sons, Rodrigo and Gonzalo.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book`
-- -----------------------------------------------------
START TRANSACTION;
USE `alexandriaDB`;
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (1, 'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/51hzQWwImUL.jpg', 'Ender\'s Game', 'When hostile aliens called the Formics attack Earth, only the legendary heroics of Mazer Rackham (Ben Kingsley) manage to attain a victory.', 300, 1985, 9.99, '0765337320', 1, 1);
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
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (19, 'https://m.media-amazon.com/images/I/41K1QqtKyNL._SY344_BO1,204,203,200_.jpg', 'The Idiot', 'After his great portrayal of a guilty man in Crime and Punishment, Dostoevsky set out in The Idiot to portray a man of pure innocence. The twenty-six-year-old Prince Myshkin, following a stay of several years in a Swiss sanatorium, returns to Russia to collect an inheritance and \'be among people.\' Even before he reaches home he meets the dark Rogozhin, a rich merchant\'s son whose obsession with the beautiful Nastasya Filippovna eventually draws all three of them into a tragic denouement. In Petersburg the prince finds himself a stranger in a society obsessed with money, power, and manipulation. Scandal escalates to murder as Dostoevsky traces the surprising effect of this \'positively beautiful man\' on the people around him, leading to a final scene that is one of the most powerful in all of world literature.', 656, 1868, 16.29, '375702245', 1, 10);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (20, 'https://m.media-amazon.com/images/I/41novGr34wL._SY344_BO1,204,203,200_.jpg', 'Notes from Underground', 'One of the most remarkable characters in literature, the unnamed narrator of Dostoevsky\'s most revolutionary novel is a former official who has defiantly withdrawn into an underground existence. In full retreat from society, he scrawls a passionate, obsessive, self-contradictory narrative that serves as a devastating attack on social utopianism and an assertion of man\'s essentially irrational nature.', 136, 1864, 12.54, '067973452X', 1, 10);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (21, 'https://m.media-amazon.com/images/I/41WYXBA5mrL._SX320_BO1,204,203,200_.jpg', 'Crime and Punishment', 'When Raskolnikov, an impoverished student living in the St. Petersburg of the tsars, commits an act of murder and theft, he sets into motion a story that is almost unequalled in world literature for its excruciating suspense, its atmospheric vividness, and its depth of characterization and vision. Dostoevsky\'s drama of sin, guilt, and redemption transforms the sordid story of an old woman\'s murder into the nineteenth century\'s profoundest and most compelling philosophical novel.', 565, 1866, 15.99, '679734503', 1, 10);
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
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (52, 'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/61TL8TtafZL._AC_SL1001_.jpg', 'Harry Potter and the Sorcerer\'s Stone', 'An orphaned boy enrolls in a school of wizardry, where he learns the truth about himself, his family and the terrible evil that haunts the magical world.', 456, 1997, 29.99, '9780545582889', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (53, 'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/51-gJbWc3qL._SX338_BO1,204,203,200_.jpg', 'Harry Potter and the Chamber of Secrets', 'The Dursleys were so mean that hideous that summer that all Harry Potter wanted was to get back to the Hogwarts School for Witchcraft and Wizardry. But just as he\'s packing his bags, Harry receives a warning from a strange, impish creature named Dobby who says that if Harry Potter returns to Hogwarts, disaster will strike.', 341, 1998, 6.98, '0439064872', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (54, 'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/91KKUjoqWpL._AC_UY436_FMwebp_QL65_.jpg', 'Harry Potter and the Prisoner of Azkaban', 'Harry Potter & The Prisoner of Azkaban is about Harry\'s 3rd year at Hogwarts. Along with friends Ron and Hermione, Harry investigates the case of Sirius Black, an escaped prisoner from Azkaban, the wizard prison.', 317, 1999, 9.99, '0-7475-4215-5', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (55, 'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/61Me3ePpM9L._SX421_BO1,204,203,200_.jpg', 'Harry Potter and the Goblet of Fire', 'Fourteen-year-old Harry Potter joins the Weasleys at the Quidditch World Cup, then enters his fourth year at Hogwarts Academy where he is mysteriously entered in an unusual contest that challenges his wizarding skills, amid signs that an old enemy is growing stronger.', 752, 2000, 11.69, '9780439139601', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (56, 'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/51bZujlJxlL._SX218_BO1,204,203,200_QL40_FMwebp_.jpg', 'Harry Potter and the Order of the Phoenix', 'Harry Potter is due to start his fifth year at Hogwarts School of Witchcraft and Wizardry. He is desperate to get back to school and find out why his friends Ron and Hermione have been so secretive all summer.', 766, 2003, 14.99, '9781338299182', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (57, 'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/51osIRwPiPL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg', 'Harry Potter and the Half-Blood Prince', 'The war against Voldemort is not going well; even the Muggles have been affected. Dumbledore is absent from Hogwarts for long stretches of time, and the Order of the Phoenix has already suffered losses. And yet . . . As with all wars, life goes on. Sixth-year students learn to Apparate.', 607, 2005, 12.99, '0-7475-8108-8', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (58, 'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/51E7NvVLO9L._SY291_BO1,204,203,200_QL40_FMwebp_.jpg', 'Harry Potter and the Deathly Hallows', 'After years of battling against the evil Lord Voldemort, 17-year-old Harry Potter is finally an adult wizard, and he and his best friends Ron Weasley and Hermione Granger must set out on a dangerous mission to stop Voldemort once and for all.', 607, 2007, 9.98, '0545139708', 1, 2);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (51, 'https://m.media-amazon.com/images/I/41Ci-WtNGWL._SY344_BO1,204,203,200_.jpg', 'No Longer Human', 'The poignant and fascinating story of a young man who is caught between the breakup of the traditions of a northern Japanese aristocratic family and the impact of Western ideas.', 616, 2019, 30.25, '1974707091', 1, 51);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (59, 'https://m.media-amazon.com/images/I/41TtIz6hLWL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg', 'Aristotle\'s Nicomachean Ethics', 'The Nicomachean Ethics is one of Aristotle’s most widely read and influential works. Ideas central to ethics—that happiness is the end of human endeavor, that moral virtue is formed through action and habituation, and that good action requires prudence—found their most powerful proponent in the person medieval scholars simply called “the Philosopher.” Drawing on their intimate knowledge of Aristotle’s thought, Robert C. Bartlett and Susan D. Collins have produced here an English-language translation of the Ethics that is as remarkably faithful to the original as it is graceful in its rendering.', 368, 2012, 12.99, '0226026752', 1, 53);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (60, 'https://m.media-amazon.com/images/I/51yUEnTCyrL._SY291_BO1,204,203,200_QL40_FMwebp_.jpg', 'The Stranger', 'Behind the subterfuge, Camus explores what he termed \"the nakedness of man faced with the absurd\" and describes the condition of reckless alienation and spiritual exhaustion that characterized so much of twentieth-century life. ', 123, 1989, 11.50, '9780679720201', 1, 54);
INSERT INTO `book` (`id`, `cover_url`, `title`, `description`, `pages`, `published_year`, `price`, `isbn`, `language_id`, `author_id`) VALUES (61, 'https://m.media-amazon.com/images/I/41IKS3pzp+L._SY346_.jpg', 'One Hundred Years of Solitude', 'One Hundred Years of Solitude is the story of seven generations of the Buendía Family in the town of Macondo. The founding patriarch of Macondo, José Arcadio Buendía, and Úrsula Iguarán, his wife (and first cousin), leave their hometown in Riohacha, Colombia, after José Arcadio kills Prudencio Aguilar after a cockfight for suggesting José Arcadio was impotent. One night of their emigration journey, while camping on a riverbank, José Arcadio dreams of \"Macondo\", a city of mirrors that reflected the world in and about it. Upon awakening, he decides to establish Macondo at the riverside; after days of wandering the jungle, his founding of Macondo is utopic.', 417, 2006, NULL, '0060883286', 1, 55);

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

