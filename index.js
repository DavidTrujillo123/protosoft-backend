const express = require('express')
const bodyparser = require('body-parser')
const cors = require('cors')

const app = express()
const port = 8080;
const {db} = require('./cnn')

app.use(bodyparser.urlencoded({ extended: true }))
app.use(bodyparser.json())

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    next();
  });

//FUNCTIONS
const getUsers = async (body) =>
{
    var user = Object.values(body)

    if(JSON.stringify(user) === "[]")
        var data = (await db.query('SELECT * FROM usuarios'))
    else
        var data = (await db.query(`SELECT * FROM usuarios WHERE usucorreo = $1`, user))

    return data.rows
}
const getRegisters = async (id) =>
{
    if(id == null)
        var data = (await db.query('SELECT * FROM registros'))
    else
        var data = (await db.query(`SELECT * FROM registros WHERE regid = ${id}`))

    return data.rows
}

const postUser = async (body) =>
{
    var rol = body.rol
    var email = body.email
    var password = body.password
    var name = body.name
    var lastName = body.lastName
    var query = `INSERT INTO users (usuid, rolid, usucorreo, usucontrasenia, usunombre, usuapellido) 
                    VALUES(GenerarID(${rol}),${rol}, ${email}, ${password}, ${name}, ${lastName})`
    await db.query(query, user)
}

const login = async (body) => 
{
    try {
        var email = body.email;
        var password = body.password;
        var query = `SELECT * FROM usuarios WHERE usucorreo = '${email}' AND usucontrasenia = '${password}'`;
        var data = await db.query(query);
        return data.rows.at(0);
    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error; // Lanza el error para que sea manejado en otro lugar si es necesario
    }
}

//QUERIES
app.get('/', async (req, res)=>{res.sendFile(__dirname + '/info.html')})
app.post('/login', async (req, res) => {
    try {
      res.send(await login(req.body));
    } catch (error) {
      res.status(500).send("Error interno del servidor");
    }
  });

app.get('/users', async (req, res)=>{res.send(await getUsers(req.body))})
app.get('/registers', async (req, res)=>{res.send(await getRegisters(req.body))})

app.post('/users', (req, res)=>{postUser(req.body)})
app.post('/registers', (req, res)=>{postRegister(req.body)})



app.listen(port, ()=>{console.log("localhost:" + port)})
