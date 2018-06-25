defmodule Bunyan.Shared.Collector do

  def log(collector, log_msg) do
    GenServer.cast(collector, { :log, log_msg })
  end

  def report(collector, log_msg) do
    GenServer.cast(collector, { :log, log_msg })
  end
end
