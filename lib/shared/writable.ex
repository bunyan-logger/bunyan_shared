defmodule Bunyan.Shared.Writable do

  @moduledoc """
  The behaviour shared by all `Bunyon.Writer` plugins/
  """

  @doc """
  Update the configuration parameters associated with this writer.
  Exactly which configuration options can be changed at runtime
  depends on the writer.

  The first parameter is the name associated with this writer.
  """

  @callback update_configuration(name :: atom(), new_config :: keyword()) :: any()

  @callback start(config :: map()) :: any()

  defmacro __using__(args \\ []) do

    caller = __CALLER__.module
    state_module  = args[:state_module]  || Module.concat(caller,  State)

    quote do
      @behaviour unquote(__MODULE__)

      @spec initialize_writer(options :: keyword()) :: any()
      def initialize_writer(options) do
        unquote(state_module).from(options)
        |> start()
      end

    end
  end


end
