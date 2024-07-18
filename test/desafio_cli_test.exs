defmodule RoyalEnumerationTest do
  use ExUnit.Case
  import RoyalEnumeration.Enumeration, only: [enumerate: 1]
  doctest RoyalEnumeration

  test "More than 4 thousand equal names" do
    {result, _ok_names, failed_names} = enumerate(NameGen.gen_repeated_list("Lucas", 5000))
    assert result == :err
    && Enum.filter(failed_names, fn name -> name != "Lucas" end) == []
  end

  test "Needs to subtract" do
    {result, ok_names, failed_names} = enumerate(NameGen.gen_repeated_list("Akita", 4))
    assert result == :ok
    && List.last(ok_names) == "Akita IV"
    && failed_names == []
  end

  test "Adding up to 10" do
    {result, ok_names, failed_names} = enumerate(NameGen.gen_repeated_list("Paulo", 10))
    assert result == :ok
    && ok_names == ["Paulo I", "Paulo II", "Paulo III", "Paulo IV", "Paulo V", "Paulo VI", "Paulo VII", "Paulo VIII", "Paulo IX", "Paulo X"]
    && failed_names == []
  end

  test "Needs to add up three times" do
    {result, ok_names, failed_names} = enumerate(NameGen.gen_repeated_list("Cumbuca", 80))
    assert result == :ok
    && List.last(ok_names) == "Cumbuca LXXX"
    && failed_names == []
  end

  test "Only unique names" do
    names = ["Lucas", "Luiz", "Gercino", "Dayse", "David", "Wictor", "Aline"]
    {result, ok_names, failed_names} = enumerate(names)
    assert result == :ok
    && ok_names == Enum.map(names, fn name -> name <> " I" end)
    && failed_names == []
  end

  test "No names given" do
    {result, ok_names, failed_names} = enumerate([])
    assert result == :ok
    && ok_names == []
    && failed_names == []
  end

  @tag timeout: :infinity
  test "A shit ton of unique names" do
    IO.puts("Generating 100.000 names...")
    names = NameGen.gen_unique_names(100_000, [], 0)
    {result, ok_names, failed_names} = enumerate(names)
    assert result == :ok
    && ok_names == Enum.map(names, fn name -> name <> " I" end)
    && failed_names == []
  end

  test "A reeeeeally big name" do
    {name, times} = {"Nines", 10_000_000}
    repeated_name = NameGen.repeat_name(name, times)
    {result, ok_names, failed_names} = enumerate([repeated_name])
    assert result == :ok
    && ok_names == [repeated_name <> " I"]
    && failed_names == []
  end

  test "A fairly big sequence of fairly big names" do
    names = NameGen.gen_unique_names(1_000, [], 100_000_000_000)
    |> Enum.map(fn name -> NameGen.repeat_name(name, 100) end)

    {result, ok_names, failed_names} = enumerate(names)
    assert result == :ok
    && ok_names == Enum.map(names, fn name -> name <> " I" end)
    && failed_names == []
  end
end

defmodule NameGen do
  def repeat_name(base, size) do
    gen_repeated_list(base, size) |> List.foldl("", fn (name, acc) -> acc <> name end)
  end

  def gen_repeated_list(name, amount) do
    List.duplicate(name, amount)
  end

  def gen_unique_names(amount, list, offset) when amount + offset > offset do
    list = list ++ ["#{amount}"]
    gen_unique_names(amount - 1, list, offset)
  end

  def gen_unique_names(0, list, _offset) do
    list
  end
end
