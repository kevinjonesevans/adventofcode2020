defmodule TreeCounter do
    def readFromFile() do
        {:ok, body} = File.read("testinput")
        body 
            |> String.split("\n") 
    end

    def count(".") do
        0
    end

    def count("#") do
        1
    end

    def traverse([], _, _, _) do
        []
    end

    def traverse(lines, slope, position, line_width) do
        IO.inspect lines
        # IO.inspect slope
        # IO.inspect position
        newposition = Map.merge(position, slope, fn _k, v1, v2 -> v1+v2 end)
        # IO.inspect newposition
        newx = 
            newposition
                |> Map.get(:x)
                |> Integer.mod(line_width-1)
        # IO.inspect newx
        [ head | tail ] = lines
        [ count(String.at(head, newx)) | traverse(tail, slope, newposition, line_width) ]
    end

    def countTreesEncountered(slope) do
        position = %{x: 0, y: 0}
        lines = readFromFile()
        lines
            |> traverse(slope, position, Enum.count(lines))
            |> Enum.sum
            # |> IO.inspect
    end
end

slope = %{x: 1, y: 1}
IO.inspect TreeCounter.countTreesEncountered(slope), label: "Trees encountered"
# slope = %{x: 3, y: 1}
# IO.inspect TreeCounter.countTreesEncountered(slope), label: "Trees encountered"
# slope = %{x: 5, y: 1}
# IO.inspect TreeCounter.countTreesEncountered(slope), label: "Trees encountered"
# slope = %{x: 7, y: 1}
# IO.inspect TreeCounter.countTreesEncountered(slope), label: "Trees encountered"
# slope = %{x: 1, y: 2}
# IO.inspect TreeCounter.countTreesEncountered(slope), label: "Trees encountered"