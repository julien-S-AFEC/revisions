
const iframes = document.querySelectorAll("iframe");

for (let iframe of iframes) {
    iframe.onload = () => {
        const doc = iframe.contentDocument || iframe.contentWindow.document;
        iframe.style.height = doc.body.scrollHeight + 30 + "px";
    }
}
