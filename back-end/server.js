// backend/server.js
const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');

const app = express();
app.use(bodyParser.json());

// Configuração da conexão com o banco de dados PostgreSQL
const pool = new Pool({
    user: 'admin_connexus', // Usuário do banco de dados
    host: 'localhost',
    database: 'connexus_db',
    password: 'admin123', // Senha do usuário
    port: 5432,
});

// Rota para testar a conexão com o banco de dados
app.get('/test', async (req, res) => {
    try {
        const result = await pool.query('SELECT NOW() AS current_time');
        res.send(result.rows[0].current_time);
    } catch (err) {
        console.error(err);
        res.status(500).send('Erro ao acessar o banco de dados');
    }
});

// Iniciar o servidor
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
});