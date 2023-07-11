const express = require('express')
const bodyparser = require('body-parser')
const cors = require('cors')

const app = express()
const port = 8080;
const {db} = require('./cnn')

app.use(bodyparser.urlencoded({ extended: true }))
app.use(bodyparser.json())
app.use(cors())

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    next();
  });

//FUNCTIONS
const getUser = async (id) =>
{
    if(id == null)
        var data = (await db.query('SELECT * FROM users'))
    else
        var data = (await db.query(`SELECT FROM users WHERE userid = ${id}`))

    return data.rows
}
const getProduct = async (id) =>
{
    if(id == null)
        var data = (await db.query('SELECT * FROM productos'))
    else
        var data = (await db.query(`SELECT FROM productos WHERE id = ${id}`))

    return data.rows
}

const postUser = async (body) =>
{
    let user = Object.values(body);
    var query = `INSERT INTO users (useremail, userpassword) VALUES($1, $2)`;
    await db.query(query, user);
}

//INTERACTIONS
app.get('/users', async (req, res)=>{res.send(await getUser())})
app.get('/products', async (req, res)=>{res.send(await getProduct())})
app.get('/', async (req, res)=>{res.send('Home')})

app.post('/users', (req, res)=>{postUser(req.body)})


app.listen(port, ()=>{console.log("localhost: " + port)})
