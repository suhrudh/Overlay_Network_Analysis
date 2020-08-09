defmodule Timer do
use Agent

def start(pid) do
    Agent.start_link(fn -> {System.monotonic_time(:millisecond),pid} end, name: :timer)
  end

  def getStartTime do
    Agent.get(:timer, &(&1))
  end
end
