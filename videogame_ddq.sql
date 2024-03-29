
-- Table structures
DROP TABLE IF EXISTS `game_plat`;
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
    `did` int,
    `pid` int,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`did`) REFERENCES developer (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`pid`) REFERENCES publisher (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `platform` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL,
    `did` int,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`did`) REFERENCES developer (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE `game_plat` (
    `vid` int,
    `plid` int,
    PRIMARY KEY (`vid`,`plid`),
    FOREIGN KEY (`vid`) REFERENCES videogame (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`plid`) REFERENCES platform (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Dumping data for tables
INSERT INTO developer (name) 
VALUES ('Nintendo'), ('Sony'), ('Microsoft'), ('Naughty_Dog'), ('Bungie');

INSERT INTO publisher (name) 
VALUES ('Nintendo'), ('Sony'), ('Microsoft');

INSERT INTO videogame (name, did, pid)
VALUES ('Uncharted', (SELECT id FROM developer WHERE name = 'Naughty_Dog'), (SELECT id FROM publisher WHERE name = 'Sony')),
('Super_Mario_Odyssey', (SELECT id FROM developer WHERE name = 'Nintendo'), (SELECT id FROM publisher WHERE name = 'Nintendo')),
('Halo', (SELECT id FROM developer WHERE name = 'Bungie'), (SELECT id FROM publisher WHERE name = 'Microsoft'));

INSERT INTO platform (name, did)
VALUES ('PlayStation', (SELECT id FROM developer WHERE name = 'Sony')),
('Xbox', (SELECT id FROM developer WHERE name = 'Microsoft')),
('Switch', (SELECT id FROM developer WHERE name = 'Nintendo'));

INSERT INTO game_plat (vid, plid)
VALUES ((SELECT id FROM videogame WHERE name = 'Uncharted'), (SELECT id FROM platform WHERE name = 'PlayStation')),
((SELECT id FROM videogame WHERE name = 'Super_Mario_Odyssey'), (SELECT id FROM platform WHERE name = 'Switch')),
((SELECT id FROM videogame WHERE name = 'Halo'), (SELECT id FROM platform WHERE name = 'Xbox'));
