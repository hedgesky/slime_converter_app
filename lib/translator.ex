defmodule Translator do
  def slime2html(input) do
    try do
      html =
        input
        |> Slime.render
        |> Indentifier.indentify
      { :ok, html }
    rescue
      e in CompileError ->
        { :error, friendly_error_message(e) }
    end
  end

  defp friendly_error_message(error) do
    regex = ~r/undefined function (.+)\/./
    Regex.replace(
      regex,
      error.description,
      "Your template uses undefined function or variable '\\1'. Please remove it.",
      global: false
    )
  end
end
