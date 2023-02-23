defmodule AdventOfCode.Day03 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&compartmentalize_rucksack/1)
    |> Enum.map(&find_error_item_part1/1)
    |> Enum.map(&score_item/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(&find_badge/1)
    |> Enum.map(&score_item/1)
    |> Enum.sum()
  end

  defp compartmentalize_rucksack(rucksack) do
    half_length =
      String.length(rucksack)
      |> div(2)

    String.split_at(rucksack, half_length)
  end

  defp build_item_set(rucksack) do
    rucksack
    |> String.graphemes()
    |> Enum.reduce(MapSet.new(), fn x, acc -> MapSet.put(acc, x) end)
  end

  defp find_error_item_part1({rucksack_one, rucksack_two}) do
    item_set = build_item_set(rucksack_one)

    rucksack_two
    |> String.graphemes()
    |> Enum.find(fn x -> MapSet.member?(item_set, x) end)
  end

  defp find_badge([rucksack_one, rucksack_two, rucksack_three]) do
    item_set_one = build_item_set(rucksack_one)
    item_set_two = build_item_set(rucksack_two)

    rucksack_three
    |> String.graphemes()
    |> Enum.find(fn x -> MapSet.member?(item_set_one, x) && MapSet.member?(item_set_two, x) end)
  end

  defp score_item(<<value::utf8>>) when value <= 96, do: value - 38
  defp score_item(<<value::utf8>>), do: value - 96
end
