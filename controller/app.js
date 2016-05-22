

const express = require('express');
const rgb_client = require('./rgb_client');

const HTTP_PORT = 9090;

var app = express();
app.set('port', HTTP_PORT);

var server = app.listen(HTTP_PORT, function () {
  console.log("server started");
});

app.get('/rgb', function (req, res) {
  let r = req.query.r;
  let g = req.query.g;
  let b = req.query.b;
  for(let i=201; i < 250; i++){
    rgb_client.send(`192.168.16.${i}`, r, g, b);
  }
  res.send('ok');
});
