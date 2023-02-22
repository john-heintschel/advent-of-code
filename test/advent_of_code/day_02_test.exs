defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  @tag :skip
  test "part1" do
    result =
      AdventOfCode.Input.get!(2)
      |> part1
      |> IO.inspect()

    assert result
  end

  @tag :skip
  test "part2" do
    result =
      AdventOfCode.Input.get!(2)
      |> part2
      |> IO.inspect()

    assert result
  end
end
