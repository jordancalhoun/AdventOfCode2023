import Cocoa

let fileURL = Bundle.main.url(forResource: "data", withExtension: ".txt")
let content = try String(contentsOf: fileURL!)

// remove game numbers, will use index + 1 for answer calculation
let pattern = ".*?(:)"
let regex = try! NSRegularExpression(pattern: pattern)
let filteredString = regex.stringByReplacingMatches(in: content, range: NSRange(location: 0, length: content.utf16.count), withTemplate: "")


let MAX_RED = 12
let MAX_GREEN = 13
let MAX_BLUE = 14

/// Returns the a `String` of the number before the given input.
/// Returns nil if given string is not found.
func extractNumberFromString(_ input: String) -> Int? {
    let pattern = "\\d+"
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
    
    if let match = matches.first {
        let range = Range(match.range, in: input)!
        let numberString = input[range]
        return Int(numberString)
    }
    
    return nil
}

/// Check's if a game is possible or not.
/// Input is an array of strings for each draw
/// Returns `true` if all colors are below MAX value.
func validateGame(game: [String]) -> Bool {
    for draw in game {
        let regexCount = try! NSRegularExpression(pattern: "(?<=\\s)\\d+(?=\\s)", options: [])
        let number = Int(extractNumberFromString(draw)!)
        
        if draw.contains("red") {
            if number > MAX_RED {
                return false
            }
        }
        
        if draw.contains("green") {
            if number > MAX_GREEN {
                return false
            }
        }
        
        if draw.contains("blue") {
            if number > MAX_BLUE {
               return false
            }
        }
    }
    
    return true
}

let games = filteredString.components(separatedBy: "\n")
var validGames = 0
var currentGame = 1

for game in games {
    if currentGame < 101 {
        let formattedGame = game.components(separatedBy: [";", ","])
        if validateGame(game: formattedGame) {
            validGames += currentGame
            gameResults.append(true)
        } else {
            gameResults.append(false)
        }
        currentGame += 1
    }
}

validGames
