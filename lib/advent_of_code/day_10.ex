defmodule AdventOfCode.Day10 do
  def part1(args) do
    values = get_register_values_from_input(args)

    [20, 60, 100, 140, 180, 220]
    |> Enum.map(fn offset -> Enum.at(values, offset) * offset end)
    |> Enum.sum()
  end

  def part2(args) do
    values = get_register_values_from_input(args)

    [0, 40, 80, 120, 160, 200]
    |> Enum.map(fn offset -> Enum.slice(values, offset, 40) end)
    |> Enum.map(&convert_to_pixels/1)
    |> Enum.map(&List.to_string/1)
  end

  defp convert_to_pixels(input) do
    input
    |> Enum.with_index()
    |> Enum.map(fn {value, index} ->
      case abs(value - index + 1) <= 1 do
        true -> "#"
        false -> "."
      end
    end)
  end

  defp get_register_values_from_input(input) do
    register_values_in_reverse_order =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_token/1)
      |> Enum.reduce([1, 1], &process_instruction/2)

    Enum.reverse(register_values_in_reverse_order)
  end

  defp process_instruction({cycle_count, add_value}, acc) do
    [current_value | _] = acc

    case cycle_count do
      1 ->
        [current_value + add_value | acc]

      2 ->
        [current_value + add_value | [current_value | acc]]
    end
  end

  # Returns a tuple of the form:
  # {cycle_count, add_value}
  defp parse_token("noop"), do: {1, 0}

  defp parse_token(token) do
    [_, value] =
      token
      |> String.split(" ")

    {int_value, _} = Integer.parse(value)
    {2, int_value}
  end
end
