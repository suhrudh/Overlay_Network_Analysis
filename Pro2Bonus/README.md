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
    **--> In the terminal, go to <path_to_immediate_directory>/GeldaSannapareddy-bonus/Pro2Bonus/ **
    **--> Execute => mix escript.build in the terminal **
    **--> Execute => ./Project2B <numNodes> <topology> <algorithm> <percentage_of_faulty_nodes> in the terminal **
    **--> Output will be the time taken to run the algorithm for the specified topology**

#WORKING
Apart from the regular push sum and gossip, we have randomly chosen some nodes and killed it, So that the nodes will never pass information to them. We take percentage of the nodes from the user as input decide on the number of nodes deleted. We are also capable of checking the number of nodes alive after the algorithm terminates as we have a map which has the process id’s of alive nodes in our code. Screenshot below shows the number of nodes that are alive.
