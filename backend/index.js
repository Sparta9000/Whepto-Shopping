const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const apis = require('./apis/api');

const app = express();

app.use(bodyParser.urlencoded({ extended : false }));
app.use(bodyParser.json());
app.use(cors());

app.use((req, res, next) => {
    console.log(req.path, req.method);
    next();
});

app.use('/api', apis);

app.listen(4000, () => {
    console.log('Server started on port 4000');
});