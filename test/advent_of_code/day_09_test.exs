defmodule AdventOfCode.Day09Test do
  use ExUnit.Case

  import AdventOfCode.Day09

  @tag :skip
  test "part1" do
    result =
      AdventOfCode.Input.get!(9)
      |> part1
      |> IO.inspect()

    assert result
  end

  @tag :skip
  test "part2" do
    result =
      AdventOfCode.Input.get!(9)
      |> part2
      |> IO.inspect()

    assert result
  end
end
