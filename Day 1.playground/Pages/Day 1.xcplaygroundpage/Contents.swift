import Cocoa

let fileURL = Bundle.main.url(forResource: "day1", withExtension: ".txt")
let content = try String(contentsOf: fileURL!)

// Filter out garbage
let pattern = "[^0-9\n]" // Keep numbers and line breaks
let regex = try! NSRegularExpression(pattern: pattern)
let filteredString = regex.stringByReplacingMatches(in: content, range: NSRange(location: 0, length: content.utf16.count), withTemplate: "")

// Convert to an array
let arrayOfContent = filteredString.components(separatedBy: "\n")

// Grab the first and last digit
var answer = 0

for content in arrayOfContent {
    guard let first = content.first  else {
        print("ERROR: \(content)")
        break
    }
    guard let last = content.last  else {
        print("ERROR")
        break
    }
    
    let combined = String(first) + String(last)
    
    guard let calibrationValue = Int(combined) else {
        print("ERROR")
        break
    }
    answer += calibrationValue
}

answer
