class Bag
    attr_accessor :type, :contents

    def initialize(rule)
        parse_rule(rule)
    end

    def parse_rule(rule)
        @type, contents = rule.split(" contain")
        if @type.include?("bags")
            @type = @type.split(" bags")[0]
        end
        if contents == " no other bags."
            @contents = nil
        else
            bags = contents.split(", ")
            bags = bags.collect{|bag|
                bag.split(" ")[1..].join(" ").split(" bag")[0] # remove number at front
            }
            if bags[-1]
                bags[-1] = bags[-1].split(".")[0] # remove period on second bag in contents
            end
            @contents = bags.flatten
        end
    end

    def Bag.parse_rules(rules)
        rules.collect{|rule|
            Bag.new(rule)
        }
    end

    def Bag.nest_bags(bags)
        bags.collect{|bag|
            if bag.contents
                bag.contents = bag.contents.collect{|content|
                    bags.select{|bag|
                        bag.type == content
                    }
                }.flatten
                bag
            else
                bag
            end
        }
    end

    def contains_bag?(bag)
        if (@type != bag) && @contents
            contentsContainingBag = @contents.collect{ |content|
                content.type == bag
            }
            if contentsContainingBag.any? == false
                contentsContainBagsThatContainBag = @contents.collect{|content| 
                    content.contains_bag?(bag)
                }
                return contentsContainBagsThatContainBag.any?
            else
                return true
            end
        end
        return false
    end

    def to_s
        if @contents
            "Bag Type:#{@type}, Contents:#{@contents.each{|content| "#{content.to_s}"}}"
        else
            "Bag Type:#{@type}"
        end
    end
end

def part1
    rules = File.open("input").readlines.map(&:chomp)
    bags = Bag.parse_rules(rules)
    nested_bags = Bag.nest_bags(bags).reject{|bag| bag.nil?}.flatten
    puts "-------Selected Bags----------"
    selected_bags = nested_bags.select{|bag|
        bag.contains_bag?("shiny gold")
}
    # selected_bags.each{|bag| 
    #     puts bag
    #     puts bag.contains_bag?("shiny gold")
    #     puts
    # }
    selected_bags
end

selected_bags = part1
puts selected_bags.length