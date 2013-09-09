$(function(){
    console.log("votecount.js is being called");
  $(document).on("click",".ratelink", function() {
    console.log("ratelink button was clicked");

    var val = $(this).attr('updown');
    var theid = $(this).attr('theid');
    if (val == "up") {
      $.ajax({
        type: 'POST',
        url: "/posts/"+theid+"/vote_up",
        success: function(){
          console.log("vote up");
        }
      });
      } else {
        $.ajax({
          type: 'POST',
          url: "/posts/"+theid+"/vote_down",
          success: function(){
            console.log("vote down");
        }   
      });
    }
})

});
