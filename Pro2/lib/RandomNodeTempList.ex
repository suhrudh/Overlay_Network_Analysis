defmodule RandomNodeTempList do
  use Agent

  def start_link(initial_value) do
      Agent.start_link(fn -> initial_value end, name: :random_neighbours_list)
  end

  def getAllNodes() do
      Agent.get(:random_neighbours_list, fn list->list end)
  end

  def addNode(node) do
    Agent.update(:random_neighbours_list, fn list->list++[node] end)
  end

  def deleteNode(node) do
      Agent.update(:random_neighbours_list, fn list -> list--[node] end)
  end

  def doesNodeExists(node) do
      list = getAllNodes()
      Enum.any?(list, fn x -> x = node end)
  end
end
