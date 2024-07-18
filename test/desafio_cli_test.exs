defmodule DesafioCliTest do
  use ExUnit.Case
  import DesafioCli.PeopleEnumeration, only: [enumerate: 1]
  doctest DesafioCli

  test "More than 4 thousand equal names" do
    {result, _ok_names, failed_names} = enumerate(NameGen.repeat_name("Lucas", 5000))
    assert result == :err
      && Enum.filter(failed_names, fn name -> name != "Lucas" end) == []
  end

  test "Needs to subtract" do
    {result, ok_names, failed_names} = enumerate(NameGen.repeat_name("Akita", 4))
    assert result == :ok
      && List.last(ok_names) == "Akita IV"
      && failed_names == []
  end

  test "Adding up to 10" do
    {result, ok_names, failed_names} = enumerate(NameGen.repeat_name("Paulo", 10))
    assert result == :ok
      && ok_names == ["Paulo I", "Paulo II", "Paulo III", "Paulo IV", "Paulo V", "Paulo VI", "Paulo VII", "Paulo VIII", "Paulo IX", "Paulo X"]
      && failed_names == []
  end

  test "Needs to add up three times" do
    {result, ok_names, failed_names} = enumerate(NameGen.repeat_name("Cumbuca", 80))
    assert result == :ok
      && List.last(ok_names) == "Cumbuca LXXX"
      && failed_names == []
  end

  test "Only unique names" do
    names = ["Lucas", "Luiz", "Gercino", "Dayse", "David", "Wictor", "Aline"]
    {result, ok_names, failed_names} = enumerate(names)
    IO.puts(ok_names)
    assert result == :ok
      && ok_names == Enum.map(names, fn name -> name <> " I" end)
      && failed_names == []
  end
end

defmodule NameGen do
  def repeat_name(name, amount) do
    List.duplicate(name, amount)
  end
end
