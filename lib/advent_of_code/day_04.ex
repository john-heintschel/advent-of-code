defmodule AdventOfCode.Day04 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_elves/1)
    |> Enum.count(&check_either_contains/1)
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_elves/1)
    |> Enum.count(&check_any_overlap/1)
  end

  def parse_elves(elf_strings) do
    [elf_one, elf_two] =
      elf_strings
      |> String.split(",")
      |> Enum.map(&parse_elf_range/1)

    {elf_one, elf_two}
  end

  defp parse_elf_range(elf) do
    [{start_range, ""}, {end_range, ""}] =
      elf
      |> String.split("-")
      |> Enum.map(&Integer.parse/1)

    {start_range, end_range}
  end

  defp check_either_contains({elf_one, elf_two}) do
    evaluate_containment(elf_one, elf_two) || evaluate_containment(elf_two, elf_one)
  end

  defp check_any_overlap({elf_one, elf_two}) do
    check_any_overlap(elf_one, elf_two)
  end

  defp evaluate_containment({one, _}, {three, _}) when one < three, do: false
  defp evaluate_containment({_, two}, {_, four}) when two > four, do: false
  defp evaluate_containment({_, _}, {_, _}), do: true

  defp check_any_overlap({_, two}, {three, _}) when two < three, do: false
  defp check_any_overlap({one, _}, {_, four}) when one > four, do: false
  defp check_any_overlap({_, _}, {_, _}), do: true
end
