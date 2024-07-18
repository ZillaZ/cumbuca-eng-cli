defmodule RoyalEnumeration do
  import RoyalEnumeration.IO, only: [print_usage_instructions: 0, read_input: 0, print_numbered_names: 3]
  import RoyalEnumeration.Enumeration, only: [enumerate: 1]

  @moduledoc """
  CLI entry point
  """

  def main(_args) do
    print_usage_instructions()
    {result, ok_names, failed_names} = read_input() |> enumerate()
    print_numbered_names(result, ok_names, failed_names)
  end
end

