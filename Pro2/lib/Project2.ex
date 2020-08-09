defmodule Project2 do
  def main(args) do
    #IO.inspect args
    {value, ""} = Integer.parse(Enum.at(args,0))
    Pro2.start(String.downcase( Enum.at(args,1)),String.downcase(Enum.at(args,2)),value)
  end
end
