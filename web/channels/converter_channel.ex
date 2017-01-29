defmodule SlimeConverter.ConverterChannel do
  use Phoenix.Channel

  def join("slime2html", _message, socket) do
    {:ok, socket}
  end

  def handle_in("input:changed", %{"slime" => slime}, socket) do
    response =
      slime
      |> Translator.slime2html
      |> generate_response
    push socket, "output:changed", response
    {:noreply, socket}
  end

  defp generate_response({:ok, html}), do: %{ status: :ok, html: html }
  defp generate_response({:error, message}), do: %{ status: :error, message: message }
end
