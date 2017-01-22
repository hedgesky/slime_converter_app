defmodule Indentifier do
  import String

  def indentify(html) do
    html
    |> replace("</", "\n</")
    |> replace(">", ">\n")
    |> split("\n")
    |> Enum.filter(fn line -> trim(line) != "" end)
    |> set_levels
    |> Enum.map_join("\n", &indentify_line(&1))
  end

  # @returns [{result, next_level}]
  defp set_levels(lines) do
    {:ok, level_storage} = Agent.start_link(fn -> 0 end)

    items = Enum.map(lines, fn line ->
      current_level = Agent.get(level_storage, fn x -> x end)
      change = indentation_change(line)
      Agent.update(level_storage, fn _ -> current_level + change end)

      if change < 0 do
        {line, current_level + change}
      else
        {line, current_level}
      end
    end)
    Agent.stop(level_storage)
    items
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