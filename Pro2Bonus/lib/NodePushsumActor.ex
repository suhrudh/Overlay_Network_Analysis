defmodule NodePushsumActor do
  use GenServer
def start_link(__MODULE__,state) do
  GenServer.start_link(__MODULE__,state,[])
end

def init(state) do
  {:ok, state}
end

def push_sum(pid,other_main,topology) do
  GenServer.cast(pid,{:push_sum,other_main,topology})
end

def handle_cast({:push_sum,other_main,topology} ,state) do
  #IO.puts state[:id]
  [_head | tail] = state[:last_three]
  b = other_main[:w]
  a = other_main[:s]
  #updating state
  b = b + state[:main][:w]
  a = a + state[:main][:s]
  #updating count
  count = state[:count] + 1
  #adding change to the list
  updated_last_three= tail
  ++
  [abs((a/b)- (state[:main][:s]/state[:main][:w]))]

  #IO.inspect updated_last_three

  #IO.puts "a #{a}, b #{b}"
  checkTerminationPushsum(state[:id],updated_last_three)
  sendMessage([s: a/2,w: b/2],state[:id],topology)
  a = a/2
  b = b/2
  #IO.inspect [main: [s: a, w: b],id: state[:id],count: count,last_three: updated_last_three]
  {:noreply, [main: [s: a, w: b],id: state[:id],count: count,last_three: updated_last_three]}
end

def sendMessage(main,id,topology) do
  neighbours = Utility.get_alive_neighbours(topology,id)
  #IO.puts "#{length(neighbours)}"
  #IO.inspect keys
  if length(neighbours) > 0 do
    num = Enum.random(neighbours)
    #IO.inspect neighbours
    pid=NodeDataHolder.getNode(num)
    # IO.inspect pid
    push_sum(pid,main,topology)
  else
    {startTime, pid}= Timer.getStartTime
    timeTaken = System.monotonic_time(:millisecond) - startTime
    IO.puts "nodes left: #{length(NodeDataHolder.getAllKeys)}"
    send(pid,{:ok, timeTaken})
  end
end

#Push Sum

def checkTerminationPushsum(id,last_three)do
    cond do
      #state[:count] > 10 -> true #stop due to count
      :math.pow(10,-10) >= Enum.max(last_three) -> NodeDataHolder.deleteNode(id) # stop due to no change
      true -> false # continue case
    end
end

end
