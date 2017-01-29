defmodule SlimeConverter.ApiView do
  use SlimeConverter.Web, :view

  def render("slime2html.json", %{html: html}) do
    %{html: html}
  end

  def render("slime2html.json", %{error: error}) do
    %{error: error}
  end
end
