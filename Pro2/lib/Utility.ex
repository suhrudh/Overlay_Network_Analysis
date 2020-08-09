defmodule Utility do

 def get_alive_neighbours(topology,id) do
   case topology do
     :fn -> full_network(id)
     _ -> get_alive_neighbours(id)
   end
 end

 def get_neighbours_by_topology(id,topology,n) do
   case topology do
     :ln -> get_line_network_neighbours(id,n)
     :twoD -> get_2D_network_neighbours(id,n)
     :threeD -> get_3D_network_neighbours(id,n)
     :hn -> get_honey_network_neighbours(id,n)
     :rhn -> get_honey_network_neighbours(id,n)
     _-> nil
   end
 end

 def get_line_network_neighbours(id,n) do
  cond do
     id == 1 -> [2]
     id == n -> [n-1]
     true -> [id-1,id+1]
   end
end

def get_2D_network_neighbours(id,n) do
  x = Enum.at(id,0)
  y = Enum.at(id,1)

  tentative = [[x+1,y],[x-1,y],[x,y+1],[x,y-1]]
  Enum.filter(tentative,fn(x) -> isQualified2DNode(x,n)end)
end

def isQualified2DNode(a,n) do
    Enum.max(a) <= n && Enum.min(a) >= 0
end
def neighbourNode(node,num) do
  listOfneighbours=[]
  val1=if Enum.at(node,0)==0 or Enum.at(node,0)== num-1 do
        getValOne(node,num)
       else
        []
       end
  val2=if Enum.at(node,1)==0 or Enum.at(node,1)== num-1 do
        getValTwo(node,num)
       else
        []
       end
  val3=if Enum.at(node,2)==0 or Enum.at(node,2)== num-1 do
        getValThree(node,num)
       else
        []
       end


  listOfneighbours=listOfneighbours++[val1]++[val2]++[val3]++getXCoord(node,num)++getYCoord(node,num)++getZCoord(node,num)
  Enum.filter(listOfneighbours, fn x-> length(x)>0 end)

end
def get_3D_network_neighbours(id,n) do
  listOfneighbours=[]
  val1=if Enum.at(id,0)==0 or Enum.at(id,0)== n-1 do
        getValOne(id,n)
       else
        []
       end
  val2=if Enum.at(id,1)==0 or Enum.at(id,1)== n-1 do
        getValTwo(id,n)
       else
        []
       end
  val3=if Enum.at(id,2)==0 or Enum.at(id,2)== n-1 do
        getValThree(id,n)
       else
        []
       end


  listOfneighbours=listOfneighbours++[val1]++[val2]++[val3]++getXCoord(id,n)++getYCoord(id,n)++getZCoord(id,n)
  Enum.filter(listOfneighbours, fn x-> length(x)>0 end)

end

def getXCoord(node,num) do
  xCoordOne=if Enum.at(node,0)+1>num-1 do
              []
            else
              [Enum.at(node,0)+1,Enum.at(node,1),Enum.at(node,2)]
            end
  xCoordTwo=if Enum.at(node,0)-1<0 do
              []
            else
              [Enum.at(node,0)-1,Enum.at(node,1),Enum.at(node,2)]
            end
  [xCoordOne,xCoordTwo]
end

def getYCoord(node,num) do
  yCoordOne=if Enum.at(node,1)+1>num-1 do
              []
            else
              [Enum.at(node,0),Enum.at(node,1)+1,Enum.at(node,2)]
            end
  yCoordTwo=if Enum.at(node,1)-1<0 do
              []
            else
              [Enum.at(node,0),Enum.at(node,1)-1,Enum.at(node,2)]
            end
  [yCoordOne,yCoordTwo]
end

def getZCoord(node,num) do
  zCoordOne=if Enum.at(node,2)+1>num-1 do
              []
            else
              [Enum.at(node,0),Enum.at(node,1),Enum.at(node,2)+1]
            end
  zCoordTwo=if Enum.at(node,2)-1<0 do
              []
            else
              [Enum.at(node,0),Enum.at(node,1),Enum.at(node,2)-1]
            end
  [zCoordOne,zCoordTwo]
end

def getValOne(node,num) do
  cond do
    Enum.at(node,0)==0 -> [num-1,Enum.at(node,1),Enum.at(node,2)]
    Enum.at(node,0)==num-1 -> [0,Enum.at(node,1),Enum.at(node,2)]
    true -> []
  end
end

def getValTwo(node,num) do
  cond do
    Enum.at(node,1)==0 -> [Enum.at(node,0),num-1,Enum.at(node,2)]
    Enum.at(node,1)==num-1 -> [Enum.at(node,0),0,Enum.at(node,2)]
    true -> []
  end
end
def getValThree(node,num) do
  cond do
    Enum.at(node,2)==0 -> [Enum.at(node,0),Enum.at(node,1),num-1]
    Enum.at(node,2)==num-1 -> [Enum.at(node,0),Enum.at(node,1),0]
    true -> []
  end
end

def get_honey_network_neighbours(node,num) do
  neighbourList=get_honeycomb_possibilities(node,num)
  Enum.filter(neighbourList,fn x -> check_honeycomb_boundaries(x,num) end)
end


def check_honeycomb_boundaries(val,num) do
  if Enum.at(val,0)>=0 and Enum.at(val,0)<=num-1 and Enum.at(val,1)>=0 and Enum.at(val,1)<=num do
        true
      else
        false
      end
end

def get_honeycomb_possibilities(node, num) do
  cond do
  Enum.at(node,0)==0 and Enum.at(node,1)==0 -> [[Enum.at(node,0)+1,Enum.at(node,1)],[Enum.at(node,0),Enum.at(node,1)+1]]
  Enum.at(node,0)!=0 and Enum.at(node,1)==0 and rem(Enum.at(node,0),2)!=0 -> [[Enum.at(node,0)+1,Enum.at(node,1)],[Enum.at(node,0)-1,Enum.at(node,1)]]
  Enum.at(node,0)!=0 and Enum.at(node,1)==0 and rem(Enum.at(node,0),2)==0 -> [[Enum.at(node,0)+1,Enum.at(node,1)],[Enum.at(node,0)-1,Enum.at(node,1)],
                                                                              [Enum.at(node,0),Enum.at(node,1)+1]]
  Enum.at(node,0)==0 and Enum.at(node,1)!=0 and rem(Enum.at(node,1),2)!=0 -> [[Enum.at(node,0),Enum.at(node,1)-1],[Enum.at(node,0)+1,Enum.at(node,1)]]
  Enum.at(node,0)==0 and Enum.at(node,1)!=0 and rem(Enum.at(node,1),2)==0 -> [[Enum.at(node,0),Enum.at(node,1)+1],[Enum.at(node,0)+1,Enum.at(node,1)]]
  Enum.at(node,0)==num and rem(Enum.at(node,1),2)==0 -> [[Enum.at(node,0)-1,Enum.at(node,1)],[Enum.at(node,0),Enum.at(node,1)+1]]
  Enum.at(node,0)==num and rem(Enum.at(node,1),2)!=0 -> [[Enum.at(node,0)-1,Enum.at(node,1)],[Enum.at(node,0),Enum.at(node,1)-1]]
  Enum.at(node,1)==num+1 and rem(Enum.at(node,0),2)!=0 -> [[Enum.at(node,0)-1,Enum.at(node,1)],[Enum.at(node,0)+1,Enum.at(node,1)]]
  Enum.at(node,1)==num+1 and rem(Enum.at(node,0),2)==0 -> [[Enum.at(node,0)-1,Enum.at(node,1)],[Enum.at(node,0)+1,Enum.at(node,1)],[Enum.at(node,0),Enum.at(node,1)-1]]
  (rem(Enum.at(node,0),2)==0 and rem(Enum.at(node,1),2)==0) or (rem(Enum.at(node,0),2)!=0 and rem(Enum.at(node,1),2)!=0) ->
                                                          [[Enum.at(node,0)-1,Enum.at(node,1)],[Enum.at(node,0)+1,Enum.at(node,1)],[Enum.at(node,0),Enum.at(node,1)+1]]
  (rem(Enum.at(node,0),2)!=0 and rem(Enum.at(node,1),2)==0) or ((rem(Enum.at(node,0),2)==0 and rem(Enum.at(node,1),2)!=0)) ->
                                                          [[Enum.at(node,0)-1,Enum.at(node,1)],[Enum.at(node,0)+1,Enum.at(node,1)],[Enum.at(node,0),Enum.at(node,1)-1]]
  true -> []
    end
  end

 def add_random_honeycomb_neighbour(node) do
     cond do
       RandomNodeTempList.doesNodeExists(node) -> calculateRandomNode(node)
       true -> NeighboursDataHolder.getNeighbours(node)
     end
 end

 def calculateRandomNode(node)do
   neighbours = NeighboursDataHolder.getNeighbours(node)
   removeNodes = neighbours ++ [node]

   list = RandomNodeTempList.getAllNodes()
   chosenNode =  Enum.random(list -- removeNodes)

   RandomNodeTempList.deleteNode(node)
   RandomNodeTempList.deleteNode(chosenNode)

   NeighboursDataHolder.editNeighbours(node,chosenNode)
   NeighboursDataHolder.editNeighbours(chosenNode,node)
 end


 def get_alive_neighbours(id) do
  Enum.filter( NeighboursDataHolder.getNeighbours(id),fn(x)-> NodeDataHolder.isAlive(x)end)
 end

  def full_network(id) do
    List.delete(NodeDataHolder.getAllKeys(),id)
  end

  def nearestCube(n) do
      Float.ceil(:math.pow(n,1/3)) |> round
      # :math.pow(nearestCubeRoot,3) |> round
  end

  def calBoundaries(n) do
    Float.floor(:math.pow(n,1/2)) |> round
  end
end
