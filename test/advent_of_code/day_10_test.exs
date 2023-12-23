defmodule AdventOfCode.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Day10

  @tag :skip
  test "part1" do
    result =
      AdventOfCode.Input.get!(10, 2022)
      |> part1
      |> IO.inspect()

    assert result
  end

  test "part2" do
    IO.puts("\n")

    result =
      AdventOfCode.Input.get!(10, 2022)
      |> part2
      |> IO.inspect()

    assert result
  end
end
