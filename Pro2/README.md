# DOS PROJECT 2

# COP5615 – Fall 2019 Distributed Operating System Principles

# PROBLEM DEFINITION
  *The goal of this project is to determine the convergence of such algorithms through a simulator based on actors written in Elixir.*

# REQUIREMENTS
  *Erlang 20.0 or higher*
  *Elixir v1.9*
  *The installation instructions can be found at https://elixir-lang.org/install.html*

#GROUP MEMBERS AND UFID
    *Juhi Gelda : UFID -- 4996-9899*
    *Suhrudh Reddy Sannapareddy : UFID -- 6485-1063*

#STEPS TO RUN THE CODE
    **--> In the terminal, go to <path_to_immediate_directory>/GeldaSannapareddy/pro2/ **
    **--> Execute => mix escript.build in the terminal **
    **--> Execute => ./Project2 <numNodes> <topology> <algorithm> in the terminal **
    **--> Output will be the time taken to run the algorithm for the specified topology**

#WORKING
Push-sum : All the nodes are initialised with two values with Sum Si = i and Weight Wi = 1. Si/2 and Wi/2 are subtracted and transmitted to its neighbours and added at the receiving node.

  Termination cases : if last 3 S/W ratios of a node didnt change by pow(10,-10), node is eliminated from network. If a node gets into a situation where all its neighbours are terminated, Algorithm gets terminated.

Gossip : Nodes transmit a rumour to its neighbours. It propogates untill network each node in the network gets the rumor 25 times.
  Termination case : if a node gets a rumour for 25 times. node gets terminated. If a node gets into a situation where all of its neighbours are terminated, Algorithm gets terminated.

Time Calculation : Time is calculated using a send and recieve setup and storing the start time in an agent as a state.the time calculated is just the time taken by the push sum/gossip algorithm.

#LARGEST NETWORK FOR EACH TOPOLOGY
  *GOSSIP*
    **Full -- *Nodes 10000* *Time 811862ms **
    **Line -- *Nodes 10000* *Time 811862ms **
    **Random 2D Grid  -- *Nodes 10000* *Time 811862ms **
    **3D Torus Grid -- *Nodes 10000* *Time 811862ms **
    **Honeycomb -- *Nodes 10000* *Time 811862ms **
    **Random Honeycomb -- *Nodes 10000* *Time 811862ms**

  *PUSH SUM*
    **Full -- *Nodes 2000* *Time 85793ms **
    **Line -- *Nodes 500* *Time 86619ms **
    **Random 2D Grid  -- *Nodes 2000* *Time 637831ms **
    **3D Torus Grid -- *Nodes 3000* *Time 85257ms **
    **Honeycomb -- *Nodes 1500* *Time 357923ms **
    **Random Honeycomb -- *Nodes 3000* *Time 16126ms**
