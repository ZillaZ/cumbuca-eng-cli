defmodule DesafioCli do
  @moduledoc """
  Ponto de entrada para a CLI.
  """


  @doc """
  A função main recebe os argumentos passados na linha de
  comando como lista de strings e executa a CLI.
  """
  def main(_args) do
    names = Input.read_input()
    people = PeopleEnumeration.enumerate(names)
    print_numbered_names(people)
  end

  def print_numbered_names(names) do
    Enum.map(names, fn name -> IO.puts(name) end)
  end
end

defmodule Input do
  @moduledoc """
  Modulo responsável por operações relacionadas à IO
  """

  def read_input(name_list \\ []) do
    name = get_name()
    case is_empty(name) do
      true -> name_list
      false -> read_input(name_list ++ [name])
    end
  end

  def get_name() do
    line = IO.gets("")
    name = String.trim(line)
    name
  end

  def is_empty(name) do
    trimmed_name = String.trim(name)
    is_empty = String.length(trimmed_name) < 1
    is_empty
  end
end

defmodule PeopleEnumeration do
  def enumerate(names) do
    {_, names} = populate(names)
    DesafioCli.print_numbered_names(names)
    names
  end

  def populate(names) do
    names |> Enum.reduce({%{}, []}, fn(name, {map, list}) -> update_list(name, map, list) end)
  end

  def update_list(name, map, list) do
    number = Map.get(map, name)
    case number do
      nil -> {Map.put(map, name, 1), list ++ ["#{name} I"]}
      _ -> {Map.put(map, name, number + 1), list ++ ["#{name} #{decimal_to_roman(number + 1)}"]}
    end
  end

  def decimal_to_roman(number) do
    roman_table = %{1 => "I", 4 => "IV", 5 => "V", 9 => "IX", 10 => "X", 40 => "XL", 50 => "L", 90 => "XC", 100 => "C", 400 => "CD", 500 => "D", 900 => "CM", 1000 => "M"}
    roman_table = Enum.sort(roman_table, :desc)
    decimal_to_roman(number, roman_table, "")
  end

  def decimal_to_roman(number, roman_table, roman_repr) when number > 0 do
    {value, char} = roman_table |> Enum.reduce({-1, "nothing"}, fn ({value, char}, closest) -> get_closest(value, char, closest, number) end)
    "#{roman_repr}#{char}" <> decimal_to_roman(number - value, roman_table, roman_repr)
  end
 
  def decimal_to_roman(0, _roman_table, _roman_expr) do
    ""
  end

  def get_closest(value, char, closest, number) do
    case elem(closest, 0) do
      x when x == -1 ->
        case number >= value do
          true -> {value, char}
          false -> closest
        end
      _ -> closest
     end
  end
end
