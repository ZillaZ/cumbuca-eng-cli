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
    {result, roman_repr} = decimal_to_roman(number)

    case result do
      :failed ->
        {map, list ++ [{:failed, name}]}

      :ok ->
        {Map.put(map, name, number + 1), list ++ [{:ok, "#{name} #{roman_repr}"}]}
    end
  end

  def decimal_to_roman(number) do
    case number > 3999 do
      true -> {:failed, number}
      false -> {:ok, decimal_to_roman(number, "")}
    end
  end

  def decimal_to_roman(number, roman_repr) when number > 0 do
    {value, char} = get_closest_repr(number, 0, nil)

    "#{roman_repr}#{char}" <> decimal_to_roman(number - value, roman_repr)
  end

  def decimal_to_roman(0, _roman_expr) do
    ""
  end

  def get_closest_repr(number, index, closest) when closest == nil do
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

    case value <= number do
      true ->
        {value, roman_repr}

      false ->
        get_closest_repr(number, index + 1, nil)
    end
  end

  def get_closest_repr(_number, _index, closest) do
    closest
  end
end
