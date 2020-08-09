defmodule Pro2 do

  def start(topology,algorithm,n,percentNode) do
      NodeDataHolder.start_link(%{})
      NeighboursDataHolder.start_link(%{})
     # IO.puts topology
     # IO.puts algorithm
      case {topology,algorithm} do
        {"full","gossip"} -> fn_g(n,percentNode)
        {"full","push-sum"} -> fn_p(n,percentNode)
        {"line","gossip"} -> ln_g(n,percentNode)
        {"line","push-sum"} -> ln_p(n,percentNode)
        {"rand2d","gossip"} -> two_g(n,percentNode)
        {"rand2d","push-sum"} -> two_p(n,percentNode)
        {"3dtorus","gossip"} -> three_g(n,percentNode)
        {"3dtorus","push-sum"} -> three_p(n,percentNode)
        {"honeycomb","gossip"}-> hn_g(n,percentNode)
        {"honeycomb","push-sum"}-> hn_p(n,percentNode)
        {"randhoneycomb","gossip"}-> rhn_g(n,percentNode)
        {"randhoneycomb","push-sum"}-> rhn_p(n,percentNode)
      end

      receive do
        {:ok, time} -> IO.puts "time : #{time}"
      end
  end


  #[id: x,main: [s: x, w: 1], count: 0,last_three: [1000.0,1000.0,1000.0]]
  def fn_p(n,percentNode) do
    Enum.each(1..n, fn(x) -> intializingPushsumNodes([id: x,main: [s: x, w: 1],count: 0,last_three: [1000.0,1000.0,1000.0]],:fn,n)end)
    deadNodeNum=(percentNode/100)*n |> round
    for i <- 1..deadNodeNum do
      chooseRandNode=Enum.random(NodeDataHolder.getAllKeys())
      NodeDataHolder.deleteNode(chooseRandNode)
    end

    start = Enum.random(NodeDataHolder.getAllKeys())
    Timer.start(self())
    NodePushsumActor.push_sum(NodeDataHolder.getNode(start),[s: 0,w: 0],:fn)
     # NodeActor.push_sum(pid,[s: 1 , w: 1])
     # NodeActor.print_state(pid)
    #:ok
  end

  def ln_p(n,percentNode) do
    Enum.each(1..n, fn(x) -> intializingPushsumNodes([id: x,main: [s: x, w: 1],count: 0,last_three: [1000.0,1000.0,1000.0]],:ln,n)end)
    deadNodeNum=(percentNode/100)*n |> round
    for i <- 1..deadNodeNum do
      chooseRandNode=Enum.random(NodeDataHolder.getAllKeys())
      NodeDataHolder.deleteNode(chooseRandNode)
    end
    start = Enum.random(NodeDataHolder.getAllKeys())
    Timer.start(self())
    NodePushsumActor.push_sum(NodeDataHolder.getNode(start),[s: 0,w: 0],:ln)
     # NodeActor.push_sum(pid,[s: 1 , w: 1])
     # NodeActor.print_state(pid)
    #:ok
  end

  def ln_g(n,percentNode) do
    Enum.each(1..n, fn(x) -> intializingGossipNodes([id: x, count: 0],:ln,n)end)
    deadNodeNum=(percentNode/100)*n |> round
    for i <- 1..deadNodeNum do
      chooseRandNode=Enum.random(NodeDataHolder.getAllKeys())
      NodeDataHolder.deleteNode(chooseRandNode)
    end
    start = Enum.random(NodeDataHolder.getAllKeys())
    Timer.start(self())
    NodeGossipActor.gossip(NodeDataHolder.getNode(start),"rumour",:ln)
     # NodeActor.push_sum(pid,[s: 1 , w: 1])
     # NodeActor.print_state(pid)
    #:ok
  end

  def fn_g(n,percentNode) do
    Enum.each(1..n, fn(x) -> intializingGossipNodes([id: x, count: 0],:fn,n)end)#[id: x, count: 0]
    deadNodeNum=(percentNode/100)*n |> round
    for i <- 1..deadNodeNum do
      chooseRandNode=Enum.random(NodeDataHolder.getAllKeys())
      NodeDataHolder.deleteNode(chooseRandNode)
    end
    start = Enum.random(NodeDataHolder.getAllKeys())
    Timer.start(self())
    NodeGossipActor.gossip(NodeDataHolder.getNode(start),"rumour",:fn)
  end

  def two_p(n,percentNode) do
      n1 = :math.sqrt(n) |> Float.ceil |> round
      for i<- 1..n1,
          j<- 1..n1 do
            intializingPushsumNodes([id: [i-1,j-1],main: [s: n1*(i-1) + j, w: 1],count: 0,last_three: [1000.0,1000.0,1000.0]],:twoD,n1)
      end
      deadNodeNum=(percentNode/100)*n |> round
      for i <- 1..deadNodeNum do
        chooseRandNode=Enum.random(NodeDataHolder.getAllKeys())
        NodeDataHolder.deleteNode(chooseRandNode)
      end
      start = Enum.random(NodeDataHolder.getAllKeys())
      Timer.start(self())
      NodePushsumActor.push_sum(NodeDataHolder.getNode(start),[s: 0,w: 0],:twoD)
  end

  def two_g(n,percentNode) do
      n1 = :math.sqrt(n) |> Float.ceil |> round
      for i<- 1..n1,
          j<- 1..n1 do
            intializingGossipNodes([id: [i-1,j-1],count: 0],:twoD,n1)
      end
      deadNodeNum=(percentNode/100)*n |> round
      for i <- 1..deadNodeNum do
        chooseRandNode=Enum.random(NodeDataHolder.getAllKeys())
        NodeDataHolder.deleteNode(chooseRandNode)
      end
      start = Enum.random(NodeDataHolder.getAllKeys())
      Timer.start(self())
      NodeGossipActor.gossip(NodeDataHolder.getNode(start),"rumour",:twoD)
  end

  def three_p(n,percentNode) do
    n1=Utility.nearestCube(n)
    for i <- 1..n1,
      j <- 1..n1,
      k <- 1..n1 do
        intializingPushsumNodes([id: [i-1,j-1,k-1],main: [s: n1*n1*(i-1) + n1*(j-1) + k, w: 1],count: 0,last_three: [1000.0,1000.0,1000.0]],:threeD,n1)
      end
      deadNodeNum=(percentNode/100)*n |> round
      for i <- 1..deadNodeNum do
        chooseRandNode=Enum.random(NodeDataHolder.getAllKeys())
        NodeDataHolder.deleteNode(chooseRandNode)
      end
      start = Enum.random(NodeDataHolder.getAllKeys())
      Timer.start(self())
      NodePushsumActor.push_sum(NodeDataHolder.getNode(start),[s: 0,w: 0],:threeD)
  end

  def three_g(n,percentNode) do
    n1=Utility.nearestCube(n)
    for i <- 1..n1,
      j <- 1..n1,
      k <- 1..n1 do
        intializingGossipNodes([id: [i-1,j-1,k-1],count: 0],:threeD,n1)
      end
      deadNodeNum=(percentNode/100)*n |> round
      for i <- 1..deadNodeNum do
        chooseRandNode=Enum.random(NodeDataHolder.getAllKeys())
        NodeDataHolder.deleteNode(chooseRandNode)
      end
      start = Enum.random(NodeDataHolder.getAllKeys())
      Timer.start(self())
      NodeGossipActor.gossip(NodeDataHolder.getNode(start),"rumour",:threeD)
  end

  def hn_p(n,percentNode) do
      n1= Utility.calBoundaries(n)
      for i <- 1..n1,
        j <- 1..n1+1 do
          intializingPushsumNodes([id: [i-1,j-1],main: [s: (n1)*(i-1) + j, w: 1],count: 0,last_three: [1000.0,1000.0,1000.0]],:hn,n1)
          # IO.inspect [i-1,j-1]
        end
        deadNodeNum=(percentNode/100)*n |> round
        for i <- 1..deadNodeNum do
          chooseRandNode=Enum.random(NodeDataHolder.getAllKeys())
          NodeDataHolder.deleteNode(chooseRandNode)
        end
        start = Enum.random(NodeDataHolder.getAllKeys())
      Timer.start(self())
      NodePushsumActor.push_sum(NodeDataHolder.getNode(start),[s: 0,w: 0],:hn)
  end

  def hn_g(n,percentNode) do
      n1= Utility.calBoundaries(n)
      for i <- 1..n1,
        j <- 1..n1+1 do
          intializingGossipNodes([id: [i-1,j-1],count: 0],:hn,n1)
          # IO.inspect [i-1,j-1]
        end
        deadNodeNum=(percentNode/100)*n |> round
        for i <- 1..deadNodeNum do
          chooseRandNode=Enum.random(NodeDataHolder.getAllKeys())
          NodeDataHolder.deleteNode(chooseRandNode)
        end
        start = Enum.random(NodeDataHolder.getAllKeys())
        Timer.start(self())
      NodeGossipActor.gossip(NodeDataHolder.getNode(start),"rumour",:hn)
  end

  def rhn_p(n,percentNode) do
    #IO.puts "entered"
    n1= Utility.calBoundaries(n)
    RandomNodeTempList.start_link([])
    for i <- 1..n1-1,
      j <- 1..n1 do
        intializingPushsumNodes([id: [i-1,j-1],main: [s: (n1)*(i-1) + j, w: 1],count: 0,last_three: [1000.0,1000.0,1000.0]],:hn,n1)
        RandomNodeTempList.addNode([i-1,j-1])
      end

      deadNodeNum=(percentNode/100)*n |> round
      for i <- 1..deadNodeNum do
        chooseRandNode=Enum.random(NodeDataHolder.getAllKeys())
        NodeDataHolder.deleteNode(chooseRandNode)
      end
      start = Enum.random(NodeDataHolder.getAllKeys())
    for i <- 1..n1-1,
        j <- 1..n1 do
          Utility.add_random_honeycomb_neighbour([i-1,j-1])
        end
    Timer.start(self())
    NodePushsumActor.push_sum(NodeDataHolder.getNode(start),[s: 0,w: 0],:hn)
  end

  def rhn_g(n,percentNode) do
      n1= Utility.calBoundaries(n)
      RandomNodeTempList.start_link([])
      for i <- 1..n1-1,
        j <- 1..n1 do
          intializingGossipNodes([id: [i-1,j-1],count: 0],:hn,n1)
        end
        deadNodeNum=(percentNode/100)*n |> round
      for i <- 1..n1-1,
          j <- 1..n1 do
           Utility.add_random_honeycomb_neighbour([i-1,j-1])
          end
          for i <- 1..deadNodeNum do
            chooseRandNode=Enum.random(NodeDataHolder.getAllKeys())
            NodeDataHolder.deleteNode(chooseRandNode)
          end
          start = Enum.random(NodeDataHolder.getAllKeys())
        Timer.start(self())
      NodeGossipActor.gossip(NodeDataHolder.getNode(start),"rumour",:hn)
  end

  def intializingPushsumNodes(state,topology,n) do
    #IO.puts "yes sir"
    {:ok, pid} = GenServer.start_link(NodePushsumActor,state)
    #IO.inspect pid
    NodeDataHolder.addNode(state[:id],pid)
    case topology do
      :fn -> :true
      _ -> NeighboursDataHolder.addNeighbours(state[:id],Utility.get_neighbours_by_topology(state[:id],topology,n))
    end
  end

  def intializingGossipNodes(state,topology,n) do
    #IO.puts "yes sir"
    {:ok, pid} = GenServer.start_link(NodeGossipActor,state)
    #IO.inspect pid
    NodeDataHolder.addNode(state[:id],pid)
    case topology do
      :fn -> :true
      _ -> NeighboursDataHolder.addNeighbours(state[:id],Utility.get_neighbours_by_topology(state[:id],topology,n))
    end
  end
end
