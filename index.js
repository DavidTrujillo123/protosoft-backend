const express = require('express');
const app = express();
const port = 8080;
const {db} = require('./cnn')

app.listen(port, ()=>{console.log("localhost: " + port)})

const getUsers = async (id) =>
{
    if(id == null)
        var data = (await db.query('SELECT * FROM users'))
    else
        var data = (await db.query(`SELECT FROM users WHERE userid = ${id}`))

    return data.rows
}

app.get('/',async (req, res)=>{res.send(await getUsers())})