// If the navbar is fixed-top, we need to push the container down, etc.
if($(".fixed-top").length){
  $("#cvBody").css("margin-top",  $("#navbar").height() + 20 + "px");
}
if($(".fixed-bottom").length){
  $("#cvBody").css("margin-bottom",  $("#navbar").height() + 20 + "px");
}

