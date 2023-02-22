defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  @tag :skip
  test "part1" do
    result =
      AdventOfCode.Input.get!(1)
      |> part1

    assert result
  end

  @tag :skip
  test "part2" do
    result =
      AdventOfCode.Input.get!(1)
      |> part2

    assert result
  end
end
