
/*Reference: https://github.com/knightsamar/cs340_sample_nodejs_app */
module.exports = function(){
    var express = require('express');
    var router = express.Router();

    function getDevelopers(res, mysql, context, complete){
        mysql.pool.query("SELECT id, name FROM developer", function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end();}
            context.developer  = results;
            complete();
        });
    }
    function getPublishers(res, mysql, context, complete){
        mysql.pool.query("SELECT id, name FROM publisher", function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end();}
            context.publisher  = results;
            complete();
        });
    }
    function getGames(res, mysql, context, complete){
        mysql.pool.query("SELECT v.id AS id, v.name AS vname, d.name AS dname, p.name AS pname FROM videogame v INNER JOIN developer d ON v.did = d.id INNER JOIN publisher p ON v.pid = p.id", function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end();}
            context.game = results;
            complete();
        });
    }
    function getGamesWithNameLike(req, res, mysql, context, complete) {
        var query = "SELECT v.id AS id, v.name AS vname, d.name AS dname, p.name AS pname FROM videogame v INNER JOIN developer d ON v.did = d.id INNER JOIN publisher p ON v.pid = p.id WHERE v.name LIKE " + mysql.pool.escape('%'+req.params.s+'%');
        mysql.pool.query(query, function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end();}
            context.game = results;
            complete();
        });
    }
    function getGame(res, mysql, context, id, complete){
        var sql = "SELECT id, name, did, pid FROM videogame WHERE id = ?";
        var inserts = [id];
        mysql.pool.query(sql, inserts, function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end();}
            context.game = results[0];
            complete();
        });
    }
    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deletegame.js","searchgame.js"];
        var mysql = req.app.get('mysql');
        getGames(res, mysql, context, complete);
        getDevelopers(res, mysql, context, complete);
        getPublishers(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 3){
                res.render('videogame', context);
            }

        }
    });
    router.get('/search/:s', function(req, res){
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deletegame.js","searchgame.js"];
        var mysql = req.app.get('mysql');
        getGamesWithNameLike(req, res, mysql, context, complete);
        getDevelopers(res, mysql, context, complete);
        getPublishers(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 3){
                res.render('videogame', context);
            }
        }
    });
    router.get('/:id', function(req, res){
        callbackCount = 0;
        var context = {};
        context.jsscripts = ["selected.js", "updategame.js"];
        var mysql = req.app.get('mysql');
        getGame(res, mysql, context, req.params.id, complete);
        getDevelopers(res, mysql, context, complete);
        getPublishers(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 3){
                res.render('update_game', context);
            }
        }
    });
    router.post('/', function(req, res){
        var mysql = req.app.get('mysql');
        if (req.body.developer == "NULL") {developer = null;}
        else {developer = req.body.developer;}
        if (req.body.publisher == "NULL") {publisher = null;}
        else {publisher = req.body.publisher;}
        var sql = "INSERT INTO videogame (name, did, pid) VALUES (?,?,?)";
        var inserts = [req.body.name, developer, publisher];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end();}
            else{res.redirect('/game');}
        });
    });
    router.post('/developer', function(req, res){
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO developer (name) VALUES (?)";
        var inserts = [req.body.name];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end();}
            else{res.redirect('/game');}
        });
    });
    router.post('/publisher', function(req, res){
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO publisher (name) VALUES (?)";
        var inserts = [req.body.name];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end();}
            else{res.redirect('/game');}
        });
    });
    router.put('/:id', function(req, res){
        var mysql = req.app.get('mysql');
        if (req.body.developer == "NULL") {developer = null;}
        else {developer = req.body.developer;}
        if (req.body.publisher == "NULL") {publisher = null;}
        else {publisher = req.body.publisher;}
        var sql = "UPDATE videogame SET name=?, did=?, pid=? WHERE id=?";
        var inserts = [req.body.name, developer, publisher, req.params.id];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end();}
            else{res.status(200); res.end();}
        });
    });
    router.delete('/:id', function(req, res){
        var mysql = req.app.get('mysql');
        var sql = "DELETE FROM videogame WHERE id=?";
        var inserts = [req.params.id];
        sql = mysql.pool.query(sql, inserts, function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.status(400); res.end();}
            else{res.status(202).end();}
        })
    })
    return router;
}();
