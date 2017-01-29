defmodule SlimeConverter.ApiController do
  use SlimeConverter.Web, :controller

  def slime2html(conn, params) do
    {conn, json} =
      params["slime"]
      |> Translator.slime2html
      |> generate_response(conn)

    render conn, "slime2html.json", json
  end



  defp generate_response({:ok, html}, conn) do
    { conn, %{html: html} }
  end

  defp generate_response({:error, message}, conn) do
    conn = put_status(conn, :bad_request)
    { conn, %{error: message} }
  end
end
