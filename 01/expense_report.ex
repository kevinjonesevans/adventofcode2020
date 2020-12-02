defmodule ExpenseReport do
    def findTwoSumTo2020() do
        {:ok, body} = File.read("testinput")
        numbers = body |> String.split("\n") |> Enum.map(&String.to_integer/1)
        
        numbers
            |> Enum.with_index
            |> Enum.each(
                fn {head, headindex} -> 
                    tail = Enum.slice(numbers, 0..headindex-1) ++ Enum.slice(numbers, headindex+1..-1)
                    Enum.reduce(
                        tail, 
                        [], 
                        fn(number, _acc) ->
                            if number + head == 2020 do
                                IO.puts(number * head)
                            end
                        end
                    )
                end
            )
    end

    def find2020Dumb() do
        {:ok, body} = File.read("testinput")
        numbersWithIndex = body |> String.split("\n") |> Enum.map(&String.to_integer/1) |> Enum.with_index
        Enum.each(numbersWithIndex,
            fn {head, headindex} -> 
                tail = Enum.slice(numbersWithIndex, 0..headindex-1) ++ Enum.slice(numbersWithIndex, headindex+1..-1)
                Enum.map(
                    tail,
                    fn({number, _numberindex}) ->
                        if number + head == 2020 do
                            IO.puts number * head
                        end
                    end
                )
            end
        )
    end

    def find2020() do
        {:ok, body} = File.read("input")
        numbers = body |> String.split("\n") |> Enum.map(&String.to_integer/1)
        for num <- numbers do
            for num2 <- numbers do
                for num3 <- numbers do
                    if num + num2 + num3 == 2020 do
                        IO.puts num * num2 * num3
                    end
                end
            end
        end
    end
end

# ExpenseReport.findTwoSumTo2020
# ExpenseReport.find2020Dumb
ExpenseReport.find2020