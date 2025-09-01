const faqs = [
  { question: "Quelle est l'autonomie du drone ?", answer: "Nos drones ont une autonomie de 30 à 40 minutes selon le modèle." },
  { question: "Peut-on filmer en 4K ?", answer: "Oui, tous nos modèles de drones Premium offrent la 4K à 60fps." },
  { question: "Quelle est la portée du contrôle à distance ?", answer: "La portée varie de 2 à 5 km selon les conditions et modèles." },
  { question: "Le drone peut-il résister au vent ?", answer: "Nos drones supportent des vents jusqu'à 25 km/h." },
  { question: "Est-ce que le drone revient automatiquement ?", answer: "Oui, tous les modèles disposent d’un retour automatique en cas de perte de signal ou batterie faible." }
];

const faqContainer = document.getElementById("faq-container");
const faqTemplate = document.getElementById("faq-template").content;

// Fonction pour créer les FAQ
faqs.forEach(faq => {
  const clone = faqTemplate.cloneNode(true);
  clone.querySelector(".faq-title").textContent = faq.question;
  clone.querySelector(".faq-answer").textContent = faq.answer;

  const questionBtn = clone.querySelector(".faq-question");
  const answerDiv = clone.querySelector(".faq-answer");
  const icon = clone.querySelector(".faq-icon");

  // Accordéon : toggle
  questionBtn.addEventListener("click", () => {
    const isOpen = answerDiv.classList.contains("show");
    
    // Fermeture de toutes les autres réponses (optionnel)
    document.querySelectorAll(".faq-answer").forEach(div => div.classList.remove("show"));
    document.querySelectorAll(".faq-icon").forEach(ic => ic.textContent = "+");

    if(!isOpen) {
      answerDiv.classList.add("show");
      icon.textContent = "−";
    }
  });

  faqContainer.appendChild(clone);
});

// Recherche dynamique
const searchInput = document.getElementById("faq-search");
searchInput.addEventListener("input", () => {
  const search = searchInput.value.toLowerCase();
  document.querySelectorAll(".faq-item").forEach(item => {
    const question = item.querySelector(".faq-title").textContent.toLowerCase();
    item.style.display = question.includes(search) ? "block" : "none";
  });
});