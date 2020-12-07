defmodule SeatFinder do    
    def calcSeatID(%{row: row, column: column}) do
        row * 8 + column
    end

    def calcSeatIDs([]) do
        []
    end

    def calcSeatIDs([head|tail]) do
        [calcSeatID(head)| calcSeatIDs(tail)]
    end

    def findSeat([], rows, columns) do
        %{row: Enum.at(rows, 0), column: Enum.at(columns, 0)}
    end

    def findSeat(seat, rows, columns) do
        row_half = trunc(length(rows)/2)
        column_half = trunc(length(columns)/2)
        [head | tail] = seat
        case head do
            "F" ->
                findSeat(tail, Enum.slice(rows, 0, row_half), columns)
            "B" ->
                findSeat(tail, Enum.slice(rows, row_half, row_half), columns)
            "L" ->
                findSeat(tail, rows, Enum.slice(columns, 0, column_half))
            "R" ->
                findSeat(tail, rows, Enum.slice(columns, column_half, column_half))
        end
    end

    def findSeats([], _, _) do
        []
    end

    def findSeats([head | tail], rows, columns) do
        [findSeat(String.graphemes(head), rows, columns) | findSeats(tail, rows, columns)]
    end

    def part1 do
        rows = Enum.to_list(0..127)
        columns = Enum.to_list(0..7)
        {:ok, contents} = File.read("input")
        seatIDs = 
            contents 
                |> String.split("\n") 
                |> findSeats(rows, columns)
                |> calcSeatIDs

        IO.puts "Seat ID Max:#{Enum.max(seatIDs)}"
        seatIDs # for part 2
    end

    def part2 do
        seatIDs = part1()
        allSeatIDs = Enum.to_list(Enum.min(seatIDs)..Enum.max(seatIDs))
        MapSet.difference(MapSet.new(allSeatIDs), MapSet.new(seatIDs))
    end
end

IO.inspect SeatFinder.part2