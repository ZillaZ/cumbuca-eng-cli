defmodule RoyalEnumeration.IO do
  @moduledoc """
  IO responsible module
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
    case line do
      :eof -> ""
      _ -> String.trim(line)
    end
  end

  def is_empty(name) do
    trimmed_name = String.trim(name)
    is_empty = String.length(trimmed_name) < 1
    is_empty
  end

  def print_numbered_names(result, ok_names, failed_names) when ok_names != [] do
    IO.puts("Successfully processed names:")
    Enum.map(ok_names, fn name -> IO.puts(name) end)

    if result == :failed do
      IO.puts("Execution finished with errors. The following names have not been processed:")
      Enum.map(failed_names, fn name -> IO.puts(name) end)
    end
  end

  def print_numbered_names(_result, _ok_names, _failed_names) do
    IO.puts("No names were given.")
  end

  def print_usage_instructions() do
    IO.puts("""
    Royal Enumeration
    Start typing the names, each name in one line. When you finish inserting the names, just enter a empty line and the program will start the computation.
    If there is more than 3999 royal family members over the generations with the same name, the exceeding members will not be processed.
    """)
  end
end
