defmodule Translator do
  def slime2html(input) do
    try do
      html =
        input
        |> strip_or_empty
        |> Slime.Renderer.precompile
        |> Indentifier.indentify
      { :ok, html }
    rescue
      e ->
        { :error, friendly_error_message(e) }
    end
  end

  defp strip_or_empty(nil), do: ""
  defp strip_or_empty(string), do: String.strip(string)

  defp friendly_error_message(%FunctionClauseError{module: Slime.Doctype}) do
    "Invalid doctype"
  end

  defp friendly_error_message(e) do
    inspect(e)
  end
end
