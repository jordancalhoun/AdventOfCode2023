// I will always start at the first number in the part number.
// Check if node is visited - skip if true
// Check node for number - skip if false
// append to potential part number
// Check neighbors for symbol - flag isPartNumber=true if found

// Check right node for additional partNumber - stop searching if false, return isPartNumber if flag is true
// each time checking surrounding nodes for symbol (if flag as partNumber is false)

import Cocoa

let fileURL = Bundle.main.url(forResource: "data", withExtension: ".txt")
let content = try String(contentsOf: fileURL!)

// Convert file into matrix
var matrix = [[Character]]()
let rows = content.components(separatedBy: "\n")
for row in rows {
    let newRow = Array(row)
    matrix.append(newRow)
}

// Initialize Hashmap
/// `visited` will only be updated when the visited node is a `Number` or `.`.
let hashCol = Array(repeating: false, count: matrix[0].count)
var visited = Array(repeating: hashCol, count: matrix.count)

var partNumbers = [String]()
var parts = [String: [Int]]()

for row in 0..<matrix.count {
    for col in 0..<matrix[row].count {
        // Skip any work if already visited
        if !visited[row][col] {
            traverseNode(row: row, col: col)
        }
    }
}

func traverseNode(row: Int, col: Int) {
    var currentPartNumber = ""
    var isPartNumber = false
    var nodesToExplore = [[row, col]]
    
    while !nodesToExplore.isEmpty {
        guard let currentNode = nodesToExplore.popLast() else {
            fatalError("Couldn't get current node.")
        }
        let row = currentNode[0]
        let col = currentNode[1]
        
        // Skip exploring node if already visited
        guard !visited[row][col] else {
            return
        }
        
        // Add to visited, if a not a special character
        if matrix[row][col] == "." || matrix[row][col].isNumber {
            visited[row][col] = true
        }
        
        // Skip exploring if node isn't a number
        guard matrix[row][col] != "." && matrix[row][col].isNumber else {
            return
        }
        
        // Node is unvisited number.
        visited[row][col] = true
        currentPartNumber += String(matrix[row][col])
        if !isPartNumber {
            isPartNumber = isValidPartNumber(row: row, col: col)
        }
        if let nextNumber = getNextNumber(row: row, col: col) {
            nodesToExplore.append(nextNumber)
        }
    }
    
    guard isPartNumber else {
        return
    }
    
    partNumbers.append(currentPartNumber)
}

func getNextNumber(row: Int, col: Int) -> [Int]? {
    guard col < matrix[0].count - 1 && matrix[row][col+1].isNumber else {
        return nil
    }
    
    return [row, col+1]
}

func isValidPartNumber(row: Int, col: Int) -> Bool {
    // check all possible neighbors
    // top left
    if row > 0 && col > 0 && !visited[row-1][col-1] {
        if isSpecialCharacter(matrix[row-1][col-1], row: row-1, col: col-1) {
            return true
        }
    }
    // top center
    if row > 0 && !visited[row-1][col] {
        if isSpecialCharacter(matrix[row-1][col], row: row-1, col: col) {
            return true
        }
    }
    // top right
    if row > 0 && col < matrix[0].count - 1 && !visited[row-1][col+1] {
        if isSpecialCharacter(matrix[row-1][col+1], row: row-1, col: col+1) {
            return true
        }
    }
    // left
    if col > 0 && !visited[row][col-1] {
        if isSpecialCharacter(matrix[row][col-1], row: row, col: col-1) {
            return true
        }
    }
    // right
    if col < matrix[0].count - 1 && !visited[row][col+1] {
        if isSpecialCharacter(matrix[row][col+1], row: row, col: col+1) {
            return true
        }
    }
    // bottom left
    if row < matrix.count - 1 && col > 0 && !visited[row+1][col-1] {
        if isSpecialCharacter(matrix[row+1][col-1], row: row+1, col: col-1) {
            return true
        }
    }
    // bottom center
    if row < matrix.count - 1 && !visited[row+1][col] {
        if isSpecialCharacter(matrix[row+1][col], row: row+1, col: col) {
            return true
        }
    }
    // bottom right
    if row < matrix.count - 1 && col < matrix[0].count - 1  {
        if isSpecialCharacter(matrix[row+1][col+1], row: row+1, col: col+1) {
            return true
        }
    }
    
    return false
}

func isSpecialCharacter(_ character: Character, row: Int, col: Int) -> Bool {
    let character = matrix[row][col]
    let key = String(row) + String(col)
    if character == "." || character.isNumber {
        return false
    }
    
    return true
}


var total = 0
for number in partNumbers {
    total += Int(number)!
}
total

// indexMap of * characters and the count of numbers assosiated with it
// [[row,col]: [partNumber]

// A * with exactly two numbers adjacent
// multiply the two numbers
// add the list of these ratios together

struct gear {
    let location: (Int, Int)
    let partNumbers: [Int]
    
}
