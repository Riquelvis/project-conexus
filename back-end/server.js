require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
app.use(bodyParser.json());
app.use(cors());

// Variáveis de ambiente
const jwtSecret = process.env.JWT_SECRET || 'chave_segura_default';
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
});

// Middleware de autenticação
function authenticate(requiredLevel) {
    return async (req, res, next) => {
        const authHeader = req.headers.authorization;

        if (!authHeader) {
            return res.status(401).json({ error: 'Acesso não autorizado!' });
        }

        const token = authHeader.split(' ')[1];
        if (!token) {
            return res.status(401).json({ error: 'Token inválido!' });
        }

        try {
            const decoded = jwt.verify(token, jwtSecret);
            req.user = decoded;

            if (requiredLevel && decoded.nivel_acesso < requiredLevel) {
                return res.status(403).json({ error: 'Acesso negado!' });
            }

            next();
        } catch (error) {
            return res.status(403).json({ error: 'Falha na autenticação!' });
        }
    };
}

// Rota de login
app.post('/login', async (req, res) => {
    const { input, password } = req.body;

    if (!input || !password) {
        return res.status(400).json({ error: 'Por favor, preencha todos os campos.' });
    }

    try {
        const isEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(input);

        let user;
        if (isEmail) {
            user = await pool.query('SELECT * FROM usuarios WHERE email = $1', [input]);
        } else {
            user = await pool.query('SELECT * FROM usuarios WHERE nome = $1', [input]);
        }

        if (user.rows.length === 0) {
            return res.status(401).json({ error: 'Credenciais inválidas!' });
        }

        const isValidPassword = await bcrypt.compare(password, user.rows[0].senha);
        if (!isValidPassword) {
            return res.status(401).json({ error: 'Credenciais inválidas!' });
        }

        const token = jwt.sign(
            { id: user.rows[0].id_usuario, nivel_acesso: user.rows[0].tipo_usuario },
            jwtSecret,
            { expiresIn: '1h' }
        );

        res.json({
            message: 'Login bem-sucedido!',
            token,
            user: {
                id: user.rows[0].id_usuario,
                name: user.rows[0].nome,
                nivel_acesso: user.rows[0].tipo_usuario,
            },
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Erro interno do servidor.' });
    }
});

// Rota protegida para administradores
app.get('/admin/all-data', authenticate(3), async (req, res) => {
    try {
        const clientes = await pool.query('SELECT * FROM public.clientes');
        const enderecos = await pool.query('SELECT * FROM public.enderecos');
        const historico = await pool.query('SELECT * FROM public.historico_interacoes');

        res.json({
            clientes: clientes.rows,
            enderecos: enderecos.rows,
            historico: historico.rows,
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Erro ao acessar os dados.' });
    }
});

// Função para criptografar senhas existentes (somente se ainda não estiverem criptografadas)
async function hashPasswords() {
    try {
        const users = await pool.query('SELECT * FROM usuarios');
        for (const user of users.rows) {
            if (!user.senha.startsWith('$2b$')) {
                const hashedPassword = await bcrypt.hash(user.senha, 10);
                await pool.query('UPDATE usuarios SET senha = $1 WHERE id_usuario = $2', [hashedPassword, user.id_usuario]);
                console.log(`Senha criptografada para usuário ID: ${user.id_usuario}`);
            } else {
                console.log(`Senha já criptografada para usuário ID: ${user.id_usuario}`);
            }
        }
        console.log('Processo de verificação de senhas finalizado!');
    } catch (error) {
        console.error('Erro ao criptografar senhas:', error);
    }
}

// ✅ Função utilitária para comparar senhas manualmente
async function verificarSenha(passwordEnviada, senhaCriptografada) {
    try {
        const isValid = await bcrypt.compare(passwordEnviada, senhaCriptografada);
        console.log(isValid ? 'Senha válida' : 'Senha inválida');
        return isValid;
    } catch (error) {
        console.error('Erro ao verificar senha:', error);
        return false;
    }
}

// Iniciar o servidor
app.listen(3000, () => {
    console.log('Servidor rodando na porta 3000');
    // hashPasswords(); // Descomente apenas se necessário
});
