defmodule Solution do
  def solve() do
    {:ok, contents} = File.read("input.txt")
    {_last, total} = contents
    |> String.split("\n", trim: true)
    |> Enum.reduce({:empty, 0}, fn
      curr, {:empty, acc} -> {curr, acc + 1}
      curr, {prev, acc} when curr > prev -> {curr, acc+1}
      curr, {_prev, acc} -> {curr, acc}
    end
    )
    IO.puts(total)
  end
end

Solution.solve()
