defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Day03

  @tag :skip
  test "part1" do
    result =
      AdventOfCode.Input.get!(3)
      |> part1
      |> IO.inspect()

    assert result
  end

  test "part2" do
    result =
      AdventOfCode.Input.get!(3)
      |> part2
      |> IO.inspect()

    assert result
  end
end
