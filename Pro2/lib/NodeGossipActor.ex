defmodule NodeGossipActor do
  use GenServer
def start_link(__MODULE__,state) do
  GenServer.start_link(__MODULE__,state,[])
end

def init(state) do
  {:ok, state}
end

def gossip(pid,message,topology) do
  GenServer.cast(pid,{:gossip,message,topology})
end

def handle_cast({:gossip,message,topology} ,state) do
  checkTerminationGossip(state)
  sendMessage(message,state[:id],topology)
  #IO.inspect state
  {:noreply, [id: state[:id], count: state[:count]+1]}
end

def sendMessage(message,id,topology) do
  neighbours = Utility.get_alive_neighbours(topology,id)

  #IO.puts "#{length(neighbours)}"
  # IO.inspect id
  # IO.inspect neighbours
  if length(neighbours) > 0 do
    num = Enum.random(neighbours)
    #IO.inspect num
    pid=NodeDataHolder.getNode(num)
    # IO.inspect pid
    gossip(pid,message,topology)
  else
    {startTime, pid}= Timer.getStartTime
    timeTaken = System.monotonic_time(:millisecond) - startTime
    #IO.puts length(NodeDataHolder.getAllKeys)
    send(pid,{:ok, timeTaken})
  end
end
#Push Sum

def checkTerminationGossip(state)do
    cond do
      state[:count] >= 25 -> NodeDataHolder.deleteNode(state[:id]) #stop due to count
      #:math.pow(10,-10) >= Enum.max(state[:last_three]) -> NodeDataHolder.deleteNode(state[:id]) # stop due to no change
      true -> false # continue case
    end
end

end
