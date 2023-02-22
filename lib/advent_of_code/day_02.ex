defmodule AdventOfCode.Day02 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_round/1)
    |> Enum.map(&score_part_one/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_round/1)
    |> Enum.map(&score_part_two/1)
    |> Enum.sum()
  end

  defp score_shape(shape) do
    shape_values = %{:rock => 1, :paper => 2, :scissors => 3}
    Map.get(shape_values, shape)
  end

  defp score_outcome(outcome) do
    outcome_values = %{:win => 6, :draw => 3, :loss => 0}
    Map.get(outcome_values, outcome)
  end

  defp parse_round(round) do
    choices =
      round
      |> String.split(" ", trim: true)

    {Enum.at(choices, 0), Enum.at(choices, 1)}
  end

  def score_part_one(choices) do
    personal_choice = part_one_get_personal_choice(choices)
    opponent_choice = get_opponent_choice(choices)

    score_shape(personal_choice) + score_outcome(get_outcome({opponent_choice, personal_choice}))
  end

  def score_part_two(choices) do
    opponent_choice = get_opponent_choice(choices)
    round_outcome = part_two_get_round_outcome(choices)
    personal_choice = get_personal_choice({opponent_choice, round_outcome})

    score_shape(personal_choice) + score_outcome(round_outcome)
  end

  defp get_opponent_choice(data) do
    translation = %{"A" => :rock, "B" => :paper, "C" => :scissors}
    Map.get(translation, elem(data, 0))
  end

  defp part_one_get_personal_choice(data) do
    translation = %{"X" => :rock, "Y" => :paper, "Z" => :scissors}
    Map.get(translation, elem(data, 1))
  end

  defp part_two_get_round_outcome(data) do
    translation = %{"X" => :loss, "Y" => :draw, "Z" => :win}
    Map.get(translation, elem(data, 1))
  end

  defp get_outcome({:rock, :rock}) do
    :draw
  end

  defp get_outcome({:rock, :paper}) do
    :win
  end

  defp get_outcome({:rock, :scissors}) do
    :loss
  end

  defp get_outcome({:paper, :rock}) do
    :loss
  end

  defp get_outcome({:paper, :paper}) do
    :draw
  end

  defp get_outcome({:paper, :scissors}) do
    :win
  end

  defp get_outcome({:scissors, :rock}) do
    :win
  end

  defp get_outcome({:scissors, :paper}) do
    :loss
  end

  defp get_outcome({:scissors, :scissors}) do
    :draw
  end

  defp get_personal_choice({:rock, :draw}) do
    :rock
  end

  defp get_personal_choice({:rock, :win}) do
    :paper
  end

  defp get_personal_choice({:rock, :loss}) do
    :scissors
  end

  defp get_personal_choice({:paper, :loss}) do
    :rock
  end

  defp get_personal_choice({:paper, :draw}) do
    :paper
  end

  defp get_personal_choice({:paper, :win}) do
    :scissors
  end

  defp get_personal_choice({:scissors, :win}) do
    :rock
  end

  defp get_personal_choice({:scissors, :loss}) do
    :paper
  end

  defp get_personal_choice({:scissors, :draw}) do
    :scissors
  end

  defp get_personal_choice(_) do
    :error
  end
end
