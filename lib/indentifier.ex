defmodule Indentifier do
  import String

  def indentify(html) do
    html
    |> replace("</", "\n</")
    |> replace(">", ">\n")
    |> split("\n")
    |> Enum.filter(fn line -> trim(line) != "" end)
    |> set_levels
    |> Enum.map(&indentify_line(&1))
    |> Enum.join("\n")
  end

  # @returns {result, next_level}
  defp set_levels(lines) do
    {items, _} =
      Enum.reduce(lines, {[], 0}, fn line, {current_items, level} ->
        change = indentation_change(line)

        new_level = if change < 0, do: level + change , else: level
        new_items = [{line, new_level} | current_items]
        {new_items, level + change}
      end)
    Enum.reverse(items)
  end

  defp indentation_change(line) do
    cond do
      starts_with?(line, "<!DOCTYPE") -> 0
      starts_with?(line, "</") -> -1
      starts_with?(line, "<") && !self_closing?(line) -> 1
      true -> 0
    end
  end

  defp self_closing?(line) do
    tags = ~w(br embed hr img input link meta param source )
    Enum.any?(tags, fn tag -> starts_with?(line, "<#{tag}") end)
  end

  defp indentify_line({content, level}) do
    duplicate("  ", max(level, 0)) <> content
  end
end