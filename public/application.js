$(document).ready(function(){
  
  $('.create_event'). on("click",function(e){
    e.preventDefault();
    $('#myForm').show();
    $(this).hide();
  });

  $('#myForm').on("submit",function(e){
    e.preventDefault();
    $(this).hide();
    $('.create_event').show();
    var data = $('#myForm').serialize();
    
    $.ajax({
    url:"/create_event",
    type:"post",
    data:data,
    success :function(response){
      console_log("this is workding")
      $('.replace_html').html(response);
    }
    });  
   });
  });
