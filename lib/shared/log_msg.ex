defmodule Bunyan.Shared.LogMsg do

  @moduledoc """
  This is the structure the defines a message to be logged.

  * `level` is the level to be logged. Current levels are 0, 10¸20, and 30 for
    `debug`, `info`, `warn`, and `error`.

  * `msg` is either a binary or a function of arity 0 that returns a binary

  * `extra` is an Elixir term that will be inspected and displayed on the lines
    following the log message

  * `timestamp` is the :os.timestamp of when  this message was generated.

  * `pid` is the process identifier of the process generating the message

  * `node` is the node on which that process lived
  """

  @type level_as_number :: 0 | 10 | 20 | 30

  @type t :: %{
    __struct__: Bunyan.Shared.LogMsg,
    level:      level_as_number,
    msg:        binary | ( -> binary ),
    extra:      any,
    timestamp:  non_neg_integer,
    pid:        pid,
    node:       atom
  }

  defstruct(
    level:     0,
    msg:       "",
    extra:     nil,
    timestamp: nil,
    pid:       nil,
    node:      nil
  )

end
