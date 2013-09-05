$(document).ready(function(){

  $(".hover-panel").hover(function(){
    var white = $(this).find(".white-panel");
    var black = $(this).find(".black-panel");
    black.fadeIn(0);
    white.fadeOut(0);
    }
    ,
    function(){
    var white = $(this).find(".white-panel");
    var black = $(this).find(".black-panel");
    black.fadeOut(0);
    white.fadeIn(0);
    });
});
