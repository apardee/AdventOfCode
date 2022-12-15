import Foundation
import Shared

@main
public struct Day13 {
    enum Element: Hashable {
        case list([Element])
        case number(Int)
    }
    
    enum CompareResult {
        case less
        case greater
        case equal
    }
    
    public static func main() {
        solvePart1()
        solvePart2()
    }
    
    private static func solvePart1() {
        let input = try! loadInput(bundle: .module)
        let pairs = input.split(separator: "\n\n")
            .map { pair in pair.split(separator: "\n") }
            .map { lines in (lhs: parseArg(lines[0]),
                             rhs: parseArg(lines[1])) }
        
        var totalRight = 0
        for (idx, (lhs, rhs)) in pairs.enumerated() {
            if compare(lhs: lhs, rhs: rhs) == .less {
                totalRight += (idx + 1)
            }
        }
        print("part 1 (total right): \(totalRight)")
    }
    
    private static func solvePart2() {
        let input = try! loadInput(bundle: .module)
        var sequences = input.split(separator: "\n\n")
            .map { pair in pair.split(separator: "\n") }
            .flatMap { lines in [ parseArg(lines[0]), parseArg(lines[1]) ] }
        
        let divider1 = parseArg("[[2]]")
        let divider2 = parseArg("[[6]]")
        sequences.append(divider1)
        sequences.append(divider2)
        
        let sorted = sequences.sorted { lhs, rhs in
            return compare(lhs: lhs, rhs: rhs) == .less
        }
        
        let firstIdx = sorted.firstIndex(of: divider1)! + 1
        let secondIdx = sorted.firstIndex(of: divider2)! + 1
        print("part 2 (divider product): \(firstIdx * secondIdx)")
    }
    
    private static func compare(lhs: Element, rhs: Element) -> CompareResult {
        switch (lhs, rhs) {
        case (.number(let left), .number(let right)):
            return compare(lhs: left, rhs: right)
        case (.list(let left), .list(let right)):
            return compare(lhs: left, rhs: right)
        case (.number(let left), let rhs):
            return compare(lhs: .list([.number(left)]), rhs: rhs)
        case (let lhs, .number(let right)):
            return compare(lhs: lhs, rhs: .list([.number(right)]))
        }
    }
    
    private static func compare(lhs: [Element], rhs: [Element]) -> CompareResult {
        var lhs = lhs[...]
        var rhs = rhs[...]
        while true {
            if lhs.count == 0 && rhs.count == 0 {
                return .equal
            } else if lhs.count == 0 && rhs.count != 0 {
                return .less
            } else if lhs.count != 0 && rhs.count == 0 {
                return .greater
            }
            
            let result = compare(lhs: lhs[lhs.startIndex], rhs: rhs[rhs.startIndex])
            if result != .equal {
                return result
            }
            lhs = lhs[lhs.index(after: lhs.startIndex)...]
            rhs = rhs[rhs.index(after: rhs.startIndex)...]
        }
    }
    
    private static func compare(lhs: Int, rhs: Int) -> CompareResult {
        if lhs < rhs {
            return .less
        } else if lhs > rhs {
            return .greater
        } else {
            return .equal
        }
    }
    
    private static func parseArg(_ input: Substring) -> Element {
        let (element, _) = parseList(input)
        return element
    }
    
    private static func parseList(_ input: Substring) -> (Element, Substring.Index) {
        let start = input.index(after: input.startIndex)
        var opens = 1
        var curr = start
        while curr < input.endIndex {
            switch input[curr] {
                case "[": opens += 1
                case "]": opens -= 1
                default: break
            }
            if opens == 0 {
                break
            }
            curr = input.index(after: curr)
        }
        let listContents = input[start..<curr]
        return (.list(parseListElements(listContents)), input.index(after: curr))
    }
    
    private static func parseNumber(_ input: Substring) -> (Element, Substring.Index) {
        let start = input.startIndex
        var numString = ""
        var curr = start
        outer: while curr < input.endIndex {
            switch input[curr] {
            case "0"..."9":
                numString += String(input[curr])
            default:
                break outer
            }
            curr = input.index(after: curr)
        }
        return (.number(Int(numString)!), curr)
    }
    
    private static func parseListElements(_ input: Substring) -> [Element] {
        var curr = input.startIndex
        let end = input.endIndex

        var outputElements = [Element]()
        while curr < end {
            if input[curr] == "[" {
                let (element, nextIdx) = parseList(input[curr...])
                outputElements.append(element)
                curr = nextIdx
            } else if input[curr] == "," {
                curr = input.index(after: curr)
            } else {
                let (element, nextIdx) = parseNumber(input[curr...])
                outputElements.append(element)
                curr = nextIdx
            }
        }
        return outputElements
    }
}
