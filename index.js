const express = require('express')
const cors = require('cors')

const app = express()
const port = 8080;
const {db} = require('./cnn')

app.listen(port, ()=>{console.log("localhost: " + port)})
app.use(express.urlencoded({urlencoded: true}))
app.use(express.json({type:"*/*"}))
app.use(cors())


app.use(function (req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', ['http://localhost:8888','https://protosoft-api.azurewebsites.net']);
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
    res.setHeader('Access-Control-Allow-Credentials', true);
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
    await pool.query(query, user);
}

//INTERACTIONS
app.get('/users', async (req, res)=>{res.send(await getUser())})
app.get('/products', async (req, res)=>{res.send(await getProduct())})
app.get('/', async (req, res)=>{res.send('Home')})

app.post('/user', (req, res)=>{postUser(req.body)})
