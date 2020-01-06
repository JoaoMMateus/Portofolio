var http = require('http');
var url = require('url');
var fs = require('fs');
var DeviceDetector = require('device-detector-js');


const hostname = 'localhost';
const port = 8080;
const deviceDetector = new DeviceDetector();
const userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36";




const server = http.createServer(function  (req, res) {
  var q = url.parse(req.url, true);
  var  filename = "." + q.pathname;
  // const device = deviceDetector.parse(userAgent);
  // console.log(device.device.type);

    // detect device
  // if (q.pathname == "/" && device.device.type == "desktop"){
  //   filename = "./index.html";
  // }else if(q.pathname == "/" && (device.device.type == "smartphone" || device.device.type == "tablet")){
  //   filename = "./index-mobile.html";
  // }

  if (q.pathname == "/"){
    filename = "./index.html";
  }else if(q.pathname == "/m" ){
    filename = "./index-mobile.html";
  }

  // if (req.method === "GET") {
  //   fs.readFile(filename,  function(err, data) {
  //     if (err) {
  //       res.writeHead(404, {'Content-Type': 'text/html'});
  //        return res.end("404 Not Found");
  //     } 
  //     res.writeHead(200, {'Content-Type': 'text/html'});
  //     res.json(JSON.stringify({'user':'name'}));
  //     // res.write(data);
  //     //  return res.end();
  //   });
  // } else if (req.method === "POST") {

  //   var body = "";
  //   req.on("data", function (chunk) {
  //       body += chunk;
  //   });

    // req.on("end", function(){
        fs.readFile(filename,  function(err, data) {
          if (err) {
            res.writeHead(404, {'Content-Type': 'text/html'});
            // redirect to custom 404
             return res.end("404 Not Found");
          } 
          res.writeHead(200, {'Content-Type': 'text/html'});
          // res.json(JSON.stringify({'user':'name'}));
          res.write(data);
            return res.end();
        });
    // });
  // }
});

// var app = http.createServer(function(req,res){
//   res.setHeader('Content-Type', 'application/json');
//   res.end(JSON.stringify({ a: 1 }));
// });
// app.listen(3000);

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});