$(document).ready(function() {
    $("#"+window.location.href.split("/").pop().split(".").shift()).attr("class", "current");
});