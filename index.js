const express = require('express')
const bodyparser = require('body-parser')
const cors = require('cors')

const app = express()
const port = 8080;
const {db} = require('./cnn')

app.use(bodyparser.urlencoded({ extended: true }))
app.use(bodyparser.json())
// app.use(cors())

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    next();
  });

//FUNCTIONS
const getUser = async (body) =>
{
    var user = Object.values(body)

    if(JSON.stringify(user) === "[]")
        var data = (await db.query('SELECT * FROM usuarios'))
    else
        var data = (await db.query(`SELECT * FROM usuarios WHERE usucorreo = $1`, user))

    return data.rows
}
const getProduct = async (id) =>
{
    if(id == null)
        var data = (await db.query('SELECT * FROM productos'))
    else
        var data = (await db.query(`SELECT * FROM productos WHERE id = ${id}`))

    return data.rows
}

const postUser = async (body) =>
{
    let user = Object.values(body);
    var query = `INSERT INTO users (useremail, userpassword) VALUES($1, $2)`;
    await db.query(query, user);
}

const searchUser = async (body) => 
{
    var email = body.email
    var password = body.password
    var query = `SELECT * FROM usuarios WHERE usucorreo = '${email}' AND usucontrasenia = '${password}'`
    var data = await db.query(query)
    return data.rows.at(0)
}

//INTERACTIONS
app.get('/users', async (req, res)=>{res.send(await getUser(req.body))})
app.get('/products', async (req, res)=>{res.send(await getProduct())})
app.get('/', async (req, res)=>{res.send('Home')})

app.post('/postUser', (req, res)=>{postUser(req.body)})
app.post('/searchUser', async (req, res)=>{res.send(await searchUser(req.body))})


app.listen(port, ()=>{console.log("localhost: " + port)})
