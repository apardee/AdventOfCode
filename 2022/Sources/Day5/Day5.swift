@main
public struct Day5 {
    
//    private static let input = """
//        [D]
//    [N] [C]
//    [Z] [M] [P]
//     1   2   3
//
//    move 1 from 2 to 1
//    move 3 from 1 to 3
//    move 2 from 2 to 1
//    move 1 from 1 to 2
//    """
    
    private static let input = """
    [P]     [C]         [M]
    [D]     [P] [B]     [V] [S]
    [Q] [V] [R] [V]     [G] [B]
    [R] [W] [G] [J]     [T] [M]     [V]
    [V] [Q] [Q] [F] [C] [N] [V]     [W]
    [B] [Z] [Z] [H] [L] [P] [L] [J] [N]
    [H] [D] [L] [D] [W] [R] [R] [P] [C]
    [F] [L] [H] [R] [Z] [J] [J] [D] [D]
     1   2   3   4   5   6   7   8   9

    move 4 from 9 to 1
    move 6 from 3 to 1
    move 7 from 4 to 1
    move 2 from 8 to 5
    move 1 from 9 to 7
    move 1 from 8 to 5
    move 3 from 6 to 4
    move 6 from 1 to 5
    move 14 from 1 to 2
    move 1 from 6 to 1
    move 2 from 6 to 2
    move 9 from 5 to 9
    move 2 from 4 to 5
    move 2 from 5 to 3
    move 6 from 9 to 6
    move 4 from 1 to 2
    move 2 from 1 to 2
    move 5 from 6 to 1
    move 1 from 4 to 9
    move 4 from 9 to 4
    move 2 from 3 to 7
    move 2 from 4 to 9
    move 2 from 9 to 6
    move 5 from 2 to 9
    move 1 from 4 to 9
    move 1 from 4 to 3
    move 5 from 9 to 8
    move 1 from 6 to 5
    move 3 from 7 to 5
    move 2 from 1 to 6
    move 5 from 6 to 8
    move 1 from 9 to 4
    move 1 from 6 to 5
    move 9 from 2 to 7
    move 1 from 2 to 3
    move 1 from 4 to 6
    move 8 from 5 to 4
    move 1 from 6 to 1
    move 2 from 8 to 6
    move 1 from 6 to 4
    move 7 from 4 to 6
    move 1 from 3 to 1
    move 1 from 3 to 4
    move 3 from 4 to 1
    move 2 from 3 to 4
    move 2 from 4 to 5
    move 3 from 5 to 7
    move 7 from 8 to 2
    move 5 from 1 to 2
    move 12 from 7 to 6
    move 2 from 1 to 9
    move 2 from 9 to 1
    move 1 from 7 to 5
    move 6 from 2 to 3
    move 5 from 2 to 6
    move 6 from 2 to 6
    move 4 from 3 to 1
    move 3 from 2 to 1
    move 1 from 5 to 4
    move 7 from 1 to 2
    move 1 from 4 to 8
    move 7 from 2 to 9
    move 5 from 2 to 8
    move 2 from 6 to 8
    move 21 from 6 to 9
    move 8 from 9 to 1
    move 2 from 6 to 1
    move 3 from 8 to 7
    move 6 from 6 to 4
    move 7 from 1 to 8
    move 1 from 9 to 1
    move 7 from 7 to 3
    move 1 from 7 to 4
    move 1 from 7 to 4
    move 7 from 8 to 1
    move 5 from 4 to 8
    move 10 from 1 to 2
    move 3 from 1 to 4
    move 3 from 2 to 9
    move 1 from 4 to 5
    move 3 from 3 to 6
    move 1 from 6 to 4
    move 1 from 6 to 7
    move 1 from 7 to 8
    move 7 from 2 to 4
    move 10 from 9 to 1
    move 10 from 4 to 5
    move 2 from 5 to 2
    move 2 from 2 to 1
    move 11 from 8 to 9
    move 7 from 1 to 4
    move 1 from 6 to 1
    move 1 from 8 to 3
    move 1 from 4 to 6
    move 6 from 4 to 5
    move 1 from 5 to 7
    move 1 from 6 to 8
    move 6 from 1 to 6
    move 19 from 9 to 2
    move 1 from 1 to 8
    move 1 from 4 to 7
    move 9 from 2 to 6
    move 1 from 9 to 2
    move 2 from 8 to 1
    move 1 from 1 to 9
    move 7 from 3 to 6
    move 3 from 9 to 2
    move 5 from 2 to 6
    move 1 from 9 to 3
    move 15 from 6 to 7
    move 6 from 6 to 7
    move 1 from 1 to 9
    move 5 from 6 to 2
    move 1 from 6 to 1
    move 6 from 5 to 8
    move 1 from 3 to 4
    move 1 from 9 to 7
    move 6 from 8 to 1
    move 3 from 4 to 6
    move 1 from 6 to 1
    move 3 from 5 to 2
    move 1 from 5 to 7
    move 5 from 1 to 5
    move 2 from 6 to 9
    move 2 from 9 to 2
    move 7 from 5 to 1
    move 1 from 5 to 7
    move 1 from 5 to 9
    move 20 from 7 to 1
    move 23 from 1 to 7
    move 1 from 1 to 2
    move 4 from 7 to 9
    move 4 from 9 to 8
    move 1 from 9 to 2
    move 16 from 7 to 6
    move 4 from 1 to 5
    move 9 from 7 to 6
    move 11 from 2 to 6
    move 1 from 1 to 9
    move 1 from 1 to 7
    move 1 from 8 to 2
    move 1 from 9 to 7
    move 4 from 5 to 2
    move 3 from 8 to 3
    move 2 from 2 to 4
    move 2 from 7 to 4
    move 4 from 4 to 9
    move 28 from 6 to 9
    move 5 from 2 to 7
    move 8 from 6 to 5
    move 6 from 2 to 6
    move 2 from 7 to 3
    move 5 from 5 to 7
    move 1 from 5 to 9
    move 14 from 9 to 4
    move 18 from 9 to 8
    move 5 from 6 to 4
    move 6 from 7 to 8
    move 1 from 2 to 6
    move 19 from 4 to 7
    move 1 from 2 to 5
    move 1 from 9 to 3
    move 2 from 5 to 2
    move 14 from 7 to 3
    move 1 from 5 to 3
    move 12 from 8 to 6
    move 6 from 6 to 5
    move 4 from 5 to 4
    move 21 from 3 to 4
    move 10 from 8 to 3
    move 2 from 3 to 2
    move 7 from 4 to 6
    move 2 from 8 to 1
    move 2 from 2 to 3
    move 5 from 7 to 2
    move 2 from 1 to 4
    move 3 from 3 to 7
    move 2 from 5 to 7
    move 2 from 2 to 7
    move 2 from 2 to 3
    move 7 from 4 to 1
    move 3 from 1 to 4
    move 3 from 2 to 5
    move 2 from 1 to 5
    move 7 from 4 to 3
    move 15 from 6 to 2
    move 1 from 1 to 4
    move 1 from 5 to 1
    move 14 from 3 to 1
    move 9 from 4 to 1
    move 5 from 7 to 1
    move 1 from 3 to 5
    move 1 from 4 to 2
    move 20 from 1 to 2
    move 17 from 2 to 5
    move 1 from 3 to 7
    move 5 from 7 to 3
    move 6 from 5 to 1
    move 3 from 3 to 2
    move 10 from 1 to 9
    move 3 from 5 to 6
    move 12 from 5 to 6
    move 1 from 5 to 1
    move 15 from 6 to 5
    move 13 from 5 to 3
    move 1 from 5 to 1
    move 10 from 3 to 2
    move 3 from 3 to 2
    move 1 from 5 to 3
    move 2 from 3 to 6
    move 1 from 3 to 4
    move 2 from 6 to 4
    move 3 from 4 to 2
    move 8 from 9 to 4
    move 8 from 4 to 8
    move 7 from 2 to 1
    move 5 from 8 to 7
    move 2 from 2 to 3
    move 13 from 1 to 2
    move 2 from 3 to 8
    move 2 from 9 to 7
    move 3 from 8 to 1
    move 2 from 1 to 2
    move 2 from 8 to 4
    move 6 from 7 to 2
    move 3 from 1 to 8
    move 1 from 7 to 5
    move 24 from 2 to 1
    move 2 from 8 to 5
    move 15 from 1 to 4
    move 1 from 5 to 8
    move 9 from 1 to 4
    move 2 from 8 to 5
    move 26 from 2 to 4
    move 1 from 5 to 8
    move 1 from 5 to 8
    move 50 from 4 to 1
    move 1 from 8 to 9
    move 1 from 4 to 6
    move 1 from 4 to 9
    move 22 from 1 to 5
    move 1 from 6 to 2
    move 1 from 5 to 8
    move 1 from 2 to 4
    move 1 from 8 to 1
    move 28 from 1 to 3
    move 2 from 9 to 4
    move 21 from 5 to 8
    move 1 from 1 to 8
    move 1 from 5 to 8
    move 1 from 5 to 7
    move 3 from 4 to 8
    move 1 from 7 to 9
    move 1 from 9 to 7
    move 20 from 8 to 4
    move 2 from 8 to 1
    move 1 from 7 to 6
    move 2 from 1 to 4
    move 27 from 3 to 1
    move 4 from 8 to 4
    move 1 from 6 to 9
    move 19 from 4 to 2
    move 5 from 2 to 5
    move 1 from 4 to 1
    move 1 from 9 to 2
    move 17 from 1 to 9
    move 1 from 3 to 8
    move 15 from 9 to 2
    move 2 from 4 to 8
    move 2 from 5 to 8
    move 2 from 5 to 9
    move 3 from 9 to 8
    move 9 from 1 to 2
    move 2 from 1 to 3
    move 4 from 4 to 5
    move 2 from 5 to 7
    move 1 from 8 to 5
    move 2 from 3 to 8
    move 4 from 5 to 2
    move 1 from 9 to 6
    move 5 from 8 to 5
    move 1 from 7 to 9
    move 29 from 2 to 3
    move 1 from 8 to 6
    move 1 from 9 to 7
    move 2 from 2 to 8
    move 2 from 5 to 2
    move 2 from 7 to 5
    move 4 from 5 to 9
    move 1 from 5 to 9
    move 10 from 3 to 4
    move 10 from 4 to 7
    move 1 from 3 to 4
    move 5 from 2 to 9
    move 5 from 8 to 6
    move 1 from 6 to 5
    move 2 from 6 to 3
    move 4 from 6 to 7
    move 1 from 5 to 2
    move 2 from 2 to 7
    move 5 from 7 to 8
    move 8 from 7 to 2
    move 6 from 8 to 7
    move 14 from 2 to 5
    move 3 from 7 to 3
    move 1 from 4 to 7
    move 2 from 7 to 2
    move 3 from 2 to 8
    move 3 from 8 to 5
    move 8 from 9 to 1
    move 3 from 7 to 2
    move 2 from 7 to 4
    move 17 from 3 to 6
    move 8 from 1 to 6
    move 16 from 5 to 2
    move 1 from 5 to 2
    move 1 from 3 to 1
    move 21 from 6 to 7
    move 1 from 4 to 8
    move 7 from 7 to 8
    move 1 from 1 to 3
    move 11 from 7 to 2
    move 7 from 2 to 6
    move 8 from 8 to 5
    move 2 from 7 to 4
    move 4 from 5 to 6
    move 8 from 2 to 8
    move 17 from 2 to 3
    move 4 from 5 to 3
    move 7 from 6 to 9
    move 2 from 6 to 9
    move 1 from 4 to 1
    move 1 from 4 to 2
    move 3 from 6 to 2
    move 1 from 6 to 8
    move 1 from 4 to 1
    move 1 from 7 to 5
    move 10 from 9 to 2
    move 1 from 5 to 6
    move 1 from 8 to 2
    move 1 from 1 to 4
    move 12 from 3 to 4
    move 1 from 6 to 2
    move 2 from 8 to 6
    move 1 from 1 to 2
    move 1 from 9 to 8
    move 2 from 8 to 7
    move 6 from 3 to 2
    move 1 from 3 to 5
    move 8 from 4 to 9
    move 22 from 2 to 9
    move 7 from 3 to 5
    move 3 from 8 to 2
    move 2 from 7 to 8
    move 3 from 6 to 9
    move 1 from 2 to 9
    move 1 from 6 to 2
    move 4 from 8 to 5
    move 5 from 5 to 9
    move 1 from 3 to 6
    move 1 from 5 to 6
    move 2 from 4 to 1
    move 2 from 2 to 4
    move 4 from 4 to 6
    move 1 from 1 to 5
    move 5 from 6 to 3
    move 35 from 9 to 1
    move 4 from 9 to 1
    move 1 from 4 to 7
    move 3 from 3 to 7
    move 37 from 1 to 7
    move 2 from 2 to 3
    move 3 from 3 to 7
    move 1 from 5 to 8
    move 2 from 1 to 8
    move 2 from 5 to 2
    move 1 from 6 to 9
    move 16 from 7 to 1
    move 5 from 1 to 5
    move 3 from 8 to 2
    move 10 from 7 to 9
    move 6 from 7 to 9
    move 3 from 2 to 1
    move 4 from 5 to 3
    move 2 from 1 to 2
    move 5 from 7 to 9
    move 5 from 7 to 9
    move 5 from 5 to 3
    move 8 from 3 to 7
    move 6 from 9 to 4
    move 8 from 7 to 3
    move 2 from 3 to 6
    move 1 from 6 to 7
    move 1 from 6 to 7
    move 5 from 4 to 9
    move 3 from 7 to 1
    move 2 from 2 to 8
    move 1 from 8 to 6
    move 6 from 1 to 8
    move 1 from 7 to 9
    move 1 from 3 to 9
    move 4 from 3 to 2
    move 8 from 1 to 6
    move 1 from 3 to 9
    move 5 from 8 to 4
    move 2 from 3 to 1
    move 1 from 8 to 2
    move 4 from 9 to 1
    move 2 from 1 to 5
    move 1 from 8 to 5
    move 11 from 9 to 5
    move 1 from 2 to 8
    move 10 from 5 to 4
    move 1 from 1 to 9
    move 3 from 5 to 4
    move 5 from 2 to 3
    move 1 from 5 to 1
    move 9 from 9 to 4
    move 1 from 6 to 7
    move 1 from 3 to 9
    move 4 from 3 to 1
    move 1 from 2 to 4
    move 1 from 1 to 4
    move 1 from 4 to 7
    move 5 from 1 to 3
    move 1 from 3 to 2
    move 1 from 8 to 3
    move 3 from 9 to 5
    move 1 from 2 to 9
    move 4 from 1 to 4
    move 1 from 7 to 4
    move 2 from 5 to 8
    move 1 from 7 to 6
    move 4 from 3 to 1
    move 1 from 5 to 8
    move 1 from 3 to 4
    move 22 from 4 to 1
    move 11 from 1 to 9
    move 2 from 1 to 4
    move 11 from 1 to 6
    move 8 from 6 to 7
    move 1 from 8 to 7
    move 7 from 9 to 2
    move 6 from 7 to 6
    move 2 from 4 to 9
    move 2 from 7 to 1
    move 14 from 6 to 3
    move 2 from 3 to 1
    move 3 from 6 to 7
    move 6 from 1 to 3
    move 8 from 9 to 6
    move 7 from 4 to 6
    move 7 from 6 to 8
    move 1 from 9 to 1
    move 2 from 9 to 8
    move 4 from 3 to 4
    move 1 from 8 to 4
    move 1 from 4 to 3
    move 6 from 3 to 7
    move 7 from 2 to 5
    move 8 from 4 to 6
    move 1 from 7 to 2
    move 1 from 5 to 7
    move 6 from 7 to 3
    move 1 from 7 to 1
    move 8 from 8 to 4
    move 8 from 4 to 2
    move 3 from 7 to 3
    move 6 from 5 to 6
    move 15 from 3 to 1
    move 21 from 6 to 1
    move 4 from 2 to 6
    move 5 from 6 to 5
    move 1 from 2 to 6
    move 1 from 4 to 5
    move 1 from 4 to 3
    move 1 from 8 to 6
    move 4 from 5 to 7
    move 18 from 1 to 4
    move 2 from 5 to 7
    move 6 from 7 to 6
    move 1 from 3 to 2
    move 6 from 1 to 2
    move 3 from 3 to 9
    move 3 from 9 to 4
    move 1 from 8 to 3
    move 1 from 6 to 5
    move 6 from 2 to 5
    move 1 from 5 to 9
    move 1 from 3 to 5
    move 2 from 6 to 8
    move 2 from 1 to 4
    move 5 from 4 to 6
    move 15 from 4 to 9
    move 5 from 9 to 1
    move 2 from 6 to 2
    move 6 from 6 to 3
    move 1 from 8 to 6
    move 6 from 5 to 9
    move 3 from 6 to 5
    move 2 from 4 to 7
    """
    
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
