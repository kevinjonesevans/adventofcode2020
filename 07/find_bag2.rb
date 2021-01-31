class Bag
    attr_accessor :type, :quantity, :contents

    def initialize(rules, rule, quantity=1)
        @quantity = quantity
        @contents = nil
        parse_rule(rules, rule)
    end

    def parse_rule(rules, rule)
        @type, contents = rule.split(" contain")
        @type = @type.split(" bag")[0]
        if contents != " no other bags."
            bags = contents.split(", ")
            @contents = bags.collect{|bag|
                words = bag.split(" ")
                quantity = words[0].to_i
                new_bag_type = words[1..-1].join(" ").split(" bag")[0]
                new_bag_rule = rules.select{|rule| rule.split(" contain")[0].include?(new_bag_type)}[0]
                other_rules = rules - [rule]
                Bag.new(other_rules, new_bag_rule, quantity)
                # {quantity: words[0].to_i, bag:words[1..-1].join(" ").split(" bag")[0]}
            }
        end
    end

    # def Bag.parse_rules(rules)
    #     rules.collect{|rule|
    #         Bag.new(rules, rule)
    #     }
    # end

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

    def bag_total()
        
    end

    def to_s
        if @contents
            "Bag Type:#{@type}, Quantity: #{@quantity}, Contents:\t\n#{@contents.each{|content| "\n#{content.to_s}"}}"
        else
            "Bag Type:#{@type}"
        end
    end
end

def part1
    rules = File.open("testinput").readlines.map(&:chomp)
    bag = Bag.new(rules, rules[0])
    puts bag
    puts "------Bags from File-----"
    # bag.each{|bag| 
    #     puts bag
    #     puts
    # }
    # nested_bags = Bag.nest_bags(bags).reject{|bag| bag.nil?}.flatten
    # puts "------Nested Bags-----"
    # nested_bags.each{|bag| 
    #     puts bag
    #     # puts bag[:bag].contains_bag?("shiny gold")
    #     contains_bag = bag[:bag].collect{|bagObj|
    #         bagObj.contains_bag?("shiny gold")
    #     }
    #     puts contains_bag
    #     # puts bag[:bag].sub_bag_quantity
    #     puts
    # }
    # puts "-------Selected Bags----------"
    # selected_bags = nested_bags.select{|bag|
    #     bag.contains_bag?("shiny gold")
    # }
    # selected_bags.each{|bag| 
    #     puts bag
    #     puts bag.contains_bag?("shiny gold")
    #     puts
    # }
    # selected_bags
end

selected_bags = part1
# puts selected_bags.length