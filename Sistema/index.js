import express from "express";
import cors from "cors";
import { pool } from "./db.js";

const app = express();
app.use(cors());
app.use(express.json());

app.post('/reserva', async (req, res) => {
    const { id_estadoasiento, id_estadoreserva, rut_cliente, id_vuelo, valor } = req.body;
    try {
        const [lastReservaIdResult] = await pool.query('SELECT MAX(id_reserva) AS last_reserva_id FROM reserva');
        const lastReservaId = lastReservaIdResult[0].last_reserva_id || 0;
        const newReservaId = lastReservaId + 1;

        await pool.query(
            'INSERT INTO reserva (id_reserva, id_estadoasiento, id_estadoreserva, rut_cliente, id_vuelo, valor) VALUES (?, ?, ?, ?, ?, ?)',
            [newReservaId, id_estadoasiento, id_estadoreserva, rut_cliente, id_vuelo, valor]
        );

        res.json({ success: true, message: 'Reserva realizada correctamente', resultado: { newReservaId } });
    } catch (error) {
        console.error('Error al realizar reserva:', error);
        res.status(500).json({ success: false, message: 'Error interno del servidor', error });
    }
});

app.get('/reserva', async (req, res) => {
    try {
        const [resultado] = await pool.query('SELECT * FROM reserva');
        res.json(resultado);
    } catch (error) {
        console.error('Error al obtener las reservas:', error);
        res.status(500).json({ success: false, message: 'Error interno del servidor' });
    }
});

app.post('/vuelo', async (req, res) => {
    let fecha, ciudad_origen, ciudad_destino, hora;

    if (req.body) {
        // Si la solicitud tiene un cuerpo (req.body), usamos esos datos
        fecha = req.body.fecha;
        ciudad_origen = req.body.ciudad_origen;
        ciudad_destino = req.body.ciudad_destino;
        hora = req.body.hora;
    } else {
        // Si no hay cuerpo, asumimos que los datos están en parámetros de ruta
        fecha = req.query.fecha;
        ciudad_origen = req.query.ciudad_origen;
        ciudad_destino = req.query.ciudad_destino;
        hora = req.query.hora;
    }

    try {
        const [lastVueloIdResult] = await pool.query('SELECT MAX(id_vuelo) AS last_vuelo_id FROM vuelo');
        const lastVueloId = lastVueloIdResult[0].last_vuelo_id || 0;
        const newVueloId = lastVueloId + 1;

        await pool.query(
            'INSERT INTO vuelo (id_vuelo, fecha, ciudad_origen, ciudad_destino, hora) VALUES (?, ?, ?, ?, ?)',
            [newVueloId, fecha, ciudad_origen, ciudad_destino, hora]
        );
        res.json({ success: true, message: 'Vuelo agregado correctamente', resultado: { newVueloId } });
    } catch (error) {
        console.error('Error al agregar vuelo:', error);
        res.status(500).json({ success: false, message: 'Error interno del servidor', error });
    }
});

app.get('/vuelo', async (req, res) => {
    const { fecha, ciudad_origen, ciudad_destino, hora } = req.query;
    if (!fecha || !ciudad_origen || !ciudad_destino || !hora) {
        return res.status(400).json({ error: 'Faltan parámetros en la solicitud.' });
    }

    try {
        const [result] = await pool.query(
            'SELECT id_vuelo FROM vuelo WHERE fecha = ? AND ciudad_origen = ? AND ciudad_destino = ? AND hora = ?',
            [fecha, ciudad_origen, ciudad_destino, hora]
        );

        if (result.length !== 0) {
            res.json({ id_vuelo: result[0].id_vuelo });
        } else {
            res.json({ id_vuelo: 0 });
        }
    } catch (error) {
        console.error('Error al verificar vuelo existente:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
});

app.post('/cliente', async (req, res) => {
    const { rut, nombre, apellido, correo, telefono } = req.body;
    try {
        const telefonoInt = telefono ? parseInt(telefono, 10) : null;
        const [resultado] = await pool.query(
        'INSERT INTO cliente (rut, nombre, apellido, correo, telefono) VALUES (?, ?, ?, ?, ?)',
        [rut, nombre, apellido, correo, telefonoInt]
        );
        res.json({ success: true, message: 'Cliente agregado correctamente', resultado });
    } catch (error) {
        console.error('Error al agregar cliente:', error);
        res.status(500).json({ success: false, message: 'Error interno del servidor', error });
    }
});

app.get('/cliente', async (req, res) => {
    try {
        const [resultado] = await pool.query('SELECT * FROM cliente');
        res.json(resultado);
    } catch (error) {
        console.error('Error al obtener clientes:', error);
        res.status(500).json({ success: false, message: 'Error interno del servidor' });
    }
});

app.delete('/cliente/:rut', async (req, res) => {
    try {
        const [resultado] = await pool.query('DELETE FROM cliente WHERE rut = ?', [req.params.rut]);
        res.json({ success: true, message: 'Cliente eliminado correctamente', resultado });
    } catch (error) {
        console.error('Error al eliminar cliente:', error);
        res.status(500).json({ success: false, message: 'Error interno del servidor' });
    }
});

app.put('/cliente/:rut', async (req, res) => {
    const { nombre, apellido, correo, telefono } = req.body;
    try {
        const [resultado] = await pool.query(
            'UPDATE cliente SET nombre=?, apellido=?, correo=?, telefono=? WHERE rut=?',
            [nombre, apellido, correo, telefono, req.params.rut]
        );
        res.json({ success: true, message: 'Cliente actualizado correctamente', resultado });
    } catch (error) {
        console.error('Error al actualizar cliente:', error);
        res.status(500).json({ success: false, message: 'Error interno del servidor' });
    }
});

app.get('/cliente/:rut', async (req, res) => {
    try {
        const [resultado] = await pool.query('SELECT * FROM cliente WHERE rut = ?', [req.params.rut]);
        if (resultado.length > 0) {
            res.json(resultado[0]);
        } else {
            res.status(404).json({ success: false, message: 'Cliente no encontrado' });
        }
    } catch (error) {
        console.error('Error al obtener cliente por rut:', error);
        res.status(500).json({ success: false, message: 'Error interno del servidor' });
    }
});

app.listen(5500);
console.log("Servidor escuchando en el puerto 5500");