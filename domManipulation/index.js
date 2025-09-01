
const priceSimulation = document.getElementById("priceSimulation");

priceSimulation.onload = () => {
    const doc = priceSimulation.contentDocument || priceSimulation.contentWindow.document;
    priceSimulation.style.height = doc.body.scrollHeight + 30 + "px";
};
