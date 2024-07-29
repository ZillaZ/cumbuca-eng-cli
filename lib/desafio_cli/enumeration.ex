defmodule RoyalEnumeration.Enumeration do
  @moduledoc """
  Names enumeration responsible module.
  """

  def enumerate(names) do
    result = populate(names)
    get_results(result)
  end

  def populate(names) do
    {results, _} =
      names
      |> Enum.map_reduce(%{}, fn name, map ->
        {{name, Map.get(map, name, 1)}, update_count(name, map)}
      end)

    results
    |> Stream.map(fn {name, count} -> {name, decimal_to_roman(count)} end)
    |> Enum.map(fn {name, {result, repr}} -> {result, name <> " #{repr}"} end)
  end

  def get_results(names) do
    ok_names =
      Stream.filter(names, fn {result, _} -> result == :ok end)
      |> Enum.map(fn {_, name} -> name end)

    failed_names =
      Stream.filter(names, fn {result, _} -> result == :failed end)
      |> Enum.map(fn {_, name} -> name end)

    result =
      case failed_names do
        [] -> :ok
        _ -> :err
      end

    {result, ok_names, failed_names}
  end

  def update_count(name, map) do
    number = Map.get(map, name, 1)
    Map.put(map, name, number + 1)
  end

  def decimal_to_roman(number) do
    biggest_roman_repr = 3999

    if number > biggest_roman_repr do
      {:failed, ""}
    else
      {:ok, decimal_to_roman(number, "")}
    end
  end

  def decimal_to_roman(number, roman_repr) when number > 0 do
    {value, char} = get_closest_repr(number, 0)

    "#{roman_repr}#{char}" <> decimal_to_roman(number - value, roman_repr)
  end

  def decimal_to_roman(0, _roman_expr) do
    ""
  end

  def get_closest_repr(number, index) do
    roman_table = [
      {1000, "M"},
      {900, "CM"},
      {500, "D"},
      {400, "CD"},
      {100, "C"},
      {90, "XC"},
      {50, "L"},
      {40, "XL"},
      {10, "X"},
      {9, "IX"},
      {5, "V"},
      {4, "IV"},
      {1, "I"}
    ]

    {value, roman_repr} = Enum.at(roman_table, index)

    if value <= number do
      {value, roman_repr}
    else
      get_closest_repr(number, index + 1)
    end
  end
end
