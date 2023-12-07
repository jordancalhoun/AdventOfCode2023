// MARK: Parsing
// Split text into array of lines/games
// Split the games into it's two sections: playersNumbers & winningNumbers
    // Convert first section into an array of numbers
        // push this array into a playerNumbersGames array
    // Convert second section into an array of numbers
        // push this array into a winningNumbersGames array
// Result: playerNumbersGames: [[Int]] and winningNumbersGames: [[Int]]

// MARK: Algorithm
// compare playerNumbers[i] with winningNumbers[i] for matching values
    // totalPoints = 0
    // Loop through each playerNumbersGames
        // matches = 0
        // Loop through each playerNumbers
            // if winningNumbers contains playerNumbers[i]
                // matches += 1
        // calcuate points
            // if matches > 0
                // totalPoints = 2^(x-1) points
    // return totalPoints


import Cocoa
import RegexBuilder

// Setup
var totalPoints: Decimal = 0.0
var playerGames = [[Int]]()
var winningGames = [[Int]]()

// MARK: Parsing

// Get data from file
guard let url = Bundle.main.url(forResource: "data", withExtension: ".txt") else {
    fatalError("Failed to get file URL.")
}
guard let data = try? String(contentsOf: url) else {
    fatalError("Failed to get data from file.")
}

// Convert raw data into descrete game strings
let gameStrings = getGamesFromData(data)

// Add each games string to respective arrays.
for gameString in gameStrings {
    let (player, winning) = splitGameFromString(gameString)
    
    playerGames.append(convertStringToNumbers(player))
    winningGames.append(convertStringToNumbers(winning))
}

// MARK: Algorithm
for i in 0..<playerGames.count {
    var matches = 0
    for playerNumber in playerGames[i] {
        if winningGames[i].contains(playerNumber) {
            matches += 1
        }
    }
    
    if matches > 0 {
        totalPoints += pow(2.0, matches - 1)
    }

}

// Answer
totalPoints

// MARK: - Methods

/// Returns an array of games.
/// Each game is represented by its raw string value.
func getGamesFromData(_ input: String) -> [String] {
    return input.components(separatedBy: "\n")
}

/// Returns a touple of two strings.
/// First string is the player's numbers
/// Second string is the winning numbers
func splitGameFromString(_ input: String) -> (String, String){
    let components = input.components(separatedBy: "|")
    guard components.count == 2 else {
        fatalError("Components from game is not equal to expected 2.")
    }
    return (components[0], components[1])
}

/// Takes a string of numbers and returns them in a array as intergers.
/// Discards eroneous text such as the game number.
func convertStringToNumbers(_ input: String) -> [Int] {
    let NUMBER_PATTERN = Regex {
        OneOrMore {
            OneOrMore {
                One(.digit)
            }
            NegativeLookahead {
                Optionally {
                    OneOrMore(.digit)
                }
                ":"
            }
        }
    }
    let matches = input.matches(of: NUMBER_PATTERN)
    
    var numbers = [Int]()
    for match in matches {
        guard let number = Int(match.output) else {
            fatalError("Couldn't convert string to a number.")
        }
        numbers.append(number)
    }
    return numbers
}
