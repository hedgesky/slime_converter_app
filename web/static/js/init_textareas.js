var input_mirror, output_mirror, last_error, $output_mirror_el;
var toast_duration = 2000;

function sendRequest() {
  $.post("/api/slime2html", { slime: input_mirror.getValue() })
    .done(function(response) {
      output_mirror.setValue(response.html)
      if (last_error) {
        Materialize.toast("Now it's OK", toast_duration, "green lighten-1")
        last_error = null;
      };
      $output_mirror_el.removeClass("error")
    })
    .fail(function(response) {
      var message = response.responseJSON.error;
      if (last_error != message) {
        Materialize.toast(message, toast_duration, "red lighten-1")
        last_error = message;
      }
      $output_mirror_el.addClass("error")
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

$output_mirror_el = $(output_mirror.getWrapperElement())

input_mirror.on("change", function(){
  sendRequest()
})
