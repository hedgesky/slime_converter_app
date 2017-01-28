var input_mirror = null;
var output_mirror = null;

function sendRequest() {
  var params = { slime: input_mirror.getValue() }
  $.post("/api/slime2html", params)
    .done(function(response) {
      output_mirror.setValue(response.html)
    })
    .fail(function(response) {
      console.log(response.responseJSON.error)
    })
}


input_mirror = CodeMirror.fromTextArea($("#slime-input").get()[0], {
  lineNumbers: true,
  theme: "material",
  mode: "application/x-slim",
  autofocus: true
})

output_mirror = CodeMirror.fromTextArea($("#html-output").get()[0], {
  lineNumbers: true,
  theme: "material",
  mode: "text/html",
  readOnly: true
})

input_mirror.on("change", function(){
  sendRequest()
})