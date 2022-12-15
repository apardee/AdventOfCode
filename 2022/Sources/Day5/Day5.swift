import Foundation
import Shared

@main
public struct Day5 {
    
    private static func parse(input: String) -> (queues: CrateQueues, moves: [Move]) {
        let (rowInput, moveInput) = {
            let sections = input.split(separator: "\n\n")
            return (sections[0], sections[1])
        }()
        
        let crateQueues = parseCrateQueue(input: rowInput)
        let moves = parseMoves(input: moveInput)
        return (crateQueues, moves)
    }
    
    private static func parseCrateQueue(input: Substring) -> CrateQueues {
        let rows = Array(input
            .split(separator: "\n")
            .reversed())
        
        let columnCount = Int(rows[0]
            .split(separator: #/\s+/#)
            .last!)!

        var queues = CrateQueues()
        for i in 0..<columnCount {
            queues[i + 1] = [Character]()
        }
        
        let crateRows = rows[1...].map { Array($0) }
        for crateRow in crateRows {
            var columnIndex = 1
            for i in 0..<columnCount {
                guard columnIndex < crateRow.count else {
                    break
                }
                let charToAdd = crateRow[columnIndex]
                if charToAdd.isWhitespace == false {
                    queues[i + 1]?.append(charToAdd)
                }
                columnIndex += 4
            }
        }
        return queues
    }
    
    private static func parseMoves(input: Substring) -> [Move] {
        let moveRegex = #/move (?<count>\d+) from (?<source>\d+) to (?<destination>\d+)/#
        return input.split(separator: "\n")
            .map {
                let match = try! moveRegex.wholeMatch(in: String($0))
                return Move(count: Int(match!.count)!,
                            source: Int(match!.source)!,
                            destination: Int(match!.destination)!)
            }
    }
    
    private static func solvePart1() {
        let input = try! loadInput(bundle: Bundle.module)
        var (queues, moves) = parse(input: input)
        
        // Execute moves
        for move in moves {
            var source = queues[move.source]!
            var destination = queues[move.destination]!
            for _ in 0..<move.count {
                let value = source.popLast()!
                destination.append(value)
            }
            queues[move.source] = source
            queues[move.destination] = destination
        }
        
        print("part 1 top values: \(queues.topValues)")
    }
    
    private static func solvePart2() {
        let input = try! loadInput(bundle: Bundle.module)
        var (queues, moves) = parse(input: input)
        
        // Execute moves
        for move in moves {
            let source = queues[move.source]!
            let destination = queues[move.destination]!
            
            let sz = source.count
            let moved = Array(source[(sz - move.count)...])
            let newSource = Array(source[..<(sz - move.count)])
            let newDestination = destination + moved
            
            queues[move.source] = newSource
            queues[move.destination] = newDestination
        }
        
        print("part 2 top values: \(queues.topValues)")
    }

    public static func main() {
        solvePart1()
        solvePart2()
    }
}

private struct Move {
    let count: Int
    let source: Int
    let destination: Int
}

private typealias CrateQueues = [Int: [Character]]

private extension CrateQueues {
    var topValues: String {
        var topValues = ""
        for i in 0...self.count {
            if let char = self[i]?.last {
                topValues += String(char)
            }
        }
        return topValues
    }
}
