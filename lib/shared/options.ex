defmodule Bunyan.Shared.Options do

  alias Bunyan.Shared.Level

  @doc """
  If `key` is present in `options`, add it to `config` under `internal_key`
  """

  @spec maybe_add(struct(), keyword(), atom(), atom()) :: struct()
  def maybe_add(config, options, key, internal_key \\ nil) do
    case options[key] do
      nil ->
        config
      value ->
        Map.put(config, internal_key || key , value)
    end
  end

  @doc """
  Like `maybe_add/3`, but convert the level from an atom to a number
  """

  @spec maybe_add_level(struct(), keyword(), atom(), atom()) :: struct()

  def maybe_add_level(config, options, key, internal_key \\ nil) do
    case options[key] do
      nil ->
        config
      value ->
        Map.put(config, internal_key || key, Level.of(value))
    end
  end

  @doc """
  Validate that a list of options only contains valid keys
  """

  def validate_legal_options(options, valid_keys, from_module) do
    case Keyword.keys(options) -- valid_keys do
      [] ->
        options
      other ->
        raise """

        #{from_module} was passed the following options:

        #{inspect options, pretty: true}

        Invalid option(s): #{inspect other}

        (the only valid keys are: #{inspect valid_keys})

        """
    end
  end

  @doc """
  Validate that a list of options contains required keys
  """

  def validate_required_options(options, required_keys, from_module) do
    case required_keys -- Keyword.keys(options) do
      [] ->
        options

      other ->
        raise """

        The configuration for #{from_module} is missing the
        required option(s): #{inspect other}

        It was passed:

        #{inspect options, pretty: true}

        """
    end
  end
end
