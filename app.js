const express = require("express");
var cookieParser = require("cookie-parser");
const {Pool, Client} = require("pg");
const app = express();
const port = 5000;

//------------------------------------------------------
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(express.static(__dirname + "/public"));
//------------------------------------------------------



//Busca todos los html
let file = (name) => {
  return __dirname + "/views/" + name;
};

//inicio de sesion
app.get("/", function (req, res) {
  res.status(201).sendFile(file("login.html"));
});

//mapa
app.get("/mapa", function (req, res) {
  res.sendFile(file("mapa.html"));
});

//Comprueba conexion
app.post("/conexion", function (req, res) {
  let cred=req.body.conexion;
  let pool = new Pool(cred);
  pool
    .connect()
    .then(() => {
      res
      .status(301)
      .cookie("conexion",JSON.stringify(cred))
      .send({"redirect":true,"url":"/mapa"});
    })
    .catch((error) => {
      res.send({"redirect":false,"url":"","error":error});
    });
});

//Envia todas las paradas
app.get("/get-paradas",function(req,res){
  let cred=JSON.parse(req.cookies.conexion);
  let pool = new Pool(cred);
  pool.connect((err, client, release) => {
    if (err) {
      return console.error('Error acquiring client', err.stack)
    }
    client.query('select paradas_geojson()', (err, result) => {
      release()
      if (err) {
        return console.error('Error executing query', err.stack)
      }
      res.json(result.rows[0].paradas_geojson);
    })
  });
});

//dijkstra

app.post("/dijkstra",function(req,res){
  let cred=JSON.parse(req.cookies.conexion);
  let body=req.body;
  console.log(body.ini+','+body.des);
  
  let pool = new Pool(cred);
  pool.connect((err, client, release) => {
    if (err) {
      return console.error('Error acquiring client', err.stack)
    }
    client.query('select * FROM dijkstra('+body.ini+','+body.des+')', (err, result) => {
      release()
      if (err) {
        return console.error('Error executing query', err.stack)
      }
      res.json(result.rows[0]);
    })
  });

});

//------------------------------------------------------
app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
