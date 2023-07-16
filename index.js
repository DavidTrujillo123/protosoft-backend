const express = require('express')
const bodyparser = require('body-parser')

const app = express()
const port = 8080;
const { db } = require('./cnn')

app.use(bodyparser.urlencoded({ extended: true }))
app.use(bodyparser.json())

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    next();
});

const getData = async (body, sql_all, sql_unic) =>
{
    let user = Object.values(body);
    try {
        let data = null;
        if(JSON.stringify(user) === "[]")
            data = (await db.query(`${sql_all}`));
        else
            data = (await db.query(`${sql_unic}`));
        return data.rows;
    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    }
}

//#region FUNCTIONS
const getUsers = async (body) => {
    let user = Object.values(body)
    try {
        if (JSON.stringify(user) === "[]")
            var data = (await db.query('SELECT rolid, usucorreo, usunombre, usuapellido, usuimagen, usutelefono FROM usuarios'))
        else
            var data = (await db.query(`SELECT rolid, usucorreo, usunombre, usuapellido, usuimagen, usutelefono FROM usuarios WHERE usucorreo = $1`, user))
        return data.rows;
    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    }
}
const postUser = async (body) => {
    // const usuid = body.usuid;
    const rolid = body.rolid;
    const usucorreo = body.usucorreo;
    const usucontrasenia = body.usucontrasenia;
    const usunombre = body.usunombre;
    const usuapellido = body.usuapellido;
    const usuestado = body.usuestado;
    const usuimagen = body.usuimagen || null;
    const usutelefono = body.usutelefono;
    const pregunta1 = body.pregunta1;
    const respuesta1 = body.respuesta1;

    const pregunta2 = body.pregunta2;
    const respuesta2 = body.respuesta2;

    const query = `INSERT INTO usuarios (rolid, usucorreo, usucontrasenia, usunombre, usuapellido, usuestado, usuimagen, usutelefono)
                   VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`;

    try {
        await db.query(query, [rolid, usucorreo, usucontrasenia, usunombre, usuapellido, usuestado, usuimagen, usutelefono]);
        //Buscar userid
        const usuid = (await db.query(`SELECT usuid FROM usuarios WHERE usucorreo like '${usucorreo}'`)).rows;
        //inserts de preguntas y respuestas
        const query1 = `INSERT INTO public.preguntas_recuperacion(
            usuid, pregunta, respuesta)
                VALUES ('${usuid[0].usuid}', '${pregunta1}', '${respuesta1}');`
        const query2 = `INSERT INTO public.preguntas_recuperacion(
            usuid, pregunta, respuesta)
                VALUES ('${usuid[0].usuid}', '${pregunta2}', '${respuesta2}');`
        await db.query(query1);
        await db.query(query2);
        return { success: true, message: 'Usuario creado correctamente, porfavor inicie sesión para continuar' };
    } catch (error) {
        console.error('Error en la consulta:', error);
        return { success: false, message: 'Error al insertar la información en la base de datos' };
    }
};

//#region PROTISTAS
const getReinos = async (body) => {
    let id = body.id
    const sql_all = `SELECT * FROM REINOS`;
    const sql_uniq = `SELECT * FROM REINOS WHERE reiid like '${id}'`;
    return await getData(body, sql_all, sql_uniq);
}

const getFilos = async (body) => {
    let id = body.id;
    const sql_all = `SELECT * FROM filos`;
    const sql_uniq = `SELECT * FROM filos WHERE reiid like '${id}'`;
    return await getData(body, sql_all, sql_uniq);
}

const getClases = async (body) => {
    let id = body.id;
    const sql_all = `SELECT * FROM clases`;
    const sql_uniq = `SELECT * FROM clases WHERE clases.filid like '${id}'`;
    return await getData(body, sql_all, sql_uniq);
}

const getOrdenes = async (body) => {
    let id = body.id;
    const sql_all = `SELECT * FROM ordenes`;
    const sql_uniq = `SELECT * FROM ordenes WHERE ordenes.claid like '${id}'`;
    return await getData(body, sql_all, sql_uniq);
}

const getFamilias = async (body) => {
    let id = body.id;
    const sql_all = `SELECT * FROM familias`;
    const sql_uniq = `SELECT * FROM familias WHERE familias.ordid like '${id}'`;
    return await getData(body, sql_all, sql_uniq);
}

const getGeneros = async (body) => {
    let id = body.id;
    const sql_all = `SELECT * FROM generos`;
    const sql_uniq = `SELECT * FROM generos WHERE generos.famid like '${id}'`;
    return await getData(body, sql_all, sql_uniq);
}

const getEspecies = async (body) => {
    let id = body.id;
    const sql_all = `SELECT * FROM especies`;
    const sql_uniq = `SELECT * FROM especies WHERE especies.genid like '${id}'`;
    return await getData(body, sql_all, sql_uniq);
}


const postRegister = async (body) => {

    try {

    } catch (error) {
        console.error("Error en la consulta:", error);
        throw error;
    }
}
const login = async (body) => {
    let email = body.email;
    let password = body.password;
    let query = `SELECT * FROM usuarios WHERE usucorreo = '${email}' AND usucontrasenia = '${password}'`;
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
app.get('/registers/reinos', async (req, res) => { res.send(await getReinos(req.body)) });
app.get('/registers/filos', async (req, res) => { res.send(await getFilos(req.body)) });
app.get('/registers/clases', async (req, res) => { res.send(await getClases(req.body)) });
app.get('/registers/ordenes', async (req, res) => { res.send(await getOrdenes(req.body)) });
app.get('/registers/familias', async (req, res) => { res.send(await getFamilias(req.body)) });
app.get('/registers/generos', async (req, res) => { res.send(await getGeneros(req.body)) });
app.get('/registers/especies', async (req, res) => { res.send(await getEspecies(req.body)) });

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


//PROTISTAS
app.post('/registers/filos', async (req, res) => { res.send(await getFilos(req.body)) });
app.post('/registers/clases', async (req, res) => { res.send(await getClases(req.body)) });
app.post('/registers/ordenes', async (req, res) => { res.send(await getOrdenes(req.body)) });
app.post('/registers/familias', async (req, res) => { res.send(await getFamilias(req.body)) });
app.post('/registers/generos', async (req, res) => { res.send(await getGeneros(req.body)) });
app.post('/registers/especies', async (req, res) => { res.send(await getEspecies(req.body)) });

app.post('/registers/clases', async (req, res) => { res.send(await getClases(req.body)) });
//#endregion


app.listen(port, () => { console.log("localhost:" + port) });
