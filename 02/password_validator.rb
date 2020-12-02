def readFile(filename)
    file = File.open(filename)
    rulesWithPasswords = file.readlines.map(&:chomp)
end

def parsePassword(line)
    rule, password = line.split(":")
    bounds, character = rule.split(" ")
    lowerBound, upperBound = bounds.split("-").map(&:to_i)
    return password.strip(), character, lowerBound, upperBound
end

def part1
    rulesWithPasswords = readFile("input")
    validPasswords = []
    rulesWithPasswords.each do |ruleWithPassword|
        password, character, lowerBound, upperBound = parsePassword(ruleWithPassword)
        if lowerBound <= password.count(character) && password.count(character) <= upperBound
            validPasswords.push(ruleWithPassword)
        end
    end

    puts "Part 1"
    puts "Valid Passwords#{validPasswords}"
    puts "Total:#{validPasswords.count}"
end

def part2
    rulesWithPasswords = readFile("input")
    validPasswords = []
    rulesWithPasswords.each do |ruleWithPassword|
        password, character, lowerPosition, upperPosition = parsePassword(ruleWithPassword)
        if (password[lowerPosition-1] == character && password[upperPosition-1] != character) || 
            (password[lowerPosition-1] != character && password[upperPosition-1] == character)
            validPasswords.push(ruleWithPassword)
        end
    end

    puts "Part 2"
    puts "Valid Passwords#{validPasswords}"
    puts "Total:#{validPasswords.count}"
end

part2