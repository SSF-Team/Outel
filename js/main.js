function showLogin() {
    var loginPan=document.getElementById("loginPan");
    loginPan.style.visibility = "visible";
}

function hidLogin() {
    var loginPan=document.getElementById("loginPan");
    loginPan.style.visibility = "collapse";
}

function inputChoice(nameBorder, nameTitle) {
    var border=document.getElementById(nameBorder);
    border.style.border = "2px solid #69ADFF";
    var title=document.getElementById(nameTitle);
    title.style.color = "#69ADFF";
}

function inputunChoice(nameBorder, nameTitle) {
    var border=document.getElementById(nameBorder);
    border.style.border = "2px solid rgba(0, 0, 0, 0.3)";
    var title=document.getElementById(nameTitle);
    title.style.color = "#000";
}