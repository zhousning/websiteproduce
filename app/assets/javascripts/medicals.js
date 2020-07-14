$(document).ready(function(){
  $("input[name*='major']").change(function(){
    count = 0;
    $("input[name*='major']").each(function(){
      if ($(this).val() != '') {
        count += parseInt($(this).val());  
      }
    })
    $(".question-finished-choose").html(count);
  })
})
