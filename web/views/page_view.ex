defmodule Slime2html.PageView do
  use Slime2html.Web, :view

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
    """
  end

  def default_html_output do
    """
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="keywords" description="Slime">
        <title>Website Title</title>
      </head>

      <body>
        <div class="class" id="id">
          <ul>
            <li>1</li>
            <li>2</li>
          </ul>
        </div>
      </body>
      </html>
    """
  end
end
