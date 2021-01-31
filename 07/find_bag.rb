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
            @contents = bags.collect{|bag|
                words = bag.split(" ")
                {quantity: words[0].to_i, bag:words[1..-1].join(" ").split(" bag")[0]}
            }
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
                bag.contents.each{|content|
                    # puts "Content: #{content}"
                    # puts "content[:bag]:#{content[:bag]}"
                    if content
                        quantity = content[:quantity]
                        bag = content[:bag]
                        bagObj = bags.select{|bag|
                            bag.type == content[:bag]
                        }
                        content[:bag] = bagObj
                        content[:quantity] = quantity
                        # content[:bag] = bags
                        # puts "bag:#{bag}"
                        # puts "{quantity: content[:quantity], bag: bag}:#{{quantity: content[:quantity], bag: bag}}"
                        # {quantity: content[:quantity], bag: bag}
                        bag
                    end
                }.flatten
            # else
            #     {quantity: 0, bag: [nil]}
            end
        }
    end

    def contains_bag?(bag)
        if (@type != bag) && @contents != [nil] #&& @contents[:bag].contents
            contentsContainingBag = @contents.collect{ |content|
                if content
                    puts "Content:#{content}"
                    if content[:bag].length > 0
                        puts "content[:bag]:#{content[:bag]}"
                        content[:bag][0].type == bag #|| content[:bag].collect{|b| b.contains_bag?(bag)}.any?
                        # content[:bag].type == bag
                    end
                else
                    false
                end
            }
            # if contentsContainingBag.any? == false
            #     contentsContainBagsThatContainBag = @contents.collect{|content| 
            #         if content
            #             content.contains_bag?(bag)
            #         else
            #             false
            #         end
            #     }
            #     return contentsContainBagsThatContainBag.any?
            # else
            #     return true
            # end
        end
        return false
    end

    def sub_bag_quantity()
        @contents.each{|content| 
            puts content
            # content[:quantity]
        }
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
    rules = File.open("testinput").readlines.map(&:chomp)
    bags = Bag.parse_rules(rules)
    puts "------Bags from File-----"
    bags.each{|bag| 
        puts bag
        puts
    }
    nested_bags = Bag.nest_bags(bags).reject{|bag| bag.nil?}.flatten
    puts "------Nested Bags-----"
    nested_bags.each{|bag| 
        puts bag
        # puts bag[:bag].contains_bag?("shiny gold")
        contains_bag = bag[:bag].collect{|bagObj|
            bagObj.contains_bag?("shiny gold")
        }
        puts contains_bag
        # puts bag[:bag].sub_bag_quantity
        puts
    }
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