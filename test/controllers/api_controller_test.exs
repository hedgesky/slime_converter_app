defmodule Slime2html.ApiControllerTest do
  use Slime2html.ConnCase

  test "successful POST /api/slime2html", %{conn: conn} do
    slime = """
      doctype html
      html
        head
          meta name="keywords" description="Slime"
          javascript:
            alert('Slime supports embedded javascript!');
        body
          | Plain text
          #id.class
            ul
              = Enum.map [1, 2], fn x ->
                li = x
    """

    expected_html = """
    <!DOCTYPE html>
    <html>
      <head>
        <meta name="keywords" description="Slime">
        <script>
          alert('Slime supports embedded javascript!');
        </script>
      </head>
      <body>
        Plain text
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

    response =
      conn
      |> post("/api/slime2html", slime: slime)
      |> json_response(200)

    assert response == %{ "html" => expected_html }
  end

  # test "failed POST /api/slime2html", %{conn: conn} do
  #   slime = """
  #     = head()
  #   """

  #   response =
  #     conn
  #     |> post("/api/slime2html", slime: slime)
  #     |> json_response(400)

  #   expected_error_msg = "Your template uses undefined function or variable 'head'. Please remove it."
  #   assert response == %{ "error" => expected_error_msg }
  # end
end
