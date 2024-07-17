defmodule DesafioCliTest do
  use ExUnit.Case
  doctest PeopleEnumeration

  test "MUITO NOME IGUALKKKKKK" do
    PeopleEnumeration.enumerate(NameGen.repeat_name("Lucas", 9999))
  end
end

defmodule NameGen do
  def repeat_name(name, amount) do
    List.duplicate(name, amount)
  end
end
