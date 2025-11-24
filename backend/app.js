// ===============================
// PRINTSIDE - Backend Express API
// ===============================

const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// -------------------------
// Connexion MySQL
// -------------------------
const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "printside"
});

db.connect((err) => {
    if (err) {
        console.error("Erreur connexion MySQL:", err);
        return;
    }
    console.log("Connexion MySQL réussie");
});

// -------------------------
// Route de test
// -------------------------
app.get('/', (req, res) => {
    res.send("Printside Backend API fonctionne !");
});

// -------------------------
// Lancement du serveur
// -------------------------
app.listen(3000, () => {
    console.log("Serveur backend démarré sur http://localhost:3000");
});
