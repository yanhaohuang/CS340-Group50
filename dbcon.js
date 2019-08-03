var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_huanyanh',
  password        : '7381',
  database        : 'cs340_huanyanh'
});
module.exports.pool = pool;
