const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
if(urlParams.has("new")) {
    document.getElementById("allpackage").parentNode.removeChild(document.getElementById("allpackage"));
    alert("Seja bem-vindo a família!\nAinda estamos trabalhando na sua conta, por isso essa aba será reiniciada em 3 Segundos!\nPor favor, não reinice antes.");
    setTimeout(function () {
        window.location.href = "index.jsp";
    }, 3000);
}