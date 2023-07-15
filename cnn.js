const {Pool} = require('pg')

const pool = new Pool ({
    host: "protosoft-server.postgres.database.azure.com",
    port: "5432",
    database: "protosoft-db-v2",
    user: "utnAdmin@protosoft-server",
    password: "Password123*",
    ssl:{
        require: true,
        rejectUnauthorized: false
    }
})

const db = pool;
exports.db = db;