const bcrypt = require('bcrypt');
const saltRounds = 10;
const plainPassword = 'Marina2004'; // Substitua por sua senha desejada

bcrypt.hash(plainPassword, saltRounds, function(err, hash) {
    console.log(hash); // Use este hash como a senha no banco de dados
});