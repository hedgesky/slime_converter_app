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
          #id.class
            ul
              = Enum.map [1, 2], fn x ->
                li = x
    """

    html = """
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="keywords" description="Slime">
        <title>Website Title</title>
        <script>
          alert('Slime supports embedded javascript!');
        </script>
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
    |> String.strip

    response =
      build_conn
      |> post("/api/slime2html", slime: slime)
      |> json_response(200)

    IO.puts(response["html"])
    IO.puts "\n\n\n"

    assert response == %{ "html" => html }
  end
end
