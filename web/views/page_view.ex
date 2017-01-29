defmodule SlimeConverter.PageView do
  use SlimeConverter.Web, :view

  def default_slime_input do
    """
    doctype html
    html
      head
        meta name="keywords" description="Slime"
        title = site_title
      body
        #id.class
          ul
            = Enum.map [1, 2], fn x ->
              li = x
    """ |> String.strip
  end

  def default_html_output do
    """
    <!DOCTYPE html>
    <html>
      <head>
        <meta name="keywords" description="Slime">
        <title>
          <%= site_title %>
        </title>
      </head>
      <body>
        <div class="class" id="id">
          <ul>
            <%= Enum.map [1, 2], fn x -> %>
            <li>
              <%= x %>
            </li>
            <% end %>
          </ul>
        </div>
      </body>
    </html>
    """ |> String.strip
  end
end
