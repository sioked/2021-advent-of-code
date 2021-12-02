defmodule Solution do
  def solve() do
    {:ok, contents} = File.read("input.txt")
    result = contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> 
      [action, amount] = String.split(x)
      [action, String.to_integer(amount)]
    end)
    |> Enum.reduce({0, 0, 0}, fn
      ["forward", amount], {x, y, aim} -> {x + amount, y + amount * aim, aim}
      ["backward", amount], {x, y, aim} -> {x - amount, y - amount * aim, aim}
      ["up", amount], {x, y, aim} -> {x, y, aim - amount}
      ["down", amount], {x, y, aim} -> {x, y, aim + amount}
    end
    )
    IO.inspect result
    {x, y, _aim} = result
    IO.puts(x * y)
  end
end

Solution.solve()
