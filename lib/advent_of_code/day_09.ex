defmodule AdventOfCode.Day09 do
  def part1(input) do
    movements = get_movements(input)

    {_, tail_positions} =
      movements
      |> Enum.reduce(
        {[{0, 0}, {0, 0}], MapSet.new()},
        fn [direction, distance_string], {rope, tail_positions} ->
          {distance, _} = Integer.parse(distance_string)

          move(rope, tail_positions, direction, distance)
        end
      )

    MapSet.size(tail_positions)
  end

  defp move(rope, tail_positions, _, 0) do
    {rope, tail_positions}
  end

  defp move(rope, tail_positions, direction, distance) do
    [head | tail] = rope
    new_head = get_new_head_position(head, direction)

    new_rope_reversed =
      tail
      |> Enum.reduce([new_head], fn current_knot, new_rope ->
        [prev_knot | _] = new_rope
        next_knot = get_new_tail_position(prev_knot, current_knot)
        [next_knot | new_rope]
      end)

    [new_tail | _] = new_rope_reversed

    tail_positions = MapSet.put(tail_positions, new_tail)

    move(
      Enum.reverse(new_rope_reversed),
      tail_positions,
      direction,
      distance - 1
    )
  end

  def get_movements(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.split(x, " ", trim: true) end)
  end

  def get_new_head_position({old_head_x, old_head_y}, "U") do
    {old_head_x, old_head_y + 1}
  end

  def get_new_head_position({old_head_x, old_head_y}, "D") do
    {old_head_x, old_head_y - 1}
  end

  def get_new_head_position({old_head_x, old_head_y}, "L") do
    {old_head_x - 1, old_head_y}
  end

  def get_new_head_position({old_head_x, old_head_y}, "R") do
    {old_head_x + 1, old_head_y}
  end

  def get_new_tail_position({new_head_x, new_head_y}, {old_tail_x, old_tail_y})
      when abs(new_head_x - old_tail_x) > 1 and abs(new_head_y - old_tail_y) > 1 do
    x_difference = new_head_x - old_tail_x
    y_difference = new_head_y - old_tail_y

    {old_tail_x + div(x_difference, abs(x_difference)),
     old_tail_y + div(y_difference, abs(y_difference))}
  end

  def get_new_tail_position({new_head_x, new_head_y}, {old_tail_x, _})
      when abs(new_head_x - old_tail_x) > 1 do
    difference = new_head_x - old_tail_x
    {old_tail_x + div(difference, abs(difference)), new_head_y}
  end

  def get_new_tail_position({new_head_x, new_head_y}, {_, old_tail_y})
      when abs(new_head_y - old_tail_y) > 1 do
    difference = new_head_y - old_tail_y
    {new_head_x, old_tail_y + div(difference, abs(difference))}
  end

  def get_new_tail_position(_, {old_tail_x, old_tail_y}) do
    {old_tail_x, old_tail_y}
  end

  def part2(input) do
    movements = get_movements(input)

    {_, tail_positions} =
      movements
      |> Enum.reduce(
        {[{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}],
         MapSet.new()},
        fn [direction, distance_string], {rope, tail_positions} ->
          {distance, _} = Integer.parse(distance_string)

          move(rope, tail_positions, direction, distance)
        end
      )

    MapSet.size(tail_positions)
  end
end
