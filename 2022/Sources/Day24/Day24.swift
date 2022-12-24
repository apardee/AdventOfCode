import Foundation
import Shared

enum Direction: Character, Hashable {
    case up = "^"
    case down = "v"
    case left = "<"
    case right = ">"
}

struct Position: Hashable {
    let x: Int
    let y: Int
    
    func stepping(direction: Direction) -> Position {
        switch direction {
        case .up: return Position(x: x, y: y - 1)
        case .down: return Position(x: x, y: y + 1)
        case .left: return Position(x: x - 1, y: y)
        case .right: return Position(x: x + 1, y: y)
        }
    }
}

struct BlizzardState {
    init(blizzards: [Blizzard], width: Int, height: Int) {
        self.blizzards = blizzards
        self.presence = Set(blizzards.map { $0.position })
        self.width = width
        self.height = height
    }
    let blizzards: [Blizzard]
    let presence: Set<Position>
    let width: Int
    let height: Int
    
    func isOpen(_ position: Position) -> Bool {
        return presence.contains(position) == false &&
            position.x >= 0 &&
            position.x < width &&
            position.y >= 0 &&
            position.y < height
    }
    
    var step: BlizzardState {
        return BlizzardState(
            blizzards: blizzards.map { $0.step(width: width, height: height) },
            width: width,
            height: height)
    }
}

struct Blizzard: Hashable {
    let direction: Direction
    let position: Position
    
    func step(width: Int, height: Int) -> Blizzard {
        let newPosition: Position
        switch direction {
        case .up:
            var y = position.y - 1
            if y < 0 {
                y = height - 1
            }
            newPosition = Position(x: position.x, y: y)
        case .down:
            var y = position.y + 1
            if y >= height {
                y = 0
            }
            newPosition = Position(x: position.x, y: y)
        case .left:
            var x = position.x - 1
            if x < 0 {
                x = width - 1
            }
            newPosition = Position(x: x, y: position.y)
        case .right:
            var x = position.x + 1
            if x >= width {
                x = 0
            }
            newPosition = Position(x: x, y: position.y)
        }
        return Blizzard(direction: direction, position: newPosition)
    }
}

struct State: Hashable {
    let position: Position
    let minute: Int
}

@main
struct Day24 {
    public static func main() {
        let lines = try! loadInput(bundle: .module, type: .personal).split(separator: "\n")
        
        let startX = Array(lines.first!).firstIndex(of: ".")! - 1
        let endX = Array(lines.last!).firstIndex(of: ".")! - 1
        
        var initialBlizzardPositions = [Blizzard]()
        let trimmedLines = lines[1..<lines.count - 1]
        for (rowIdx, line) in trimmedLines.enumerated() {
            for (colIdx, char) in Array(line)[1..<line.count - 1].enumerated() {
                if let direction = Direction(rawValue: char) {
                    initialBlizzardPositions.append(
                        Blizzard(
                            direction: direction,
                            position: Position(x: colIdx, y: rowIdx)))
                }
            }
        }
        
        let start = Position(x: startX, y: -1)
        let goal = Position(x: endX, y: lines.count - 2)
        let height = trimmedLines.count
        let width = trimmedLines.first!.count - 2
        
        solvePart1(initialBlizzardPositions: initialBlizzardPositions, start: start, goal: goal, width: width, height: height)
        solvePart2(initialBlizzardPositions: initialBlizzardPositions, start: start, goal: goal, width: width, height: height)
    }
    
    private static func solvePart1(initialBlizzardPositions: [Blizzard], start: Position, goal: Position, width: Int, height: Int) {
        var blizzardCache = [Int: BlizzardState]()
        blizzardCache[0] = BlizzardState(
            blizzards: initialBlizzardPositions,
            width: width,
            height: height)
        
        let startToGoal = shortest(
            fromPosition: start,
            toPosition: goal,
            firstMinute: 0,
            blizzardCache: &blizzardCache)
        
        print("part 1 (start -> goal): \(startToGoal!)")
    }
    
    private static func solvePart2(initialBlizzardPositions: [Blizzard], start: Position, goal: Position, width: Int, height: Int) {
        var blizzardCache = [Int: BlizzardState]()
        blizzardCache[0] = BlizzardState(
            blizzards: initialBlizzardPositions,
            width: width,
            height: height)
        
        let startToGoal = shortest(
            fromPosition: start,
            toPosition: goal,
            firstMinute: 0,
            blizzardCache: &blizzardCache)
        
        let goalToStart = shortest(
            fromPosition: goal,
            toPosition: start,
            firstMinute: startToGoal! + 1,
            blizzardCache: &blizzardCache)
        
        let startToGoalAgain = shortest(
            fromPosition: start,
            toPosition: goal,
            firstMinute: goalToStart! + 1,
            blizzardCache: &blizzardCache)
        
        print("part 2 (start -> goal -> start -> goal): \(startToGoalAgain!)")
    }
    
    private static func shortest(fromPosition initialPosition: Position,
                                 toPosition: Position,
                                 firstMinute: Int,
                                 blizzardCache: inout [Int: BlizzardState]) -> Int? {
        
        let state = State(position: initialPosition, minute: firstMinute)
        var stateQueue = [ state ]
        var statesSeen = Set<State>()
        
        while let nextState = stateQueue.popLast() {
            let position = nextState.position
            if position == toPosition {
                return nextState.minute
            }
            
            let nextBlizzardState: BlizzardState
            if let cachedBlizzardState = blizzardCache[nextState.minute + 1] {
                nextBlizzardState = cachedBlizzardState
            } else {
                nextBlizzardState = blizzardCache[nextState.minute]!.step
                blizzardCache[nextState.minute + 1] = nextBlizzardState
            }
            
            var nextPositions: [Position]
            if position.stepping(direction: .down) == toPosition {
                nextPositions = [ toPosition ]
            } else {
                nextPositions = [
                    position.stepping(direction: .down),
                    position.stepping(direction: .right),
                    position,
                    position.stepping(direction: .up),
                    position.stepping(direction: .left),
                ].filter { position in
                    nextBlizzardState.isOpen(position) ||
                    position == initialPosition ||
                    position == toPosition
                }
            }
            let nextStates = nextPositions.map {
                State(position: $0, minute: nextState.minute + 1)
            }.filter { state in
                statesSeen.contains(state) == false
            }
            statesSeen.formUnion(Set(nextStates))
            stateQueue.insert(contentsOf: nextStates, at: 0)
        }
        return nil
    }
}
