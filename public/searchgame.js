function searchGame() {
    var search_string  = document.getElementById('search_string').value
    window.location = '/game/search/' + encodeURI(search_string)
}
