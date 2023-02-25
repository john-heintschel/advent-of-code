defmodule Parser do
  import NimbleParsec

  crate =
    ignore(string("["))
    |> ascii_char([?A..?Z])
    |> ignore(string("]"))
    |> ignore(optional(string(" ")))

  missing_crate =
    ignore(string(" "))
    |> string(" ")
    |> ignore(string(" "))
    |> ignore(optional(string(" ")))

  instr =
    ignore(string("move "))
    |> integer(min: 1)
    |> ignore(string(" from "))
    |> integer(min: 1)
    |> ignore(string(" to "))
    |> integer(min: 1)

  defparsec(:crate_row, choice([crate, missing_crate]) |> repeat |> eos)
  defparsec(:create_instruction, instr |> eos)
end

defmodule AdventOfCode.Day05 do
  def part1(input) do
    {stacks, instructions} = parse_input(input)

    output =
      instructions
      |> Enum.reduce(stacks, &apply_instruction_to_stacks/2)

    1..map_size(stacks)
    |> Enum.map(fn idx ->
      [head | _] = Map.get(output, idx, [])

      head
    end)
  end

  def part2(input) do
    {stacks, instructions} = parse_input(input)

    output =
      instructions
      |> Enum.reduce(stacks, &apply_instruction_to_stacks_v2/2)

    1..map_size(stacks)
    |> Enum.map(fn idx ->
      [head | _] = Map.get(output, idx, [])

      head
    end)
  end

  defp apply_instruction_to_stacks([count, from, to], stacks) do
    1..count
    |> Enum.reduce(stacks, fn _, acc -> move_element({from, to}, acc) end)
  end

  defp apply_instruction_to_stacks_v2([count, from, to], stacks) do
    source_stack = Map.get(stacks, from, [])

    {new_source, temp} =
      1..count
      |> Enum.reduce({source_stack, []}, fn _, {source, sink} ->
        [head | tail] = source

        {tail, [head | sink]}
      end)

    new_sink =
      temp
      |> Enum.reduce(Map.get(stacks, to, []), fn x, acc ->
        [x | acc]
      end)

    stacks
    |> Map.put(from, new_source)
    |> Map.put(to, new_sink)
  end

  defp move_element({from, to}, stacks) do
    source_stack = Map.get(stacks, from, [])

    case source_stack do
      [] ->
        stacks

      [head | tail] ->
        stacks
        |> Map.put(from, tail)
        |> Map.put(to, [head | Map.get(stacks, to, [])])
    end
  end

  defp parse_input(input) do
    [crate_config, instruction_list] =
      input
      |> String.split("\n\n", trim: true)

    [_ | crate_rows] =
      crate_config
      |> String.split("\n", trim: true)
      |> Enum.reverse()

    stacks =
      crate_rows
      |> Enum.map(&get_crate_list_from_row/1)
      |> Enum.reduce(%{}, &add_crates_to_stacks/2)

    instructions =
      instruction_list
      |> String.split("\n", trim: true)
      |> Enum.map(&get_instruction_from_row/1)

    {stacks, instructions}
  end

  defp get_crate_list_from_row(crate_row) do
    {:ok, result, _, _, _, _} = Parser.crate_row(crate_row)
    result
  end

  defp get_instruction_from_row(instruction_row) do
    {:ok, result, _, _, _, _} = Parser.create_instruction(instruction_row)

    result
  end

  def add_crates_to_stacks(crates, stacks) do
    crates
    |> Enum.with_index()
    |> Enum.reduce(stacks, &insert_crate/2)
  end

  defp insert_crate({crate_name, position}, stacks) do
    case crate_name do
      " " ->
        stacks

      _ ->
        stack =
          stacks
          |> Map.get(position + 1, [])

        Map.put(stacks, position + 1, [crate_name | stack])
    end
  end
end
