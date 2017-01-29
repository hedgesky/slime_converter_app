defmodule SlimeConverter.PageController do
  use SlimeConverter.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
