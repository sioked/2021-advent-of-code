defmodule Solution do
  def solve() do
    {:ok, contents} = File.read("input.txt")
    result = contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> 
      [action, amount] = String.split(x)
      [action, String.to_integer(amount)]
    end)
    |> Enum.reduce({0, 0}, fn
      ["forward", amount], {x, y} -> {x + amount, y}
      ["backward", amount], {x, y} -> {x - amount, y}
      ["up", amount], {x, y} -> {x, y - amount}
      ["down", amount], {x, y} -> {x, y + amount}
    end
    )
    IO.inspect result
    {x, y} = result
    IO.puts(x * y)
  end
end

Solution.solve()
