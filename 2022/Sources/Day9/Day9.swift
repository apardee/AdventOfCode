import Foundation
import Shared

extension Int {
    func clamped(min: Int, max: Int) -> Int {
        guard self > min else { return min }
        guard self < max else { return max }
        return self
    }
}

enum MoveDirection: String {
    case up = "U"
    case down = "D"
    case right = "R"
    case left = "L"
}

struct Position: Hashable {
    let x: Int
    let y: Int
    
    func moving(direction: MoveDirection) -> Position {
        let newPosition: Position
        switch direction {
        case .up: newPosition = Position(x: x, y: y + 1)
        case .down: newPosition = Position(x: x, y: y - 1)
        case .right: newPosition = Position(x: x + 1, y: y)
        case .left: newPosition = Position(x: x - 1, y: y)
        }
        return newPosition
    }
    
    func following(position other: Position) -> Position {
        let xDiff = other.x - x
        let yDiff = other.y - y
        if abs(xDiff) <= 1 && abs(yDiff) <= 1 {
            return self
        }
        return Position(x: x + xDiff.clamped(min: -1, max: 1),
                        y: y + yDiff.clamped(min: -1, max: 1))
    }
    
    static var origin: Position { Position(x: 0, y: 0) }
}

@main
public struct Day9 {
    
    public static func main() {
        let moveRegEx = #/(?<move>.+) (?<distance>\d+)/#
        let input = try! loadInput(bundle: Bundle.module)
        let moves = input.split(separator: "\n")
            .map { line in
                let match = try! moveRegEx.wholeMatch(in: String(line))!
                return (MoveDirection(rawValue: String(match.move))!, Int(match.distance)!)
            }
        solvePart1(moves: moves)
        solvePart2(moves: moves)
    }
    
    private static func solvePart1(moves: [(direction: MoveDirection, distance: Int)]) {
        var headPosition: Position = .origin
        var tailPosition: Position = .origin
        var tailVisited = Set<Position>([tailPosition])
        
        for (direction, distance) in moves {
            for _ in 0..<distance {
                headPosition = headPosition.moving(direction: direction)
                tailPosition = tailPosition.following(position: headPosition)
                tailVisited.insert(tailPosition)
            }
        }
        print("visited: \(tailVisited.count)")
    }
    
    private static func solvePart2(moves: [(direction: MoveDirection, distance: Int)]) {
        var headPosition: Position = .origin
        var tailPositions = [Position](repeating: .origin, count: 9)
        var tailVisited = Set<Position>([.origin])
        
        for (direction, distance) in moves {
            for _ in 0..<distance {
                headPosition = headPosition.moving(direction: direction)
                tailPositions[0] = tailPositions[0].following(position: headPosition)
                for i in 1..<tailPositions.count {
                    tailPositions[i] = tailPositions[i].following(position: tailPositions[i - 1])
                }
                tailVisited.insert(tailPositions.last!)
            }
        }
        print("last tail visited: \(tailVisited.count)")
    }
}
