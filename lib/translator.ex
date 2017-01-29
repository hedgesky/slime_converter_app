defmodule Translator do
  def slime2html(input) do
    try do
      html =
        input
        |> Slime.Renderer.precompile
        |> Indentifier.indentify
      { :ok, html }
    rescue
      e ->
        { :error, friendly_error_message(e) }
    end
  end

  defp friendly_error_message(%FunctionClauseError{module: Slime.Doctype}) do
    "Invalid doctype"
  end

  defp friendly_error_message(e) do
    inspect(e)
  end
end
