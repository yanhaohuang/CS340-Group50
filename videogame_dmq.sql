
-- SELECT queries
SELECT v.id AS id, v.name AS vname, d.name AS dname, p.name AS pname FROM videogame v									-- get videogames by name
INNER JOIN developer d ON v.did = d.id 	
INNER JOIN publisher p ON v.pid = p.id
WHERE vname LIKE "%:nameInput%" 

SELECT v.id AS id, v.name AS vname, d.name AS dname, p.name AS pname FROM videogame v									-- get all videogames
INNER JOIN developer d ON v.did = d.id 	
INNER JOIN publisher p ON v.pid = p.id

SELECT id, name FROM videogame 																							-- get all videogame IDs and names to populate the videogame dropdown
SELECT id, name FROM developer 																							-- get all developer IDs and names to populate the developer dropdown
SELECT id, name FROM publisher 																							-- get all publisher IDs and names to populate the publisher dropdown
SELECT id, name FROM platform 																							-- get all platform IDs and names to populate the platform dropdown

SELECT vid, v.name AS vname, plid, p.name AS pname FROM videogame v 													-- get all videogame with their current associated platforms to list
INNER JOIN game_plat gp ON v.id = gp.vid 
INNER JOIN platform p on p.id = gp.plid 
ORDER BY vname, pname

-- INSERT queries
INSERT INTO developer (name) VALUES (:nameInput) 																		-- add a new developer
INSERT INTO publisher (name) VALUES (:nameInput) 																		-- add a new publisher
INSERT INTO videogame (name, did, pid) VALUES (:nameInput, :developer_id_dropdownInput, :publisher_id_dropdownInput)	-- add a new videogame
INSERT INTO platform (name, did) VALUES (:nameInput, :developer_id_dropdownInput) 										-- add a new platform
INSERT INTO game_plat (vid, plid) VALUES (:videogame_id_dropdownInput, :platform_id_dropdownInput) 						-- associate a videogame with a platform (M-to-M relationship addition)

-- UPDATE queries
UPDATE videogame SET name = :nameInput, did = :developer_id_dropdownInput, pid = :publisher_id_dropdownInput 			-- update a videogame's data based on submission of the Update videogame form 
WHERE id = :idInput

-- DELETE queries
DELETE FROM videogame WHERE id = :videogame_id_Input 																	-- delete a videogame
DELETE FROM game_plat WHERE vid = :videogame_id_Input AND plid = :platform_id_Input 									-- dis-associate a videogame from a platform (M-to-M relationship deletion)
