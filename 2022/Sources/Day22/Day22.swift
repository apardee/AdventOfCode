import Foundation
import Shared

struct Position: Hashable {
    var x: Int
    var y: Int
    
    func stepping(direction: Direction) -> Position {
        switch direction {
        case .right: return Position(x: x + 1, y: y)
        case .left: return Position(x: x - 1, y: y)
        case .down: return Position(x: x, y: y + 1)
        case .up: return Position(x: x, y: y - 1)
        }
    }
}

struct Map {
    let rows: [Range<Int>]
    let blockers: Set<Position>
    
    func stepping(position: Position, direction: Direction) -> Position {
        var outPosition = position.stepping(direction: direction)
        
        if direction == .up && (outPosition.y < 0 || rows[outPosition.y].contains(outPosition.x) == false) {
            for (rowIdx, rowRange) in rows.enumerated().reversed() {
                if rowRange.contains(outPosition.x) {
                    outPosition.y = rowIdx
                    break
                }
            }
        } else if direction == .down && (outPosition.y >= rows.count || rows[outPosition.y].contains(outPosition.x) == false) {
            for (rowIdx, rowRange) in rows.enumerated() {
                if rowRange.contains(outPosition.x) {
                    outPosition.y = rowIdx
                    break
                }
            }
        }
        
        let row = rows[position.y]
        if direction == .left && outPosition.x < row.startIndex {
            outPosition.x = row.endIndex - 1
        } else if direction == .right && outPosition.x >= row.endIndex {
            outPosition.x = row.startIndex
        }
        
        if isOpen(position: outPosition) {
            return outPosition
        } else {
            return position
        }
    }
    
    func isOpen(position: Position) -> Bool {
        guard position.x >= 0, position.y >= 0 else { return false }
        guard position.y < rows.count else { return false }
        guard rows[position.y].contains(position.x) else { return false }
        return blockers.contains(position) == false
    }
    
    func dump(markingPositions positions: Set<Position>) {
        var boardString = ""
        for (rowIdx, range) in rows.enumerated() {
            for colIdx in 0..<range.endIndex {
                if blockers.contains(Position(x: colIdx, y: rowIdx)) {
                    boardString += "#"
                } else if positions.contains(Position(x: colIdx, y: rowIdx)) {
                    boardString += "x"
                } else if range.contains(colIdx) {
                    boardString += "."
                } else {
                    boardString += " "
                }
            }
            boardString += "\n"
        }
        print(boardString)
    }
}

struct Move {
    let turnDirection: Direction
    let distance: Int
}

enum Direction: Substring {
    case up = "U"
    case down = "D"
    case left = "L"
    case right = "R"
    
    var score: Int {
        switch self {
        case .up: return 3
        case .down: return 1
        case .left: return 2
        case .right: return 0
        }
    }
    
    func turning(direction: Direction) -> Direction {
        switch direction {
        case .left:
            return self.turningLeft
        case .right:
            return self.turningRight
        default:
            return self
        }
    }
    
    var turningLeft: Direction {
        switch self {
        case .up: return .left
        case .down: return .right
        case .left: return .down
        case .right: return .up
        }
    }
    
    var turningRight: Direction {
        switch self {
        case .up: return .right
        case .down: return .left
        case .left: return .up
        case .right: return .down
        }
    }
}

@main
struct Day22 {
    public static func main() throws {
        let input = try! loadInput(bundle: .module, type: .test).split(separator: "\n\n")
        let map = try parseMap(input: input[0])
        let (distances, directions) = try parseMoves(input: input[1])
        
//        solvePart1(map: map, distances: distances, directions: directions)
        solvePart2(map: map, distances: distances, directions: directions)
    }
    
    private static func solvePart1(map: Map, distances: [Int], directions: [Direction]) {
        var currDirection = Direction.right
        var currPosition = Position(x: map.rows[0].startIndex, y: 0)
        for (idx, distance) in distances.enumerated() {
//            var seen = Set<Position>([ currPosition ])
//            print("starting: \(currPosition.y + 1), \(currPosition.x + 1) - facing: \(currDirection) - stepping: \(distance)")
//            print("starting: \(currPosition.y + 1) \(currPosition.x + 1)")
//            print("\tblockers in this row: \(map.blockers.filter { $0.y == currPosition.y })")
            
            for _ in 0..<distance {
                let prevPosition = currPosition
//                print("\tstart: \(prevPosition)")
                currPosition = map.stepping(
                    position: currPosition,
                    direction: currDirection)
//                print("\tend: \(currPosition)")
//                seen.insert(currPosition)
                if prevPosition == currPosition {
                    break
                }
            }
//            map.dump(markingPositions: seen)
//            print("ending: (\(currPosition.x + 1), \(currPosition.y + 1))")
            if idx < directions.count {
//                print("turning: \(directions[idx] == .left ? "L": "R")")
                currDirection = currDirection.turning(direction: directions[idx])
            }
        }
        print("\(1000 * (currPosition.y + 1) + 4 * (currPosition.x + 1) + currDirection.score)")
    }
    
    private static func solvePart2(map: Map, distances: [Int], directions: [Direction]) {
        let rowCount = map.rows.count
        let colCount = map.rows.reduce(0) { max($0, $1.endIndex) }
        print(max(rowCount, colCount) / 4)
    }
    
    private static func parseMap(input: Substring) throws -> Map {
        var rows = [Range<Int>]()
        var blockers = Set<Position>()
        for (rowIdx, line) in input.split(separator: "\n").enumerated() {
            var rowStartIdx: Int? = nil
            for (colIdx, char) in line.enumerated() {
                switch char {
                case "#":
                    blockers.insert(Position(x: colIdx, y: rowIdx))
                    rowStartIdx = rowStartIdx ?? colIdx
                case ".":
                    rowStartIdx = rowStartIdx ?? colIdx
                default:
                    break
                }
            }
            rows.append(rowStartIdx!..<line.count)
        }
        return Map(rows: rows, blockers: blockers)
    }
    
    private static func parseMoves(input: Substring) throws -> (distances: [Int], turns: [Direction])  {
        let distance = #/(?<distance>\d+)/#
        let direction = #/(?<direction>[R|L])/#
        
        var distances = [Int]()
        var turns = [Direction]()
        var input = input
        while true {
            guard let distanceMatch = try distance.prefixMatch(in: input) else {
                return (distances: distances, turns: turns)
            }
            distances.append(Int(distanceMatch.distance)!)
            input = input[distanceMatch.range.upperBound...]
            
            guard let directionMatch = try direction.prefixMatch(in: input) else {
                return (distances: distances, turns: turns)
            }
            turns.append(Direction(rawValue: directionMatch.direction)!)
            input = input[directionMatch.range.upperBound...]
        }
    }
}
