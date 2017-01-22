defmodule Slime2html.ApiControllerTest do
  use Slime2html.ConnCase

  test "POST /api/slime2html", %{conn: conn} do
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
            <li>
              1
            </li>
            <li>
              2
            </li>
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
end
