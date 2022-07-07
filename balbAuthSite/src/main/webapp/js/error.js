const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
if(urlParams.has('error')){
    alert(urlParams.get('error'));
}