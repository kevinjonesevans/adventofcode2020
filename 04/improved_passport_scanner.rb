class Passport
    attr_accessor :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid

    def initialize(passport_string)
        parse(passport_string)
    end

    def parse(passport_string)
        kvpairs = passport_string.split(" ")
        attrs = kvpairs.collect{|pair| {pair.split(":")[0].to_sym => pair.split(":")[1]}}
        attrs.each{ |attr|
            self.send("#{attr.keys()[0]}=","#{attr.values()[0]}")
        }
    end

    def part1_valid?
        self.instance_variables.length == 8 || (self.instance_variables.length == 7 && !self.instance_variables.include?(:@cid))
    end

    def valid_byr?
        #four digits; at least 1920 and at most 2002.
        1920 <= @byr.to_i && @byr.to_i <= 2002
    end

    def valid_ecl?
        ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(@ecl)
    end

    def valid_iyr?
        #four digits; at least 2010 and at most 2020
        2010 <= @iyr.to_i && @iyr.to_i <= 2020
    end

    def valid_eyr?
        #four digits; at least 2020 and at most 2030
        2020 <= @eyr.to_i && @eyr.to_i <= 2030
    end

    def valid_hgt?
        #a number followed by either cm or in:
        #    If cm, the number must be at least 150 and at most 193.
        #    If in, the number must be at least 59 and at most 76.
        if /\A\d{1,3}(cm|in)\z/.match(@hgt) != nil
            if @hgt.include?("in")
                num = @hgt.split("in")[0].to_i
                return 59 <= num && num <= 76
            elsif @hgt.include?("cm")
                num = @hgt.split("cm")[0].to_i
                return 150 <= num && num <= 193
            end
            false
        end
        false
    end

    def valid_hcl?
        # a # followed by exactly six characters 0-9 or a-f.
        /\A#(?:\h{3}){1,2}\z/.match(@hcl) != nil
    end

    def valid_pid?
        # a nine-digit number, including leading zeroes.
        /\A\d{9}\z/.match(@pid) != nil
    end

    def valid_cid?
        true
    end

    def part2_valid?
        self.part1_valid? && self.instance_variables.collect{|var| self.send("valid_#{var[1..]}?")}.all?
    end
end

# monkey-patch stolen from Rails
class Array
    def split(value = nil)
        arr = dup
        result = []
        if block_given?
          while (idx = arr.index { |i| yield i })
            result << arr.shift(idx)
            arr.shift
          end
        else
          while (idx = arr.index(value))
            result << arr.shift(idx)
            arr.shift
          end
        end
        result << arr
      end
end

lines = File.open("input").readlines
passport_strings = lines.split{|line| line == "\n"}.collect{|passport| passport.flatten().map(&:chomp)}.collect{|passport| passport.join(" ")}
passports = passport_strings.collect{|passport_string| Passport.new(passport_string)}
valid1 = passports.collect{|passport| passport.part1_valid?}.count(true)
valid2 = passports.collect{|passport| passport.part2_valid?}.count(true)
puts "Part 1 Valid Count:#{valid1}"
puts "Part 2 Valid Count:#{valid2}"
