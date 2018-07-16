defmodule Bunyan.Shared.Build do


  @moduledoc """
  This file is manually included in each Bunyan mix.exs. It provides a
  couple of common helpers for the build process.
  """

  def is_developer? do
    cond do
      Mix.env == :prod                                 -> false
      System.get_env("BUNYAN_DEVELOPER")               -> true
      System.get_env("THIS_IS_THE_REAL_ME") == "dave"  -> true

      :else ->
        false
    end
  end

  def project(name, version, deps, description) do
    [
      app:             name,
      version:         version,
      elixir:          "~> 1.6",
      deps:            build_deps(deps.(Mix.env)),
      description:     description,
      package:         package(name),
      start_permanent: Mix.env() == :prod,
    ]
  end

  defp package(name) do
    [
      name:        name,
      files:       ["lib", "mix.exs", "README.md", "shared_build_stuff/*"],
      licenses:    ["Apache 2.0"],
      links:       %{
        "GitHub" => "https://github.com/pragdave/#{name}",
        "Bunyan" => "https://github.com/pragdave/bunyan",
        },
      maintainers: [
        "Dave Thomas <dave@pragdave.me>" ,
      ]
    ]
  end

  defp build_deps(deps) do
    bunyan_deps(deps[:bunyan]) ++ other_deps(deps[:others]) ++ exdoc_dep()
  end

  defp bunyan_deps(nil) do
    []
  end

  defp bunyan_deps(deps) do
    deps
    |> Enum.map(fn {name, version} -> one_bunyan_dep(name, version, is_developer?()) end)
  end

  defp one_bunyan_dep(name, _version, true) do
    { name, path: "../#{name}", override: true, env: Mix.env }
  end

  defp one_bunyan_dep(name, version, false) do
    { name, version }
  end

  defp other_deps(nil) do
    []
  end

  defp other_deps(deps) do
    deps
  end

  defp exdoc_dep() do
    [ {:ex_doc, ">= 0.0.0", only: :dev} ]
  end
end
