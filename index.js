const express = require('express');
const app = express();
const port = 8080;
const {db} = require('./cnn')

app.listen(port, ()=>{console.log("localhost: " + port)})

const getUser = async (id) =>
{
    if(id == null)
        var data = (await db.query('SELECT * FROM users'))
    else
        var data = (await db.query(`SELECT FROM users WHERE userid = ${id}`))

    return data.rows
}
const postUser = async (body) =>
{
    let user = Object.values(body);
    var query = `INSERT INTO users (useremail, userpassword) VALUES($1, $2)`;
    await pool.query(query, user);
}
const getProducts = async (id) =>
{
    if(id == null)
        var data = (await db.query('SELECT * FROM productos'))
    else
        var data = (await db.query(`SELECT FROM productos WHERE id = ${id}`))

    return data.rows
}

app.get('/users', async (req, res)=>{res.send(await getUser())})
app.get('/products', async (req, res)=>{res.send(await getProducts())})
app.get('/', async (req, res)=>{res.send(davidtrujillo123.github.io/protosoft_v1/html/home.html)})

app.post('/user', (req, res)=>{postUser(req.body)})





app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    next();
  });