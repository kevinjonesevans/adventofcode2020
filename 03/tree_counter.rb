def traverse_and_mark(map, position, slope)
    copy = map.clone.map(&:clone)
    line_width = copy[0].length
    if position[:x] + slope[:x] >= line_width-1
        position[:x] = position[:x] - line_width
    end
    move_to = copy[position[:y] + slope[:y]][position[:x] + slope[:x]]

    if move_to == "."
        copy[position[:y] + slope[:y]][position[:x] + slope[:x]] = "O"
    elsif move_to == "#"
        copy[position[:y] + slope[:y]][position[:x] + slope[:x]] = "X"
    end

    return copy, {x: position[:x] + slope[:x], y: position[:y] + slope[:y]}
end

def sled(map, slope)
    position = {x: 0, y: 0}

    while position[:y] < map.length-1
        map, position = traverse_and_mark(map, position, slope)
    end 

    return map
end

lines = File.open("input").readlines.map(&:chomp)

puts "Part 1"
slope = {x: 3, y: 1}
puts "Trees encountered:#{sled(lines, slope).join.count("X")} with slope:#{slope}"

puts "Part 2"
trees_encountered = []
trees_encountered.push(sled(lines, slope).join.count("X")) # save part 1
slope = {x: 1, y: 1}
trees_encountered.push(sled(lines, slope).join.count("X"))
puts "Trees encountered:#{trees_encountered.last} with slope:#{slope}"
slope = {x: 5, y: 1}
trees_encountered.push(sled(lines, slope).join.count("X"))
puts "Trees encountered:#{trees_encountered.last} with slope:#{slope}"
slope = {x: 7, y: 1}
trees_encountered.push(sled(lines, slope).join.count("X"))
puts "Trees encountered:#{trees_encountered.last} with slope:#{slope}"
slope = {x: 1, y: 2}
trees_encountered.push(sled(lines, slope).join.count("X"))
puts "Trees encountered:#{trees_encountered.last} with slope:#{slope}"
puts "Answers:#{trees_encountered.inject(:*)}"