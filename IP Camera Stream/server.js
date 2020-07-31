const path=require('path');
const express = require('express')
const app = express()
const port = 8888
app.use(express.static(__dirname + '/frontend/dist/hello'));
app.get('/', (req, res) =>res.sendFile('index.html', {root: __dirname}))

app.listen(port, () =>console.log(`Example app listening at http://localhost:${port}`))