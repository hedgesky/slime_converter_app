defmodule Slime2html.PageController do
  use Slime2html.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
