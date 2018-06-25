defmodule Bunyan.Shared.Options.Test do

  use ExUnit.Case

  alias Bunyan.Shared.Options

  test "accepts valid config" do
    options = [ name: 1, age: 2 ]
    assert Options.validate_legal_options(options, [ :name, :age ], SomeModule) == options
  end

  test "rejects invalid config" do
    options = [ name: 1, age: 2 ]
    assert_raise(
      RuntimeError,
      ~r/SomeModule was passed.*Invalid option.*:age.*only valid.*:name, :address/s,
      fn -> Options.validate_legal_options(options, [ :name, :address ], SomeModule) end
    )
  end
end
