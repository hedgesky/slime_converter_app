defmodule IndentingRenderer do
  alias Slime.Compiler
  alias Slime.Parser
  alias Slime.Preprocessor
  alias Slime.Tree

  def render(input) do
    input
    |> Preprocessor.process
    |> Parser.parse_lines
    |> Tree.build_tree
    |> IndentingCompiler.compile
    |> EEx.eval_string
  end
end