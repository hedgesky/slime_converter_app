defmodule Slime2html.ApiView do
  use Slime2html.Web, :view

  def render("slime2html.json", %{html: html}) do
    %{html: html}
  end
end