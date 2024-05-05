const {Pool} = require('pg')
require('dotenv').config();

const pool = new Pool ({
    host: process.env.PGHOST,
    port: process.env.PGPORT,
    database: process.env.PGDATABASE,
    user: process.env.PGUSER,
    password: process.env.PGPASSWORD,
    ssl:{
        require: true,
        rejectUnauthorized: false
    }
});

const db = pool;
exports.db = db;