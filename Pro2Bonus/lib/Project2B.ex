defmodule Project2B do
  def main(args) do
    #IO.inspect args
    {value, ""} = Integer.parse(Enum.at(args,0))
    {value1,""} = Integer.parse(Enum.at(args,3))
    Pro2.start(String.downcase( Enum.at(args,1)),String.downcase(Enum.at(args,2)),value,value1)
  end
end
