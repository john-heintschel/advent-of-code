defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  @tag :skip
  test "part1" do
    IO.puts("\n")

    result =
      AdventOfCode.Input.get!(6)
      |> part1
      |> IO.inspect()

    assert result
  end

  @tag :skip
  test "part2" do
    IO.puts("\n")

    result =
      AdventOfCode.Input.get!(6)
      |> part2
      |> IO.inspect()

    assert result
  end
end
