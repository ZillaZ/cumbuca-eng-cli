defmodule DesafioCli.IO do
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

  def print_numbered_names(result, ok_names, failed_names) do
    case result do
      :failed ->
        IO.puts("Execution finished with errors. The following names have not been processed:")
        Enum.map(failed_names, fn name -> IO.puts(name) end)
      :ok ->
        IO.puts("Successfully processed names:")
        Enum.map(ok_names, fn name -> IO.puts(name) end)
    end
  end
end
