class RuleWithPassword
    attr_accessor :password, :character, :lower, :upper

    def initialize(ruleWithPassword)
        parse(ruleWithPassword)
    end

    def parse(line)
        rule, @password = line.split(":")
        limits, @character = rule.split(" ")
        @lower, @upper = limits.split("-").map(&:to_i)
        @password = @password.strip()
    end

    def isValid1?
        @lower <= @password.count(@character) && @password.count(@character) <= @upper
    end

    def isValid2?
        (@password[@lower-1] == @character && @password[@upper-1] != @character) || 
            (@password[@lower-1] != @character && @password[@upper-1] == @character)
    end
end

lines = File.open("input").readlines.map(&:chomp)
ruleObjs = lines.collect do |line|
    RuleWithPassword.new(line)
end
valid1Passwords = ruleObjs.select(&:isValid1?)
valid2Passwords = ruleObjs.select(&:isValid2?)

puts "Total for Part 1:#{valid1Passwords.count}"
puts "Total for Part 2:#{valid2Passwords.count}"