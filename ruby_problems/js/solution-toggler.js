$(document).ready(function() {
    $(".close-link").click(function(){
        var container = $($(this).parent().parent().next().children()[0]);
        if(container.find(".fade").css("display") == "block")
        {
          $($(this).children()[0]).attr("src", "img/arrow_open.png");
          container.find(".fade").css("display", "none");
          container.animate({
            height: container.find(".ruby").css("height")
          }, 150, "linear", function() {             
            container.find(".wrapper").css("overflow-x", "auto");
           } );
        }
        else
        {
          $($(this).children()[0]).attr("src", "img/arrow_close.png");
          container.find(".wrapper").css("overflow-x", "hidden");          
          container.animate({
            height: 50
          }, 150, "linear", function() { container.find(".fade").css("display", "block")} );
        }
    });
});