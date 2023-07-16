const express = require('express');
const bodyparser = require('body-parser');

const app = express();
const port = 8080;
const { db } = require('./cnn')

app.use(bodyparser.urlencoded({ extended: true }));
app.use(bodyparser.json());

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    next();
});

//#region FUNCTIONS

const getData = async (body, sql_all, sql_unic) =>
{
    var user = Object.values(body);
    try {
        let data = null;
        if(JSON.stringify(user) === "[]")
            data = (await db.query(`${sql_all}`));
        else
            data = (await db.query(`${sql_unic}`, user));
        return data.rows;
    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    }
}
const getRegisters = async (body) => {
    var id = body.id
    try {
        if (id == null)
            var data = (await db.query('SELECT * FROM registros'))
        else
            var data = (await db.query(`SELECT * FROM registros WHERE regid = '${id}'`))
        return data.rows
    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    }
}
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
        return { success: true, message: 'Usuario creado correctamente, porfavor inicie sesión para continuar' };
    } catch (error) {
        console.error('Error en la consulta:', error);
        return { success: false, message: 'Error al insertar la información en la base de datos' };
    }
};


const postRegister = async (body) => {

    try {

    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    }
}
const login = async (body) => {
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
app.get('/', async (req, res) => { res.sendFile(__dirname + '/info.html') });
app.post('/login', async (req, res) => {
    try { res.send(await login(req.body)) }
    catch (e) { res.status(500).send("Error interno del servidor") }
});
app.get('/wwssadadBA', (req, res) => { res.sendFile(__dirname + '/wwssadadBA.jpg') });
//#endregion

//#region GETS
app.get('/users', async (req, res) => { res.send(await getUsers(req.body)) });
app.get('/registers', async (req, res) => { res.send(await getRegisters(req.body)) });
//#endregion

//#region POSTS
app.post('/users', async (req, res) => {
    try {
        const result = await postUser(req.body);
        res.json(result);
    } catch (error) {
        console.error('Error:', error.message);
        res.status(500).json({ success: false, message: 'Error interno del servidor' });
    }
});
app.post('/registers', (req, res) => {
    try { postRegister(req.body) }
    catch (e) { res.status(500).send("Error interno del servidor") }
});
//#endregion


app.listen(port, () => { console.log("localhost:" + port) });
