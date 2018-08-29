$(document).foundation()
$(document).ready(function() {
    var aliveRadio = document.getElementById("id_alive_0");
    var deceasedRadio = document.getElementById("id_alive_1");
    if (aliveRadio != null) {
        if (aliveRadio.checked == true) {
            dates_off(); }
        if (aliveRadio.checked == false) {
            dates_on(); }
        aliveRadio.onclick = dates_off;
        deceasedRadio.onclick = dates_on;
 	}
});

function dates_off() {
    var byearField = document.getElementById("birth_year");
    var dyearField = document.getElementById("death_year");
    byearField.value = "";
    dyearField.value = "";
    byearField.disabled = true;
    dyearField.disabled = true;
}
function dates_on() {
    var byearField = document.getElementById("birth_year");
    var dyearField = document.getElementById("death_year");
    byearField.disabled = false;
    dyearField.disabled = false;
}