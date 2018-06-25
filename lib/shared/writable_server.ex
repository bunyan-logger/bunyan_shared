defmodule Bunyan.Shared.WritableServer do

  # alias Bunyan.Shared.LogMsg

  @moduledoc """
  The behaviour shared by all `Bunyon.Writer.XXX.Server` modules
  """

  @doc """
  The callback to write a log message
  """

  ##
  # Argh: I can't do this, because Elixir complains that it conflicts with
  # GenServer (it doesn't, but deducing that would require way more type
  # inference than it does). I'm going to leave it here as much for
  # documentation as anything else.
  ###

  # @callback handle_cast({ :log_message, msg :: LogMsg.t}, options :: any()) ::
  #           {:noreply, new_state}
  #         | {:noreply, new_state, timeout() | :hibernate}
  #         | {:stop, reason :: term(), new_state} when new_state: term()

  defmacro __using__(_args \\ []) do
    quote do
      use GenServer
      # @behaviour unquote(__MODULE__)
    end
  end
end
