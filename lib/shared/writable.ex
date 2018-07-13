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
    server_module = args[:server_module] || Module.concat(caller,  Server)

    quote do
      def child_spec(config) do
        Supervisor.child_spec({
          unquote(server_module),
          state_from_config(config)
         }, [])
      end
      defoverridable child_spec: 1

      def state_from_config(config) do
        unquote(state_module).from(config)
      end
    end
  end

end
