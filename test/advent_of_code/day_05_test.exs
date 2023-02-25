defmodule AdventOfCode.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Day05

  @tag :skip
  test "part1" do
    IO.puts("\n")

    result =
      AdventOfCode.Input.get!(5)
      |> part1
      |> IO.inspect()

    assert result
  end

  test "part2" do
    result =
      AdventOfCode.Input.get!(5)
      |> part2
      |> IO.inspect()

    assert result
  end
end
