defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  test "part1" do
    result =
      AdventOfCode.Input.get!(1)
      |> part1

    assert result
  end

  test "part2" do
    result =
      AdventOfCode.Input.get!(1)
      |> part2
      |> IO.inspect()

    assert result
  end
end
