var http = require('http');
var fs = require('fs');
var path = require('path');
var DeviceDetector = require('device-detector-js');


const hostname = 'localhost';
const port = 8080;
const deviceDetector = new DeviceDetector();
const userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36";

// Root directory that requests are confined to (prevents path traversal).
const ROOT = path.resolve(__dirname);

// Map file extensions to the correct Content-Type so assets are served properly.
const MIME_TYPES = {
  '.html': 'text/html; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.js': 'text/javascript; charset=utf-8',
  '.mjs': 'text/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.map': 'application/json; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.webp': 'image/webp',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
  '.otf': 'font/otf',
  '.eot': 'application/vnd.ms-fontobject',
  '.mp4': 'video/mp4',
  '.webm': 'video/webm',
  '.txt': 'text/plain; charset=utf-8',
  '.pdf': 'application/pdf'
};




// Security headers applied to every response (defense-in-depth hardening).
const SECURITY_HEADERS = {
  'X-Content-Type-Options': 'nosniff',
  'X-Frame-Options': 'DENY',
  'Referrer-Policy': 'strict-origin-when-cross-origin',
  'Permissions-Policy': 'geolocation=(), microphone=(), camera=()',
  'Content-Security-Policy':
    "default-src 'self'; img-src 'self' data:; " +
    "style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline'; " +
    "font-src 'self' data:; object-src 'none'; frame-ancestors 'none'; base-uri 'self'"
};

// Send a plain-text error response with the standard security headers.
function sendError(res, code, message) {
  res.writeHead(code, Object.assign({'Content-Type': 'text/plain; charset=utf-8'}, SECURITY_HEADERS));
  return res.end(message);
}

const server = http.createServer(function  (req, res) {
  // Only read methods are supported; everything else is rejected up front.
  if (req.method !== 'GET' && req.method !== 'HEAD') {
    res.writeHead(405, Object.assign({'Content-Type': 'text/plain; charset=utf-8', 'Allow': 'GET, HEAD'}, SECURITY_HEADERS));
    return res.end("405 Method Not Allowed");
  }

  // Take the path straight off the raw request target, dropping query and
  // fragment. The raw form is deliberate: the WHATWG URL parser collapses "../"
  // segments, which would hide traversal attempts from the checks below.
  // Decode percent-encoding so encoded traversal (e.g. %2e%2e%2f) is caught too.
  var pathname;
  try {
    pathname = decodeURIComponent(req.url.split('#')[0].split('?')[0]);
  } catch (e) {
    return sendError(res, 400, "400 Bad Request");
  }

  // A NUL byte (e.g. %00) makes fs.* throw synchronously - reject before it can
  // crash the process (path-truncation / DoS).
  if (pathname.indexOf('\0') !== -1) {
    return sendError(res, 400, "400 Bad Request");
  }

  if (pathname == "/"){
    pathname = "/index.html";
  }else if(pathname == "/m" ){
    pathname = "/index-mobile.html";
  }

  // Resolve within ROOT and reject anything that escapes it lexically (path traversal).
  var filename = path.join(ROOT, pathname);

  if (filename !== ROOT && !filename.startsWith(ROOT + path.sep)) {
    return sendError(res, 403, "403 Forbidden");
  }

  // Resolve symlinks and re-check confinement: a link inside ROOT that points
  // outside stays "inside" lexically, so verify the real path too.
  fs.realpath(filename, function (rpErr, realPath) {
    if (rpErr) {
      return sendError(res, 404, "404 Not Found");
    }
    if (realPath !== ROOT && !realPath.startsWith(ROOT + path.sep)) {
      return sendError(res, 403, "403 Forbidden");
    }

    fs.readFile(realPath, function(err, data) {
      if (err) {
        // Missing file, directory (EISDIR), or unreadable - treat as not found.
        return sendError(res, 404, "404 Not Found");
      }
      var contentType = MIME_TYPES[path.extname(realPath).toLowerCase()] || 'application/octet-stream';
      res.writeHead(200, Object.assign({'Content-Type': contentType}, SECURITY_HEADERS));
      res.write(data);
      return res.end();
    });
  });
});

// var app = http.createServer(function(req,res){
//   res.setHeader('Content-Type', 'application/json');
//   res.end(JSON.stringify({ a: 1 }));
// });
// app.listen(3000);

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});