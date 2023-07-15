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
        return data.rows;
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
// const postUser = async (body) =>
// {
//     var usuid = body.usuid;
//     var rolid = body.rolid;
    
//     var usucorreo = body.usucorreo;
//     var usucontrasenia = body.usucontrasenia;
//     var usunombre = body.usunombre;
//     var usuapellido = body.usuapellido;
//     var usuestado = body.usuestado;
//     var usuimagen = body.usuimagen || null;
//     let user = {
//         usuid_ob: usuid,
//         usur: rolid,
//         usuc: usucorreo,
//         usucon: usucontrasenia,
//         usunom: usunombre,
//         usuest: usuestado,
//         usuim: usuimagen

//     }
//     console.log(user);
//     var query = `INSERT INTO public.usuarios(
//         usuid, rolid, usucorreo, usucontrasenia, usunombre, usuapellido, usuestado, usuimagen)
//         VALUES ("${usuid}", "${rolid}", "${usucorreo}", "${usucontrasenia}", "${usunombre}", "${usuapellido}", "${usuestado}","${usuimagen}")`;

//                         // ('USU1', 'ADM', 'juanperez@example.com', '123456', 'Juan', 'Pérez', true, NULL)
//     try {
//         await db.query(query)
//     } catch (error) {
//         console.error("Error en la consulta:", error);
//         throw error;
//     }
// }

const postUser = async (body) => {
    const usuid = body.usuid;
    const rolid = body.rolid;
    const usucorreo = body.usucorreo;
    const usucontrasenia = body.usucontrasenia;
    const usunombre = body.usunombre;
    const usuapellido = body.usuapellido;
    const usuestado = body.usuestado;
    const usuimagen = body.usuimagen || null;

    const query = `INSERT INTO usuarios (usuid, rolid, usucorreo, usucontrasenia, usunombre, usuapellido, usuestado, usuimagen)
                   VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`;

    try {
        await db.query(query, [usuid, rolid, usucorreo, usucontrasenia, usunombre, usuapellido, usuestado, usuimagen]);
    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    } 
};


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
    try {
        var email = body.email;
        var password = body.password;
        var query = `SELECT * FROM usuarios WHERE usucorreo = '${email}' AND usucontrasenia = '${password}'`;
        var data = await db.query(query);
        return data.rows.at(0);
    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    }
}
//#endregion

//#region CUSTOMS
app.get('/', async (req, res)=>{res.sendFile(__dirname + '/info.html')});
app.post('/login', async (req, res) => {
    try {res.send(await login(req.body))}
    catch (e){res.status(500).send("Error interno del servidor")}});
app.get('/wwssadadBA', (req, res)=>{res.sendFile(__dirname + '/wwssadadBA.jpg')});
//#endregion

//#region GETS
app.get('/users', async (req, res)=>{res.send(await getUsers(req.body))});
app.get('/registers', async (req, res)=>{res.send(await getRegisters(req.body))});
//#endregion

//#region POSTS
app.post('/users', (req, res) => {
    try {
        postUser(req.body);
        res.json({msg: 'Registro exitoso!'});
    } 
    catch (e) {res.status(500).send(e+" Error interno del servidor")}});
app.post('/registers', (req, res)=>{
    try {postRegister(req.body)} 
    catch (e) {res.status(500).send("Error interno del servidor")}});
//#endregion


app.listen(port, ()=>{console.log("localhost:" + port)});
