-- =========================================================
-- PRINTSIDE - Base de données de gestion d'imprimerie
-- Version PRO avec Foreign Keys
-- =========================================================

-- ---------------------
-- Table des utilisateurs (admin, employés)
-- ---------------------
CREATE TABLE utilisateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    role ENUM('admin', 'employe') DEFAULT 'employe',
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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
    utilisateur_id INT,
    date_commande DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) DEFAULT 0,
    statut ENUM('en attente', 'en cours', 'terminee', 'livree', 'annulee') DEFAULT 'en attente',
    FOREIGN KEY (client_id) REFERENCES clients(id),
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id)
);

-- ---------------------
-- Détails des commandes
-- ---------------------
CREATE TABLE commande_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    commande_id INT NOT NULL,
    produit_id INT NOT NULL,
    quantite INT NOT NULL,
    prix DECIMAL(10,2) NOT NULL,
    total_ligne DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (commande_id) REFERENCES commandes(id) ON DELETE CASCADE,
    FOREIGN KEY (produit_id) REFERENCES produits(id)
);

-- ---------------------
-- Table des achats (stock entrant)
-- ---------------------
CREATE TABLE achats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fournisseur_id INT NOT NULL,
    utilisateur_id INT,
    date_achat DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (fournisseur_id) REFERENCES fournisseurs(id),
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id)
);

-- ---------------------
-- Détails des achats
-- ---------------------
CREATE TABLE achat_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    achat_id INT NOT NULL,
    produit_id INT NOT NULL,
    quantite INT NOT NULL,
    prix DECIMAL(10,2) NOT NULL,
    total_ligne DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (achat_id) REFERENCES achats(id) ON DELETE CASCADE,
    FOREIGN KEY (produit_id) REFERENCES produits(id)
);

-- =========================================================
-- FIN DU FICHIER SQL
-- =========================================================
