
    const form = document.getElementById("contactForm");
    const modal = document.getElementById("modal");
    const closeModal = document.getElementById("closeModal");

    form.addEventListener("submit", function(e) {
      e.preventDefault();

      let valid = true;

      // Nom
      const name = document.getElementById("name");
      const nameError = document.getElementById("nameError");
      if(name.value.trim() === "") {
        nameError.textContent = "Veuillez entrer votre nom";
        valid = false;
      } else {
        nameError.textContent = "";
      }

      // Email
      const email = document.getElementById("email");
      const emailError = document.getElementById("emailError");
      const emailRegex = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
      if(!email.value.match(emailRegex)) {
        emailError.textContent = "Veuillez entrer un email valide";
        valid = false;
      } else {
        emailError.textContent = "";
      }

      // Message
      const message = document.getElementById("message");
      const messageError = document.getElementById("messageError");
      if(message.value.trim() === "") {
        messageError.textContent = "Veuillez écrire un message";
        valid = false;
      } else {
        messageError.textContent = "";
      }

      // Si tout est valide
      if(valid) {
        modal.style.display = "flex";
        form.reset();
      }
    });

    closeModal.addEventListener("click", () => {
      modal.style.display = "none";
    });

    window.addEventListener("click", (e) => {
      if(e.target === modal) {
        modal.style.display = "none";
      }
    });