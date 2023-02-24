defmodule AdventOfCode.Day04Test do
  use ExUnit.Case

  import AdventOfCode.Day04

  @tag :skip
  test "part1" do
    result =
      AdventOfCode.Input.get!(4)
      |> part1
      |> IO.inspect()

    assert result
  end

  @tag :skip
  test "part2" do
    result =
      AdventOfCode.Input.get!(4)
      |> part2
      |> IO.inspect()

    assert result
  end
end
