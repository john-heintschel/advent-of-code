defmodule AdventOfCode.Day01 do
  def part1(args) do
    args
    |> String.split("\n\n")
    |> Enum.map(&split_and_sum_elf_cals/1)
    |> Enum.max()
  end

  def part2(args) do
    args
    |> String.split("\n\n")
    |> Enum.map(&split_and_sum_elf_cals/1)
    |> Enum.reduce([], &max_three_reducer/2)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  defp split_and_sum_elf_cals(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> Integer.parse(x) |> elem(0) end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  defp max_three_reducer(item, accumulator) when length(accumulator) < 3 do
    [item | accumulator]
  end

  defp max_three_reducer(item, accumulator) do
    full_list = [item | accumulator]

    {_, min_index} =
      full_list
      |> Enum.with_index()
      |> Enum.min_by(fn {x, _} -> x end)

    {_, new_list} = List.pop_at(full_list, min_index)
    new_list
  end
end
