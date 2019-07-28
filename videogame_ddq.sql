
-- Table structures
DROP TABLE IF EXISTS `videogame_platform`;
DROP TABLE IF EXISTS `videogame`;
DROP TABLE IF EXISTS `platform`;
DROP TABLE IF EXISTS `developer`;
DROP TABLE IF EXISTS `publisher`;

CREATE TABLE `developer` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `publisher` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `videogame` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL,
    `developer_id` int,
    `publisher_id` int,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`developer_id`) REFERENCES developer (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`publisher_id`) REFERENCES publisher (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `platform` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL,
    `developer_id` int,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`developer_id`) REFERENCES developer (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `videogame_platform` (
    `videogame_id` int,
    `platform_id` int,
    PRIMARY KEY (`videogame_id`,`platform_id`),
    FOREIGN KEY (`videogame_id`) REFERENCES videogame (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`platform_id`) REFERENCES platform (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Dumping data for tables
INSERT INTO developer (name) 
VALUES ('Nintendo'), ('Sony'), ('Microsoft'), ('Naughty_Dog'), ('Bungie');

INSERT INTO publisher (name) 
VALUES ('Nintendo'), ('Sony'), ('Microsoft');

INSERT INTO videogame (name, developer_id, publisher_id)
VALUES ('Uncharted', (SELECT id FROM developer WHERE name = 'Naughty_Dog'), (SELECT id FROM publisher WHERE name = 'Sony')),
('Super_Mario_Odyssey', (SELECT id FROM developer WHERE name = 'Nintendo'), (SELECT id FROM publisher WHERE name = 'Nintendo')),
('Halo', (SELECT id FROM developer WHERE name = 'Bungie'), (SELECT id FROM publisher WHERE name = 'Microsoft'));

INSERT INTO platform (name, developer_id)
VALUES ('PlayStation', (SELECT id FROM developer WHERE name = 'Sony')),
('Xbox', (SELECT id FROM developer WHERE name = 'Microsoft')),
('Switch', (SELECT id FROM developer WHERE name = 'Nintendo'));

INSERT INTO videogame_platform (videogame_id, platform_id)
VALUES ((SELECT id FROM videogame WHERE name = 'Uncharted'), (SELECT id FROM platform WHERE name = 'PlayStation')),
((SELECT id FROM videogame WHERE name = 'Super_Mario_Odyssey'), (SELECT id FROM platform WHERE name = 'Switch')),
((SELECT id FROM videogame WHERE name = 'Halo'), (SELECT id FROM platform WHERE name = 'Xbox'));
