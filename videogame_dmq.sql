
-- SELECT queries
SELECT * FROM videogame v WHERE v.name LIKE "%:nameInput%" 																-- get videogame by name

SELECT v.id, v.name AS videogame_name, d.name AS developer_name, p.name AS publisher_name FROM videogame v				-- get all videogames
INNER JOIN developer d ON v.developer_id = d.id 	
INNER JOIN publisher p ON v.publisher_id = p.id

SELECT id, name FROM developer 																							-- get all developer IDs and names to populate the developer dropdown
SELECT id, name FROM publisher 																							-- get all publisher IDs and names to populate the publisher dropdown
SELECT id, name FROM platform 																							-- get all platform IDs and names to populate the platform dropdown

SELECT videogame_id, v.name AS videogame_name, platform_id, p.name AS platform_name FROM videogame v 					-- get all videogame with their current associated platforms to list
INNER JOIN videogame_platform vp ON v.id = vp.videogame_id 
INNER JOIN platform p on p.id = vp.platform_id 
ORDER BY videogame_name, platform_name

-- INSERT queries
INSERT INTO developer (name) VALUES (:nameInput) 																							-- add a new developer
INSERT INTO publisher (name) VALUES (:nameInput) 																							-- add a new publisher
INSERT INTO videogame (name, developer_id, publisher_id) VALUES (:nameInput, :developer_id_dropdownInput, :publisher_id_dropdownInput) 		-- add a new videogame
INSERT INTO platform (name, developer_id) VALUES (:nameInput, :developer_id_dropdownInput) 													-- add a new platform
INSERT INTO videogame_platform (videogame_id, platform_id) VALUES (:videogame_id_dropdownInput, :platform_id_dropdownInput) 				-- associate a videogame with a platform (M-to-M relationship addition)

-- UPDATE queries
UPDATE videogame SET name = :nameInput, developer_id = :developer_id_dropdownInput, publisher_id = :publisher_id_dropdownInput 				-- update a videogame's data based on submission of the Update videogame form 
WHERE id = :idInput

-- DELETE queries
DELETE FROM videogame WHERE id = :videogame_Input 																							-- delete a videogame
DELETE FROM videogame_platform WHERE videogame_id = :videogame_id_Input AND platform_id = :platform_id_Input 								-- dis-associate a videogame from a platform (M-to-M relationship deletion)
