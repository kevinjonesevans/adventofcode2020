defmodule PasswordValidator do
    def readRulesFromFile() do
        {:ok, body} = File.read("input")
        body 
            |> String.split("\n") 
    end

    def parseRuleWithPassword(ruleWithPassword) do
        [rule, password] = String.split(ruleWithPassword, ":")
        [bounds, character] = String.split(rule, " ")
        [lower, upper] = Enum.map(String.split(bounds, "-"), &String.to_integer/1)
        %{ password: String.trim(password), character: character, lower: lower, upper: upper }
    end

    def characterCount(string, character) do 
        string
            |> String.graphemes
            |> Enum.count(&(&1 == character))
    end

    def isValidPart1?(%{character: character, password: password, lower: lower, upper: upper}) do
        characterCount = characterCount(password, character)
        lower <= characterCount && characterCount <= upper
    end

    def isValidPart2?(%{character: character, password: password, lower: lower, upper: upper}) do
        (String.at(password, lower-1) == character && String.at(password, upper-1) != character) || 
            (String.at(password, lower-1) != character && String.at(password, upper-1) == character)
    end

    def validate([]) do
        []
    end

    def validate(rulesWithPasswords) do
        [ head | tail ] = rulesWithPasswords
        Enum.filter([ parseRuleWithPassword(head) | validate(tail) ], &isValidPart2?/1)
    end

    def countValidPasswords do
        readRulesFromFile()
            |> validate
            |> Enum.count
    end
end

IO.inspect PasswordValidator.countValidPasswords, label: "Valid Passwords"