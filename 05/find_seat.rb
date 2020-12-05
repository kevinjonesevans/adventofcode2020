def find(seat, rows, columns)
    if seat == nil
        return rows[0], columns[0]
    end
    row_half = rows.length/2
    column_half = columns.length/2
    if seat.first == "F"
        rows = rows.first(row_half)
    elsif seat.first == "B"
        rows = rows.last(row_half)
    elsif seat.first == "L"
        columns = columns.first(column_half)
    elsif seat.first == "R"
        columns = columns.last(column_half)
    end
    find(seat[1..], rows, columns)
end

def part1
    rows = (0..127).to_a
    columns = (0..7).to_a
    lines = File.open("input").readlines
    seatIDs = lines.collect{|line| 
        row, column = find(line.strip.chars, rows, columns)
        seatID = row * 8 + column
        # "#{line}: row #{row}, column #{column}, seat ID #{seatID}."
        seatID
    }
    puts "Seat ID Max:#{seatIDs.max}"
    return seatIDs # for part 2
end

def part2
    seatIDs = part1
    allSeatIDs = (seatIDs.min...seatIDs.max).to_a
    puts "My Seat ID:#{allSeatIDs - seatIDs}"
end

part2