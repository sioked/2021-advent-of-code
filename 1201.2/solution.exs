defmodule Solution do
  def solve() do
    {:ok, contents} = File.read("input.txt")
    {_arr, _prev_sum, total} = contents
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({[:empty, :empty, :empty], 0, 0}, fn
      curr, {[:empty, :empty, :empty], _prev_sum,  acc} -> {[curr, :empty, :empty], 0, acc}
      curr, {[first, :empty, :empty], _prev_sum, acc} -> {[first, curr, :empty], 0, acc}
      curr, {[first, second, :empty], _prev_sum, acc} -> 
        {[first, second, curr], 0, acc}
      curr, {[first, second, third], prev_sum, acc} when first+second+third > prev_sum -> 
        result = first + second + third
        IO.puts(result)
        {[second, third, curr], first+second+third, acc+1}
      curr, {[first, second, third], prev_sum, acc} -> {[second, third, curr], first+second+third, acc}
    end
    )
    IO.puts(total)
  end
end

Solution.solve()
