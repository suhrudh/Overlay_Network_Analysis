defmodule NeighboursDataHolder do
use Agent

def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: :neighbours_map)
  end

  def getNeighbours(key) do
    Agent.get(:neighbours_map, & Map.fetch!(&1,key))
  end

  def addNeighbours(key, value) do
    Agent.update(:neighbours_map, &(Map.put_new(&1,key,value)))
  end

  def editNeighbours(key,value) do
    Agent.update(:neighbours_map, &(Map.update!(&1,key,fn x -> x ++ [value] end)))
  end
end
