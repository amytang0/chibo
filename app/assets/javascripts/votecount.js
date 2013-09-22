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
        },
        error: function(request, status, error) {
          console.log("failed vote up");
          window.location.href = "/users/sign_in";
        }
      });
      } else {
        $.ajax({
          type: 'POST',
          url: "/posts/"+theid+"/vote_down",
          success: function(){
            console.log("vote down");
        },   
          error: function() {
          console.log("failed vote down");
           window.location.href = "/users/sign_in";

        }
    });
    }
})

});
