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
const getProducts = async (id) =>
{
    if(id == null)
        var data = (await db.query('SELECT * FROM productos'))
    else
        var data = (await db.query(`SELECT FROM productos WHERE id = ${id}`))

    return data.rows
}

app.get('/users', async (req, res)=>{res.send(await getUsers())})
app.get('/products', async (req, res)=>{res.send(await getProducts())})
app.get('/', async (req, res)=>{res.send(davidtrujillo123.github.io/protosoft_v1/html/home.html)})
