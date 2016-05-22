const net = require('net');
const querystring = require('querystring');

// RGB sending client that talks broken HTTP

module.exports = {
  send: function(host, r, g, b){
    try {
      //let client = net.connect({ host: host, port: 80 }, () => {
      let client = net.createConnection({ host: host, port: 80 }, () => {
          let params = querystring.stringify({
            r: r, g: g, b: b
          });
          let msg = `GET /?${params} HTTP/1.1`;
          console.log("WRITING");
          client.write(`${msg}\r\n`);
      });
      client.on('error', err => {
        console.log("error: " + err);
      })
    }
    catch(err){
      console.log("err: " + err);
    }
  }
};
