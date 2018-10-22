const http = require('http');
const https = require('https');
require('dotenv').config()

const HOSTNAME = '127.0.0.1';
const PORT = 3000;

const server = http.createServer((request, result) => {
  if(request.url === '/init') {
    let post = https.request(postOptions(), res => {
      var chunks = []
      res.on('data', (chunk) => {
        chunks.push(chunk);
      })
      res.on('end', () => {
        var body = Buffer.concat(chunks);
        result.statusCode = 200;
        result.setHeader('Content-Type', 'application/json');
        result.end(body.toString());
        console.log(new Date() ,body.toString());
      })
    })
  
    let payload = ''
    request.on('data', (data) => {
      payload += data;
    }).on('end', () => {
      payload = JSON.parse(payload);
      post.write(JSON.stringify({ 
        userHash: process.env.USER_HASH,
        language: payload.language,
        redirectUrl: payload.redirectUrl,
      })
    );
    post.end()
    });
  } else {
    result.statusMessage = 200
    result.setHeader('Content-Type', 'application/json')
    result.end(JSON.stringify({"greetings":"From Aarhus with ❤"}))
  }
});

const postOptions = function() {
  return {
    host: 'api.nordicapigateway.com',
    port: 443,
    path: '/v1/authentication/initialize',
    method: 'POST',
    headers: {
      "X-Client-ID": process.env.CLIENT_ID,
      "X-Client-Secret": process.env.CLIENT_SECRET,
      "Content-Type": "application/json",
      "Cache-Control": "no-cache",
    }
  }
}

server.listen(PORT, HOSTNAME, () => {
  console.log(`Server running at http://${HOSTNAME}:${PORT}/`);
});
