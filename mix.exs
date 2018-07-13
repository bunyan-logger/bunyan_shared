defmodule BunyanShared.MixProject do
  use Mix.Project

  Code.load_file("shared_build_stuff/mix.exs")
  alias Bunyan.Shared.Build

  def project do
    Build.project(
      :bunyan_shared,
      "0.1.0",
      &deps/1,
      "Shared functionality of the Bunyan distributed and pluggable logging system"
    )
  end

  def deps(_),       do: []
  def application(), do: []

end
