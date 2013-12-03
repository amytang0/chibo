$(document).ready(function(){

function xinspect(o,i){
    if(typeof i=='undefined')i='';
        if(i.length>50)return '[MAX ITERATIONS]';
            var r=[];
                for(var p in o){
                        var t=typeof o[p];
                                r.push(i+'"'+p+'" ('+t+') => '+(t=='object' ? 'object:'+xinspect(o[p],i+'  ') : o[p]+''));
                                    }
                                        return r.join(i+'\n');
                                        }



  $(document).on( 'input', '.budget_field',
    function() {
      var value = $(this).val();
    var theid = $('.dynamic_cost_box').attr('theid');
      console.log("budget form submitted "+ value);

      $.ajax({
      type: 'POST',
      url: "/posts/update_all",
      data: {'post' : {'budget' : $(this).val()},
             'id' : theid},
      success: function(response){
      console.log("updated all budget"+response);
      $('.dynamic_cost_box').html(response);
      $('.budget_field').focus().val(value);
      $('.budget_field').focus();
      },
      error: function(request, status, error) {
      console.log("failed update all budget"+request+"\n"+status+"\n"+error);
      $('.budget_form').submit();
      }
      });
      });


  $(document).on( 'input', '.people_field',
    function() {

      var value = $(this).val();
    var theid = $('.dynamic_cost_box').attr('theid');
      console.log("people form submitted "+value);


      $.ajax({
      type: 'POST',
      url: "/posts/update_all",
      data: {'post' : {'numberofpeople' : $(this).val()}, 
             'id' : theid},
      success: function(response){
      console.log("updated all people");
      $('.dynamic_cost_box').html(response);
      $('.people_field').focus().val(value);
      $('.people_field').focus();
      },
      error: function(request, status, error) {
      console.log("failed update all people"+request+"\n"+status+"\n"+error);
      $('.people_form').submit();
      }
      });
      });

  });
