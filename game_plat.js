
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
    function getGames(res, mysql, context, complete){
        mysql.pool.query("SELECT id, name FROM videogame", function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end();}
            context.game = results;
            complete();
        });
    }
    function getPlatforms(res, mysql, context, complete){
        sql = "SELECT id, name FROM platform";
        mysql.pool.query(sql, function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end()}
            context.platform = results
            complete();
        });
    }
    function getGamesWithPlatforms(res, mysql, context, complete){
        sql = "SELECT vid, v.name AS vname, plid, p.name AS pname FROM videogame v INNER JOIN game_plat gp ON v.id = gp.vid INNER JOIN platform p on p.id = gp.plid ORDER BY vname, pname"
         mysql.pool.query(sql, function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end()}
            context.game_with_plat = results
            complete();
        });
    }
    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deletegame.js"];
        var mysql = req.app.get('mysql');

        getGames(res, mysql, context, complete);
        getDevelopers(res, mysql, context, complete);
        getPlatforms(res, mysql, context, complete);
        getGamesWithPlatforms(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 4){
                res.render('game_plat', context);
            }
        }
    });
    router.post('/platform', function(req, res){
        var mysql = req.app.get('mysql');
        var sql = "INSERT INTO platform (name, did) VALUES (?,?)";
        if (req.body.developer == "NULL") {developer = null;}
        else {developer = req.body.developer;}
        var inserts = [req.body.name, developer];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end();}
            else{res.redirect('/game_plat');}
        });
    });
    router.post('/', function(req, res){
        var mysql = req.app.get('mysql');
        var platforms = req.body.plid
        var game = req.body.vid
        for (let plat of platforms) {
          var sql = "INSERT INTO game_plat (vid, plid) VALUES (?,?)";
          var inserts = [game, plat];
          sql = mysql.pool.query(sql, inserts, function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.end();}
          });
        }
        res.redirect('/game_plat');
    });
    router.delete('/vid/:vid/platform/:plid', function(req, res){
        var mysql = req.app.get('mysql');
        var sql = "DELETE FROM game_plat WHERE vid = ? AND plid = ?";
        var inserts = [req.params.vid, req.params.plid];
        sql = mysql.pool.query(sql, inserts, function(error, results, fields){
            if(error){res.write(JSON.stringify(error)); res.status(400); res.end();}
            else{res.status(202).end();}
        })
    })
    return router;
}();
