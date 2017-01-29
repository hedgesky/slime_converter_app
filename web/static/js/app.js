// import "phoenix_html"

import { socket, channel } from "./socket"

var last_error;
const toast_duration = 2000;

let input_mirror = CodeMirror.fromTextArea($("#slime-input").get()[0], {
  lineNumbers: true,
  theme: "material",
  mode: "application/x-slim",
  autofocus: true
})

let output_mirror = CodeMirror.fromTextArea($("#html-output").get()[0], {
  lineNumbers: true,
  theme: "material",
  mode: "application/x-erb",
  readOnly: true
})
let $output_mirror_el = $(output_mirror.getWrapperElement())

input_mirror.on("change", _ => {
  channel.push("input:changed", { slime: input_mirror.getValue() } )
})



function update_output(html) {
  output_mirror.setValue(html)
  if (last_error) {
    Materialize.toast("Now it's OK", toast_duration, "green lighten-1")
    last_error = null;
  }
  $output_mirror_el.removeClass("error")
}

function notify_fail(error_message) {
  if (last_error != error_message) {
    Materialize.toast(error_message, toast_duration, "red lighten-1")
    last_error = error_message;
  }
  $output_mirror_el.addClass("error")
}

channel.on("output:changed", payload => {
  if (payload.status == "ok") {
    update_output(payload.html)
  } else {
    notify_fail(payload.message)
  };
})

