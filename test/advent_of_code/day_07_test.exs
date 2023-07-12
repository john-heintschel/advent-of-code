defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Day07

  @tag :skip
  test "part1" do
    IO.puts("\n")

    result =
      AdventOfCode.Input.get!(7)
      |> part1
      |> IO.inspect()

    assert result
  end

  @tag :skip
  test "part2" do
    IO.puts("\n")

    result =
      AdventOfCode.Input.get!(7)
      |> part2
      |> IO.inspect()

    assert result
  end
end
