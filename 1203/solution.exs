defmodule Solution do
  defp getCountOfBinaryString(contents) do
    {accumulated,total_count} = contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> 
      String.graphemes(x)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.map(&IO.inspect/1)
    |> Enum.reduce({[], 0}, fn
      curr, {[], 0} -> {curr, 1}
      curr, {acc, count} ->
        newAcc = Enum.zip(acc, curr)
          |> Enum.map(fn 
            { x, y } -> x + y
          end)
        {newAcc, count+1}
    end)

    {accumulated, total_count}
  end

  def partone() do
    {:ok, contents} = File.read("input.txt")
    { accumulated, total_count} = getCountOfBinaryString(contents)
    result_bin = Enum.into(accumulated, "", fn
      count_of_ones when count_of_ones > total_count / 2-> "1"
      _count_of_ones -> "0"
    end)
    {result, _} = Integer.parse(result_bin, 2);
    opposite = result_bin |> String.graphemes |> Enum.into("", fn
      "1" -> "0"
      "0" -> "1"
    end)
    IO.inspect(opposite);
    {result2, _} = Integer.parse(opposite, 2);

    IO.puts(result * result2);
    { result_bin, opposite, contents }
  end

  defp getMostCommonBit(list, index) do
    result = Enum.map(list, fn x -> String.at(x, index) end)
    |> Enum.frequencies()
    IO.puts('GOT RESULT')
    IO.inspect(result)
    IO.puts('OK AFTER')
    %{"1" => countOfOnes, "0" => countOfZeros} = result
    cond do
      countOfOnes > countOfZeros -> "1"
      countOfZeros > countOfOnes -> "0"
      countOfZeros == countOfOnes -> "1"
    end
  end

  defp getLeastCommonBit(list, index) do
    %{"0" => countOfZeros, "1" => countOfOnes } = Enum.map(list, fn x -> String.at(x, index) end)
      |> Enum.frequencies()
    cond do
      countOfOnes > countOfZeros -> "0"
      countOfZeros > countOfOnes -> "1"
      countOfZeros == countOfOnes ->  "0"
    end
  end
  # If only a single value left, just return that
  defp findMostCommonMatch([accumulated], _index) do
    accumulated
  end

  defp findMostCommonMatch(accumulator, index) do
    mostCommonBit = getMostCommonBit(accumulator, index)
    filtered = Enum.filter(accumulator, fn x -> String.at(x, index) == mostCommonBit end)
    findMostCommonMatch(filtered, index+1)
  end

  defp findLeastCommonMatch([accumulated], _index) do
    accumulated
  end

  defp findLeastCommonMatch(accumulator, index) do
    leastCommonBit = getLeastCommonBit(accumulator, index)
    filtered = Enum.filter(accumulator, fn x -> String.at(x, index) == leastCommonBit end)
    findLeastCommonMatch(filtered, index+1)
  end


  def parttwo() do
    {result, opposite, original_input} = partone()
    IO.inspect({ result, opposite })
    contents = original_input
    |> String.split("\n", trim: true)
    filtered = findMostCommonMatch(contents, 0)
    reverse = findLeastCommonMatch(contents, 0)
    IO.inspect({filtered, reverse})
    {o2Rating, _} = Integer.parse(filtered, 2)
    {co2Rating, _} = Integer.parse(reverse, 2)

    result = o2Rating * co2Rating
    IO.puts(result)
  end
end

Solution.partone()
Solution.parttwo()
