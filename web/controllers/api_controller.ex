defmodule Slime2html.ApiController do
  use Slime2html.Web, :controller

  def slime2html(conn, params) do
    {conn, json} =
      params["slime"]
      |> strip_or_empty
      |> Translator.slime2html
      |> generate_response(conn)

    render conn, "slime2html.json", json
  end

  defp strip_or_empty(nil), do: ""
  defp strip_or_empty(string), do: String.strip(string)

  defp generate_response({:ok, html}, conn) do
    { conn, %{html: html} }
  end

  defp generate_response({:error, message}, conn) do
    conn = put_status(conn, :bad_request)
    { conn, %{error: message} }
  end
end
