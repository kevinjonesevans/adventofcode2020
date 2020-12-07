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

def part1
    lines = File.open("input").readlines
    group_sums = lines.split{|line| 
        line == "\n"
    }.collect{|answers| 
        answers.flatten().map(&:chomp)
    }.collect{|answers| 
        answers.join(" ").gsub(/\s+/,'')
    }.collect{|group| 
        group.split("").uniq.length
    }
    puts "Part 1 Total:#{group_sums.sum}"
end

def total_group_count(group)
    group.collect{|subgroup| 
        subgroup.split("")
    }.collect{|subgroup| 
        subgroup.collect{|answer|
            answer.split("")
        }
    }.inject(:&).length
end

def part2
    lines = File.open("input").readlines
    group_sums = lines.split{|line| 
        line == "\n"
    }.collect{|answer| 
        answer.map(&:chomp)
    }.collect{|answers| 
            total_group_count(answers)
    }
    puts "Part 2 Total:#{group_sums.sum}"
end

part2