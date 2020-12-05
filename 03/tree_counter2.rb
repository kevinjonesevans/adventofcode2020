def traverse(map, position, slope)
    copy = map.clone.map(&:clone)
    line_width = copy[0].length
    if position[:x] + slope[:x] >= line_width-1
        position[:x] = position[:x] - line_width
    end
    move_to = copy[position[:y] + slope[:y]][position[:x] + slope[:x]]
    new_position = {x: position[:x] + slope[:x], y: position[:y] + slope[:y]}

    if move_to == "#"
        1, new_position
    end
    0, new_position
end

def sled(map, position, slope)
    head, tail = map.first, map[1..-1]
    
    map.sum do |terrain|
        traverse(head, position, slope)
    end
    while position[:y] < map.length-1
        map, position = traverse_and_mark(map, position, slope)
    end 

    return map
end

lines = File.open("input").readlines.map(&:chomp)

puts "Part 1"
position = {x: 0, y: 0}
slope = {x: 3, y: 1}
puts "Trees encountered:#{sled(lines, position, slope)} with slope:#{slope}"

# puts "Part 2"
# trees_encountered = []
# trees_encountered.push(sled(lines, slope).join.count("X")) # save part 1
# slope = {x: 1, y: 1}
# trees_encountered.push(sled(lines, slope).join.count("X"))
# puts "Trees encountered:#{trees_encountered.last} with slope:#{slope}"
# slope = {x: 5, y: 1}
# trees_encountered.push(sled(lines, slope).join.count("X"))
# puts "Trees encountered:#{trees_encountered.last} with slope:#{slope}"
# slope = {x: 7, y: 1}
# trees_encountered.push(sled(lines, slope).join.count("X"))
# puts "Trees encountered:#{trees_encountered.last} with slope:#{slope}"
# slope = {x: 1, y: 2}
# trees_encountered.push(sled(lines, slope).join.count("X"))
# puts "Trees encountered:#{trees_encountered.last} with slope:#{slope}"
# puts "Answers:#{trees_encountered.inject(:*)}"