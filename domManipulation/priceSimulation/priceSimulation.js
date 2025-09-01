let basePrice = 0
let powerPrice = 199
let optionsPrice = 0
let discount = 100

const updatePrice = () => {
    let price = document.getElementById('price')
    const fullPrice = basePrice + powerPrice + optionsPrice
    price.textContent = ((fullPrice / 100) * discount).toFixed(3)
}

// Colors
const colorOptions = document.getElementById('colorDropdown')
const optionFragment = document.getElementById('optionFragment')
const colors = ['White', 'Black', 'Gray', 'Black/Red']

colors.forEach(color => {
    const frag = optionFragment.content.cloneNode(true)
    let option = frag.querySelector("option");
    option.value = color
    option.textContent = color
    colorOptions.appendChild(frag)
})

// Power
const powerInputs = document.getElementById('powerInputs')
const powerFragment = document.getElementById('powerFragment')
const powers = [{ name: "500", price: 199 }, { name: "600", price: 299 }, { name: "700", price: 399 }]

powers.forEach(power => {
    const frag = powerFragment.content.cloneNode(true)
    const options = frag.getElementById('powerOptions')
    let input = options.querySelector("input");
    let name = options.querySelector("#name");
    name.textContent = `${power.name} - ${power.price}€`
    input.price = power.price
    powerInputs.appendChild(frag)
})
// Check the first one
powerInputs[0].checked = true

// Power: On click
const allPowerInput = document.getElementsByClassName('powerInput')
for (let elem of allPowerInput) {
    elem.addEventListener('click', () => {
        powerPrice = elem.price
        updatePrice()
    })
}

// Options
const optionsInputs = document.getElementById('optionsInputs')
const optionsFragment = document.getElementById('optionsFragment')
const options = [{ name: "None", price: 0 }, { name: "Protections", price: 120 }, { name: "Propellers set", price: 199 }, { name: "4k Resolution", price: 299 }]

for (let option of options) {
    const frag = optionsFragment.content.cloneNode(true)
    const options = frag.getElementById('optionsRadio')
    let input = options.querySelector("input");
    let name = options.querySelector("#name");

    name.textContent = `${option.name} - ${option.price}€`
    input.price = option.price
    optionsInputs.appendChild(frag)
}

// Options: On click
const allOptionsInputs = document.getElementsByClassName('optionInput')
for (let elem of allOptionsInputs) {
    elem.addEventListener('click', () => {
        optionsPrice = elem.price
        updatePrice()
    })
}

// Check the first one
optionsInputs[0].checked = true

// Discount input
document.getElementById('discountInput').addEventListener('click', (e) => {
    if (!e.target.checked) {
        discount = 100
        updatePrice()
        return
    }
    discount = 80
    updatePrice()
})

// init
updatePrice()