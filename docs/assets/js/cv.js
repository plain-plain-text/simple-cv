// If the navbar is fixed-top, we need to push the container down, etc.
if($(".fixed-top").length){
  $("#cvBody").css("margin-top",  $("#navbar").height() + $(".fixed-top").data("margin") + "px");
}
if($(".fixed-bottom").length){
  $("#cvBody").css("margin-bottom",  $("#navbar").height() + $(".fixed-bottom").data("margin") + "px");
}

if($(window).width() > 575){
  $("#widgets").removeClass("w-50").addClass("w-25");
}

// Build the dropdown.
$("#navList").html(() => {
  let list = "";
  $("h2").each(function(){ // can't use => because of setting this.
    list = list + "<li class='nav-item'>\n";
    list = list + "<a class='nav-link' onclick='closeDropdown()' href='#" + $( this ).attr("id") + "'>";
    list = list + $( this ).html() + "</a>\n</li>\n";
  });
  return list;
});

// always close responsive nav after click
function closeDropdown(){
  $(".navbar-toggler:visible").click();
}

// replace \LaTeX
$("body:contains('\LaTeX')").html(function(_, html){ return html.replace("\\LaTeX", "<span class='latex'>L<sup>A</sup>T<sub>E</sub>X</span>"); });


function fetchHeader(url, wch) {
  try {
    var req=new XMLHttpRequest();
    req.open("HEAD", url, false);
    req.send(null);
    if(req.status === 200){
      return req.getResponseHeader(wch);
    }
    else { return "Failed to get 200 status"; }
  } catch(er) {
    return "Failed to get date."
  }
}

let lastMod = fetchHeader(location.href, "Last-Modified");
$("#last-modified").html("<small>Last Modified: " + lastMod.replace(/ \S+ \S+$/, "</small>"));

