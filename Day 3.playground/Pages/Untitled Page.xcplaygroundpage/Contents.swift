// I will always start at the first number in the part number.
// DONE Check if node is visited - skip if true
// DONE Check node for number - skip if false
// append to potential part number
// DONE Check neighbors for symbol - flag isPartNumber=true if found

// Check right node for additional partNumber - stop searching if false, return isPartNumber if flag is true
// each time checking surrounding nodes for symbol (if flag as partNumber is false)

import Cocoa

let fileURL = Bundle.main.url(forResource: "sampleData", withExtension: ".txt")
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

for row in 0..<matrix.count {
    for col in 0..<matrix[row].count {
        // Skip any work if already visited
        if visited[row][col] {
            break
        }
        traverseNode(row: row, col: col)
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
        if visited[row][col] {
            return
        }
        
        // Skip exploring if node isn't a number
        guard matrix[row][col] != "." else {
            visited[row][col] = true
            return
        }
        
        guard matrix[row][col].isNumber else {
            return
        }
        
        // Node is unvisited number.
        visited[row][col] = true
        currentPartNumber += String(matrix[row][col])
        isPartNumber = isValidPartNumber(row: row, col: col)
        
        if let moreNodes = hasAdditionalNumbers(row: row, col: col) {
            nodesToExplore.append(moreNodes)
        }
    }
    
    guard isPartNumber else {
        return
    }
    
    partNumbers.append(currentPartNumber)
}

func hasAdditionalNumbers(row: Int, col: Int) -> [Int]? {
    guard col < matrix[0].count else {
        return nil
    }
    
    guard matrix[row][col+1].isNumber else {
        return nil
    }
    
    return [row, col+1]
}

func isValidPartNumber(row: Int, col: Int) -> Bool {
    
    // check all possible neighbors
    // top left
    if row > 0 && col > 0 && !visited[row-1][col-1] {
        return isSpecialCharacter(matrix[row-1][col-1])
    }
    // top center
    if row > 0 && !visited[row-1][col] {
        return isSpecialCharacter(matrix[row-1][col])
    }
    // top right
    if row > 0 && col < matrix[0].count && !visited[row-1][col+1] {
        return isSpecialCharacter(matrix[row-1][col+1])
    }
    // left
    if col > 0 && !visited[row][col-1] {
        return isSpecialCharacter(matrix[row][col-1])
    }
    // right
    if col < matrix[0].count && !visited[row][col+1] {
        return isSpecialCharacter(matrix[row][col+1])
    }
    // bottom left
    if row < matrix.count && col > 0 && !visited[row+1][col-1] {
        return isSpecialCharacter(matrix[row+1][col-1])
    }
    // bottom center
    if row < matrix.count && !visited[row+1][col] {
        return isSpecialCharacter(matrix[row+1][col])
    }
    // bottom right
    if row < matrix.count && col < matrix[0].count && !visited[row+1][col+1] {
        return isSpecialCharacter(matrix[row+1][col+1])
    }
    
    return false
}

func isSpecialCharacter(_ character: Character) -> Bool {
    if character != "." && !character.isNumber {
        return true
    } else {
        return false
    }
}

visited
partNumbers
