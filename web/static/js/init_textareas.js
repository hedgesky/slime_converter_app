function sendRequest() {
  var params = {
    slime: $("#slime-input").val()
  }
  $.post("/api/slime2html", params, function(response) {
    $("#html-output").val(response.html)
    console.log(response.html)
  })
}


var input_mirror = CodeMirror.fromTextArea($("#slime-input").get()[0], {
  lineNumbers: true,
  theme: "material",
  mode: "application/x-slim",
  autofocus: true
})

CodeMirror.fromTextArea($("#html-output").get()[0], {
  lineNumbers: true,
  theme: "material",
  mode: "text/html",
  readOnly: true
})

input_mirror.on("change", function(){
  sendRequest()
})