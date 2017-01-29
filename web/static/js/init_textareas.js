var input_mirror, output_mirror, last_error;
var toast_duration = 2000;

function sendRequest() {
  var params = { slime: input_mirror.getValue() }
  $.post("/api/slime2html", params)
    .done(function(response) {
      output_mirror.setValue(response.html)
      if (last_error) {
        Materialize.toast("Now it's OK", toast_duration, "green lighten-1")
        last_error = null;
      };
    })
    .fail(function(response) {
      var message = response.responseJSON.error;
      if (last_error != message) {
        Materialize.toast(message, toast_duration, "red lighten-1")
        last_error = message;
      }
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
  mode: "application/x-erb",
  readOnly: true
})

input_mirror.on("change", function(){
  sendRequest()
})
