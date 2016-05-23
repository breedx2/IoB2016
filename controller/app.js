

const express = require('express');
const rgb_client = require('./rgb_client');

const HTTP_PORT = 9090;
const START = 201;
const END = 210;

var app = express();
app.set('port', HTTP_PORT);

var server = app.listen(HTTP_PORT, function () {
  console.log("server started");
});

// puts a single rgb on each bucket
app.get('/rgb', function (req, res) {
  let r = req.query.r;
  let g = req.query.g;
  let b = req.query.b;
  allBuckets(() => {
    rgb_client.send(`192.168.16.${i}`, r, g, b);
  });
  res.send('ok');
});

// puts a random color on each bucket
app.get('/rainbow', function (req, res) {
  allBuckets(i => {
    rgb_client.send(`192.168.16.${i}`, randColor(), randColor(), randColor());
  });
  res.send('ok');
});

// flips all buckets to the same random color over and over
app.get('/flipper', function (req, res) {
  function once(){
    let r = randColor();
    let g = randColor();
    let b = randColor();
    allBuckets(i => {
      rgb_client.send(`192.168.16.${i}`, r, g, b);
    });
  }
  let times = req.query.times || 1;
  let rate = req.query.rate || 250;
  let timer = setInterval(() => {
    once();
    if(--times <= 0){
      clearInterval(timer);
    }
  }, rate);
  res.send('ok');
});

function allBuckets(cb){
  for(let i = START; i <= END; i++){
    cb(i);
  }
}

function randColor(){
  return Math.round(Math.random() * (255));
}
