defmodule NodeDataHolder do
use Agent

def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: :node_map)
  end

  def getNode(key) do
    Agent.get(:node_map, & Map.fetch!(&1,key))
  end

  def addNode(key, value) do
    Agent.update(:node_map, &(Map.put_new(&1,key,value)))
  end

  def deleteNode(key) do
    Agent.update(:node_map, &(Map.delete(&1,key)))
    true
  end

  def getAllKeys() do
    Agent.get(:node_map, & Map.keys(&1))
  end

  def isAlive(key) do
    Agent.get(:node_map, &(Map.has_key?(&1,key)))
  end
end
