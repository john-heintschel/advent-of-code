defmodule AdventOfCode.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Day08

  @tag :skip
  test "part1" do
    result =
      AdventOfCode.Input.get!(8)
      |> part1
      |> IO.inspect()

    assert result
  end

  @tag :skip
  test "part2" do
    IO.puts("\n")

    result =
      AdventOfCode.Input.get!(8)
      |> part2
      |> IO.inspect()

    assert result
  end
end
