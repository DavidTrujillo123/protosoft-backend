const express = require('express')
const bodyparser = require('body-parser')

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

//#region FUNCTIONS
const getUsers = async (body) =>
{
    var user = Object.values(body)
    try {
        if(JSON.stringify(user) === "[]")
            var data = (await db.query('SELECT rolid, usucorreo, usunombre, usuapellido, usuimagen FROM usuarios'))
        else
            var data = (await db.query(`SELECT rolid, usucorreo, usunombre, usuapellido, usuimagen FROM usuarios WHERE usucorreo = $1`, user))
        return data.rows
    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    }
}
const getRegisters = async (body) =>
{
    var id = body.id
    try {
        if(id == null)
            var data = (await db.query('SELECT * FROM registros'))
        else
            var data = (await db.query(`SELECT * FROM registros WHERE regid = '${id}'`))
        return data.rows
    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    }
}
const postUser = async (body) =>
{
    var rol = body.rol
    var email = body.email
    var password = body.password
    var name = body.name
    var lastName = body.lastName
    var query = `INSERT INTO usuarios (rolid, usucorreo, usucontrasenia, usunombre, usuapellido) 
                    VALUES('${rol}', '${email}', '${password}', '${name}', '${lastName}')`
                    console.log('Query maked')
    try {
        await db.query(query)
        console.log('Query Done')
        return 'Query done'
    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    }
}
const postRegister = async (body) =>
{
    
    try {
        
    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    }
}
const login = async (body) => 
{ 
    var email = body.email;
    var password = body.password;
    var query = `SELECT * FROM usuarios WHERE usucorreo = '${email}' AND usucontrasenia = '${password}'`;
    console.log('Query maked')
    try {
        var data = await db.query(query);
        console.log('Query done')
        return data.rows.at(0);
    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    }
}
//#endregion

//#region CUSTOMS
app.get('/', async (req, res)=>{res.sendFile(__dirname + '/info.html')})
app.post('/login', async (req, res) => {
    try {res.send(await login(req.body))}
    catch (e){res.status(500).send("Error interno del servidor")}})
app.get('/wwssadadBA', (req, res)=>{res.sendFile(__dirname + '/wwssadadBA.jpg')})
//#endregion

//#region GETS
app.get('/users', async (req, res)=>{res.send(await getUsers(req.body))})
app.get('/registers', async (req, res)=>{res.send(await getRegisters(req.body))})
//#endregion

//#region POSTS
app.post('/users', (req, res) => {
    console.log('2')
    try {postUser(req.body)} 
    catch (e) {res.status(500).send("Error interno del servidor")}})
app.post('/registers', (req, res)=>{
    try {postRegister(req.body)} 
    catch (e) {res.status(500).send("Error interno del servidor")}})
//#endregion


app.listen(port, ()=>{console.log("localhost:" + port)})
