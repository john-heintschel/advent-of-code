defmodule AdventOfCode.Day06 do
  def part1(input) do
    find_unique_prefix_idx(input)
  end

  def part2(input) do
    find_unique_prefix_idx(input, 14)
  end

  defp find_unique_prefix_idx(input, size \\ 4) do
    {value, _} =
      input
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce_while({0, []}, fn
        {current, idx}, {_, old_prefix} ->
          num_elems =
            [current | old_prefix]
            |> MapSet.new()
            |> MapSet.size()

          case num_elems do
            ^size ->
              {:halt, {idx + 1, []}}

            _ ->
              {:cont, {0, new_prefix(old_prefix, current, size)}}
          end
      end)

    value
  end

  defp new_prefix(old_prefix, new_element, size) do
    size_less_one = size - 1

    rest =
      case length(old_prefix) do
        ^size_less_one ->
          [_ | rest] = old_prefix
          rest

        _ ->
          old_prefix
      end

    [new_element | rest |> Enum.reverse()]
    |> Enum.reverse()
  end
end
