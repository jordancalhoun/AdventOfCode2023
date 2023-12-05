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

// Part 1
let games = filteredString.components(separatedBy: "\n")
var validGames = 0
var currentGame = 1

for game in games {
        let formattedGame = game.components(separatedBy: [";", ","])
        if validateGame(game: formattedGame) { validGames += currentGame }
        currentGame += 1
}
// answer
validGames


/// Calculates the power of cube sets required to make a game possible
/// Input is an array of strings for each draw
/// Returns `Int` of the power of the 3 colors.
func calculateGamePower(game: [String]) -> Int {
    var redMin = 0
    var greenMin = 0
    var blueMin = 0
    
    for draw in game {
        let regexCount = try! NSRegularExpression(pattern: "(?<=\\s)\\d+(?=\\s)", options: [])
        let number = Int(extractNumberFromString(draw)!)
        
        if draw.contains("red") {
            if number > redMin {
                redMin = number
            }
        }
        
        if draw.contains("green") {
            if number > greenMin {
                greenMin = number
            }
        }
        
        if draw.contains("blue") {
            if number > blueMin {
                blueMin = number
            }
        }
    }
    
    return redMin * greenMin * blueMin
}


// Part 2
var sumAnswer = 0
for game in games {
    let formattedGame = game.components(separatedBy: [";", ","])
    sumAnswer += calculateGamePower(game: formattedGame)
}

// answer
sumAnswer











// Input string
let input = "1 blue, 2 green, 8 red; 1 blue, 7 red, 1 green; 11 red, 2 green; 1 red, 1 blue"
let game = input.components(separatedBy: [";", ","])
validateGame(game: game)


















//
//
//
//let inputString = "Game 1: 7 green, 14 red, 5 blue, 8 red, 4 green, 6 green, 18 red, 9 blue"
//let components = inputString.components(separatedBy: ";")
//
//for component in components {
//    let numbers = component.components(separatedBy: CharacterSet.decimalDigits.inverted)
//    let greenIndex = numbers.firstIndex(of: "green")
//    
//    if let index = greenIndex, index > 0 {
//        let numbersBeforeGreen = numbers[..<index]
//        print(Array(numbersBeforeGreen))
//    }
//}
//
//
//
//// Step 1: Split the string into game sections
//let games = input.components(separatedBy: ";")
//
//// Step 4: Create a nested array to store the numbers
//var matrix: [[Int]] = []
//
//// Step 2 and 3: Split the color sections and convert to numbers
//for game in games {
//    let colors = game.components(separatedBy: ",")
//    var gameMatrix: [Int] = []
//    
//    for color in colors {
//        let components = color.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
//        if let number = Int(components[0]) {
//            gameMatrix.append(number)
//        }
//    }
//    
//    matrix.append(gameMatrix)
//}
//
////// Output the matrix
////print(matrix)
//
//
//
//
//
//
//
//
//
//
////Game 1:
////7 green, 14 red, 5 blue;
////8 red, 4 green;
////6 green, 18 red, 9 blue
//

//let COLS = 3
//
//var validGameTotal = 0
//
//let sampleGameData: [[Int]] = [
//    [14, 7, 5],
//    [08, 4, 0],
//    [18, 6, 9]
//]
//var sampletestanswer = [Int]()
//
//func largestInColumn(cols: Int = COLS, matrix: [[Int]]) {
//    for col in 0..<cols {
//        var maxm = matrix[0][col]
//        
//        for row in 0..<matrix[col].count {
//            if matrix[row][col] > maxm {
//                maxm = matrix[row][col]
//            }
//        }
//        sampletestanswer.append(maxm)
//    }
//}
//
//largestInColumn(matrix: sampleGameData)
