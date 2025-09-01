let data = [
    {
        id: 1,
        name: "Julie M.",
        review:
            "Drone très facile à piloter pour débutant. Autonomie correcte, caméra avec de belles images.",
        rating: 4,
    },
    {
        id: 2,
        name: "Karim D.",
        review:
            "Vol très stable, le retour automatique est pratique. Temps de charge un peu long.",
        rating: 4,
    },
    {
        id: 3,
        name: "Élodie R.",
        review:
            "Qualité vidéo 4K impressionnante. Application mobile intuitive, bonne portée.",
        rating: 5,
    },
    {
        id: 4,
        name: "Thomas B.",
        review:
            "Bon rapport qualité/prix pour s’initier aux vues aériennes, un peu fragile en cas de chute.",
        rating: 3,
    },
    {
        id: 5,
        name: "Sophie L.",
        review:
            "Suivi de sujet efficace, mais bruit des hélices notable en intérieur.",
        rating: 4,
    },
    {
        id: 6,
        name: "Lucas P.",
        review:
            "Excellente stabilité au vent, GPS précis. Accessoires un peu chers.",
        rating: 4,
    },
    {
        id: 7,
        name: "Nora A.",
        review:
            "Batteries interchangeables pratiques. Le mode ciné donne un rendu pro.",
        rating: 5,
    },
    {
        id: 8,
        name: "Hugo C.",
        review:
            "Montage rapide, pliable et compact. Le manuel pourrait être plus clair.",
        rating: 4,
    },
    {
        id: 9,
        name: "Clara V.",
        review:
            "Très bonne portée et retour vidéo fluide. Latence légère en 4K 60fps.",
        rating: 4,
    },
    {
        id: 10,
        name: "Mathis G.",
        review:
            "Idéal pour voyager, sac inclus. Manque de capteurs latéraux sur ce modèle.",
        rating: 3,
    },
];

const add_avis = document.getElementById('add card-template');
document.body.appendChild(add_avis.content.cloneNode(true));
addAvis(data)

function addAvis(data) {
    const card_avis = document.getElementById('card-template');
    const section_avis = document.getElementById('avis');
    section_avis.innerHTML = ""
    data.forEach((data, index) => {
        const avis = card_avis.content.cloneNode(true);
        avis.querySelector('.card').id = index + 1
        avis.querySelector('.rating').textContent = data.rating;
        avis.querySelector('.name').textContent = data.name;
        avis.querySelector('.review').textContent = data.review;
         avis.querySelector('.del').addEventListener('click',(e)=>{
            console.log(e.target.parentElement)
            deleteAvis(e.target.parentElement)
         })
        section_avis.appendChild(avis);
    });
}


const btnSubmit = document.getElementById('submit');
btnSubmit.addEventListener('click', (e) => {
    e.preventDefault()
    const DataFrom = new FormData(e.target.form)
    const name = DataFrom.get('name')
    const rating = DataFrom.get('rating')
    const review = DataFrom.get('review')
    const data_ = { name: name, review: review, rating: parseInt(rating) }
    data.unshift(data_)
    addAvis(data)
})

const deleteAvis = (avis)=>{
data.splice(avis - 1 ,1 )
addAvis(data)
}