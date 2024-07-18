defmodule DesafioCli do
  import DesafioCli.IO, only: [read_input: 0, print_numbered_names: 3]
  import DesafioCli.PeopleEnumeration, only: [enumerate: 1]

  @moduledoc """
  Ponto de entrada para a CLI.
  """


  @doc """
  A função main recebe os argumentos passados na linha de
  comando como lista de strings e executa a CLI.
  """
  def main(_args) do
    {result, ok_names, failed_names} = read_input() |> enumerate()
    print_numbered_names(result, ok_names, failed_names)
  end
end

