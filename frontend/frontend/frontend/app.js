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
