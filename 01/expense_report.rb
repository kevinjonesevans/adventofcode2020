file = File.open("input")
numbers = file.readlines.map(&:chomp).map(&:to_i)
results = []

numbers.each do |num|
    numbers.each do |num1|
        numbers.each do |num2|
            if num + num1 + num2 == 2020
                results << num * num1 * num2
            end
        end
    end
end

puts results.inspect