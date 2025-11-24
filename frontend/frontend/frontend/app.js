document.getElementById("btn-test").addEventListener("click", () => {
    fetch("http://localhost:3000/")
        .then(res => res.text())
        .then(data => {
            document.getElementById("resultat").innerText = data;
        })
        .catch(err => {
            document.getElementById("resultat").innerText = "Erreur de connexion";
        });
});
// ==========================
// Ajouter un client
// ==========================
document.getElementById("btn-ajout-client").addEventListener("click", () => {
    const nom = document.getElementById("nom").value;
    const telephone = document.getElementById("telephone").value;
    const adresse = document.getElementById("adresse").value;

    fetch("http://localhost:3000/clients", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ nom, telephone, adresse })
    })
    .then(res => res.json())
    .then(data => {
        alert("Client ajouté !");
        chargerClients();
    });
});

// ==========================
// Charger la liste des clients
// ==========================
function chargerClients() {
    fetch("http://localhost:3000/clients")
        .then(res => res.json())
        .then(data => {
            const tbody = document.querySelector("#table-clients tbody");
            tbody.innerHTML = "";

            data.forEach(c => {
                const row = `
                    <tr>
                        <td>${c.id}</td>
                        <td>${c.nom}</td>
                        <td>${c.telephone}</td>
                        <td>${c.adresse}</td>
                        <td><button onclick="supprimerClient(${c.id})">X</button></td>
                    </tr>
                `;
                tbody.innerHTML += row;
            });
        });
}

// ==========================
// Supprimer un client
// ==========================
function supprimerClient(id) {
    fetch(`http://localhost:3000/clients/${id}`, {
        method: "DELETE"
    })
    .then(res => res.json())
    .then(() => {
        alert("Client supprimé !");
        chargerClients();
    });
}

chargerClients();
