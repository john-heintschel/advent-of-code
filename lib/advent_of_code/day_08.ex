defmodule AdventOfCode.Day08 do
  def part1(input) do
    input_matrix = get_input_matrix(input)

    west_pov_indicators = get_indicator_matrix(input_matrix)

    east_pov_indicators =
      input_matrix
      |> reverse_each_row
      |> get_indicator_matrix
      |> reverse_each_row

    north_pov_indicators =
      input_matrix
      |> transpose
      |> get_indicator_matrix
      |> transpose

    south_pov_indicators =
      input_matrix
      |> transpose
      |> reverse_each_row
      |> get_indicator_matrix
      |> reverse_each_row
      |> transpose

    west_pov_indicators
    |> elementwise_or(east_pov_indicators)
    |> elementwise_or(north_pov_indicators)
    |> elementwise_or(south_pov_indicators)
    |> Enum.map(fn row -> Enum.count(row, fn x -> x end) end)
    |> Enum.sum()
  end

  def get_input_matrix(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn x ->
        x
        |> String.split("", trim: true)
        |> Enum.map(fn number -> 
          {out, _} = Integer.parse(number)
          out
        end)
      end)
  end

  def transpose(rows) do
    rows
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end

  defp get_indicator_matrix(input_matrix) do
    input_matrix
    |> Enum.map(&get_indicator_row/1)
  end

  defp get_view_distance_matrix(input_matrix) do
    input_matrix
    |> Enum.map(&get_viewing_distances_for_row/1)
  end

  defp elementwise_or(matrix_one, matrix_two) do
    matrix_one
    |> Enum.zip(matrix_two)
    |> Enum.map(fn {row_one, row_two} ->
      row_one
      |> Enum.zip(row_two)
      |> Enum.map(fn {x, y} -> x || y end)
    end)
  end

  defp elementwise_multiply(matrix_one, matrix_two) do
    matrix_one
    |> Enum.zip(matrix_two)
    |> Enum.map(fn {row_one, row_two} ->
      row_one
      |> Enum.zip(row_two)
      |> Enum.map(fn {x, y} -> x * y end)
    end)
  end

  defp get_indicator_row(row) do
    {_, indicators} =
      row
      |> Enum.reduce({-1, []}, fn x, acc ->
        old_max = elem(acc, 0)
        old_list = elem(acc, 1)

        case x > old_max do
          true -> {x, [true | old_list]}
          false -> {old_max, [false | old_list]}
        end
      end)

    Enum.reverse(indicators)
  end

  defp get_viewing_distances_for_row(row) do
    reversed_row = Enum.reverse(row)
    {_, return_value} = reversed_row
    |> Enum.reduce({reversed_row, [] }, fn _, {[head | tail], distances} ->
      viewing_distance = Enum.reduce_while(tail, 0, fn y, count ->
        case y >= head do
          true -> {:halt, count + 1}
          false -> {:cont, count + 1}
        end
      end)
      {tail, [viewing_distance | distances]}
    end)
    return_value

  end

  defp reverse_each_row(rows) do
    rows
    |> Enum.map(&Enum.reverse/1)
  end

  def part2(input) do
    input_matrix = get_input_matrix(input)

    west_pov_indicators = get_view_distance_matrix(input_matrix)

    east_pov_indicators =
      input_matrix
      |> reverse_each_row
      |> get_view_distance_matrix
      |> reverse_each_row

    north_pov_indicators =
      input_matrix
      |> transpose
      |> get_view_distance_matrix
      |> transpose

    south_pov_indicators =
      input_matrix
      |> transpose
      |> reverse_each_row
      |> get_view_distance_matrix
      |> reverse_each_row
      |> transpose

    west_pov_indicators
    |> elementwise_multiply(east_pov_indicators)
    |> elementwise_multiply(north_pov_indicators)
    |> elementwise_multiply(south_pov_indicators)
    |> Enum.map(fn row -> Enum.max(row) end)
    |> Enum.max()
  end
end
