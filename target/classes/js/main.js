function inputChoice(nameBorder, nameTitle) {
    var border=document.getElementById(nameBorder);
    border.style.border = "2px solid #69ADFF";
    var title=document.getElementById(nameTitle);
    title.style.color = "#69ADFF";
}

function inputunChoice(nameBorder, nameTitle) {
    var border=document.getElementById(nameBorder);
    if(window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
        border.style.border = "2px solid rgba(255, 255, 255, 0.3)";
    } else {
        border.style.border = "2px solid rgba(0, 0, 0, 0.3)";
    }
    var title=document.getElementById(nameTitle);
    if(window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
        title.style.color = "#FFF";
    } else {
        title.style.color = "#000";
    }
}
