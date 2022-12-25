import Foundation
import Shared

@main
struct Day25 {
    public static func main() {
        let lines = try! loadInput(bundle: .module, type: .personal).split(separator: "\n")
        var sum = 0
        for line in lines {
            sum += fromSNAFU(input: line)
        }
        print("solution: \(toSNAFU(value: sum))")
    }
    
    private static func fromSNAFU(input: Substring) -> Int {
        var value = 0
        var base = 1
        for (_, char) in Array(input).reversed().enumerated() {
            let digit: Int
            switch char {
            case "0": digit = 0
            case "1": digit = 1
            case "2": digit = 2
            case "=": digit = -2
            case "-": digit = -1
            default: digit = 0
            }
            value += digit * base
            base *= 5
        }
        return value
    }
    
    private static func toSNAFU(value: Int) -> String {
        var currValue = value
        var output = [Int: Int]()
        var currIdx = 0
        while currValue > 0 {
            let nextValue = currValue % 5
            output[currIdx] = nextValue
            currValue = currValue / 5
            currIdx += 1
        }
        
        var outputString = ""
        var i = 0
        while true {
            if i >= output.count {
                break
            }
            let value = output[i]!
            if value > 2 {
                var nextValue = output[i + 1] ?? 0
                if value == 3 {
                    outputString += "="
                    nextValue += 1
                } else if value == 4 {
                    outputString += "-"
                    nextValue += 1
                } else if value == 5 {
                    outputString += "0"
                    nextValue += 1
                }
                output[i + 1] = nextValue
            } else {
                outputString += "\(value)"
            }
            i += 1
        }
        return String(outputString.reversed())
    }
}
