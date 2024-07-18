defmodule RoyalEnumeration.Enumeration do
  @moduledoc """
  Names enumeration responsible module.
  """

  def enumerate(names) do
    result = populate(names)
    get_results(result)
  end

  def populate(names) do
    {_, names} =
      names
      |> Enum.reduce({%{}, []}, fn name, {map, list} -> update_list(name, map, list) end)

    names
  end

  def get_results(names) do
    ok_names =
      Enum.filter(names, fn {result, _} -> result == :ok end)
      |> Enum.map(fn {_, name} -> name end)

    failed_names =
      Enum.filter(names, fn {result, _} -> result == :failed end)
      |> Enum.map(fn {_, name} -> name end)

    result =
      case failed_names do
        [] -> :ok
        _ -> :err
      end

    {result, ok_names, failed_names}
  end

  def update_list(name, map, list) do
    number = Map.get(map, name, 1)

    case number > 3999 do
      true ->
        {map, list ++ [{:failed, name}]}

      _ ->
        {Map.put(map, name, number + 1), list ++ [{:ok, "#{name} #{decimal_to_roman(number)}"}]}
    end
  end

  def decimal_to_roman(number) do
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

    decimal_to_roman(number, roman_table, "")
  end

  def decimal_to_roman(number, roman_table, roman_repr) when number > 0 do
    {value, char} =
      roman_table
      |> Enum.reduce({nil, ""}, fn {value, char}, closest ->
        get_closest(value, char, closest, number)
      end)

    "#{roman_repr}#{char}" <> decimal_to_roman(number - value, roman_table, roman_repr)
  end

  def decimal_to_roman(0, _roman_table, _roman_expr) do
    ""
  end

  def get_closest(value, char, closest, number) do
    case closest do
      {nil, _} ->
        case number >= value do
          true -> {value, char}
          false -> closest
        end

      _ ->
        closest
    end
  end
end
