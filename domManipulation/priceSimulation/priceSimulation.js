const price = document.getElementById('price')
price.textContent = '500.99'

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
const powers = ['500', '600', '700', '800']

powers.forEach(power => {
    const frag = powerFragment.content.cloneNode(true)
    const options = frag.getElementById('powerOptions')
    let input = options.querySelector("input");
    let name = options.querySelector("#name");
    name.textContent = power + ' kw'
    input.price = power + '.99'
    powerInputs.appendChild(frag)
})
// Check the first one
powerInputs[0].checked = true

// Power: On click
const allPowerInput = document.getElementsByClassName('powerIpnut')
for (let elem of allPowerInput) {
    elem.addEventListener('click', () => {
        price.textContent = elem.price
    })
}