-- =========================================================
-- PRINTSIDE - Base de données de gestion d'imprimerie
-- Version PRO avec Foreign Keys
-- =========================================================

-- ---------------------
-- Table des utilisateurs (admin, employés)
-- ---------------------
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'employee') DEFAULT 'employee',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------
-- Table des clients
-- ---------------------
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    telephone VARCHAR(30),
    adresse TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------
-- Table des fournisseurs
-- ---------------------
CREATE TABLE fournisseurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    telephone VARCHAR(20),
    adresse VARCHAR(255),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ---------------------
-- Table des produits / services (impression, photocopie, etc.)
-- ---------------------
CREATE TABLE produits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    description TEXT,
    prix_vente DECIMAL(10,2) NOT NULL,
    prix_achat DECIMAL(10,2),
    fournisseur_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (fournisseur_id) REFERENCES fournisseurs(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ---------------------
-- Table du stock
-- ---------------------
CREATE TABLE stock (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produit_id INT NOT NULL,
    quantite INT DEFAULT 0,
    date_maj TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (produit_id) REFERENCES produits(id) ON DELETE CASCADE
);

-- ---------------------
-- Table des commandes clients
-- ---------------------
CREATE TABLE commandes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    date_commande DATE NOT NULL,
    statut VARCHAR(50) DEFAULT 'en_attente',
    total DECIMAL(10,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (client_id) REFERENCES clients(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ---------------------
-- Détails des commandes
-- ---------------------
CREATE TABLE commande_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    commande_id INT NOT NULL,
    produit_id INT NOT NULL,
    quantite INT NOT NULL DEFAULT 1,
    prix_unitaire DECIMAL(10,2) NOT NULL,
    sous_total DECIMAL(10,2) GENERATED ALWAYS AS (quantite * prix_unitaire) STORED,

    FOREIGN KEY (commande_id) REFERENCES commandes(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (produit_id) REFERENCES produits(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ---------------------
-- Table des achats (stock entrant)
-- ---------------------
CREATE TABLE stock (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produit_id INT NOT NULL,
    quantite INT NOT NULL DEFAULT 0,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (produit_id) REFERENCES produits(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ---------------------
-- Détails des achats
-- ---------------------
CREATE TABLE achats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produit_id INT NOT NULL,
    fournisseur_id INT NOT NULL,
    quantite INT NOT NULL,
    prix_achat DECIMAL(10,2) NOT NULL,
    date_achat DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (produit_id) REFERENCES produits(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (fournisseur_id) REFERENCES fournisseurs(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================================
-- FIN DU FICHIER SQL
-- =========================================================
