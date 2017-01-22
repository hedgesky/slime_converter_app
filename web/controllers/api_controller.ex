defmodule Slime2html.ApiController do
  use Slime2html.Web, :controller

  def slime2html(conn, params) do
    html =
      params["slime"]
      |> String.strip
      |> Slime.render
      |> Indentifier.indentify

    render conn, "slime2html.json", %{html: html}
  end
end
