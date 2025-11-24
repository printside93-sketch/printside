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
// ===============================
// ROUTES CLIENTS
// ===============================

// 1. Ajouter un client
app.post('/clients', (req, res) => {
    const { nom, telephone, adresse } = req.body;

    const sql = "INSERT INTO clients (nom, telephone, adresse) VALUES (?, ?, ?)";
    db.query(sql, [nom, telephone, adresse], (err, result) => {
        if (err) return res.status(500).send("Erreur insertion client");
        res.send({ message: "Client ajouté", id: result.insertId });
    });
});

// 2. Récupérer tous les clients
app.get('/clients', (req, res) => {
    db.query("SELECT * FROM clients ORDER BY id DESC", (err, rows) => {
        if (err) return res.status(500).send("Erreur récupération clients");
        res.send(rows);
    });
});

// 3. Supprimer un client
app.delete('/clients/:id', (req, res) => {
    const { id } = req.params;

    const sql = "DELETE FROM clients WHERE id = ?";
    db.query(sql, [id], (err) => {
        if (err) return res.status(500).send("Erreur suppression client");
        res.send({ message: "Client supprimé" });
    });
});

// -------------------------
// Lancement du serveur
// -------------------------
app.listen(3000, () => {
    console.log("Serveur backend démarré sur http://localhost:3000");
});
