const form = document.getElementById("form");

form.addEventListener('submit', (e) => {
    e.preventDefault();
try {
    
} catch (error) {
    
}
    const formData = new FormData(form);
    const file = formData.get('file')
    console.log(e.target[3].value)
    const fileInput = document.getElementById("fileJoin");

  
        formData.append('file', e.target[3].value); // 'file' correspond au backend
    

    fetch("http://localhost:3000/images", {
        method: "POST",
        body: formData
    })
    .then(res => res.text())
    .then(data => console.log("Réponse serveur :", data))
    .catch(err => console.error("Erreur :", err));
});
