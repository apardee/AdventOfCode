import Foundation
import Shared

struct Position: Hashable {
    let x: Int
    let y: Int
    
    var down: Position {
        return Position(x: x, y: y + 1)
    }
    
    var left: Position {
        return Position(x: x - 1, y: y)
    }
    
    var right: Position {
        return Position(x: x + 1, y: y)
    }
}

@main
struct Day14 {
    
    public static func main() {
        
        let input = try! loadInput(bundle: .module)
        let positionGroups = input.split(separator: "\n")
            .map { input in
                input.split(separator: " -> ").map { coordinateString in
                    let values = String(coordinateString)
                        .split(separator: ",")
                        .compactMap { Int($0) }
                    return Position(x: values[0], y: values[1])
                }
            }
        
        var initialPositions = Set<Position>()
        for positionGroup in positionGroups {
            for idx in 1..<positionGroup.count {
                let from = positionGroup[idx - 1]
                let to = positionGroup[idx]
                if from.x != to.x {
                    let lower = min(from.x, to.x)
                    let upper = max(from.x, to.x)
                    for currX in lower...upper {
                        initialPositions.insert(Position(x: currX, y: from.y))
                    }
                } else {
                    let lower = min(from.y, to.y)
                    let upper = max(from.y, to.y)
                    for currY in lower...upper {
                        initialPositions.insert(Position(x: from.x, y: currY))
                    }
                }
            }
        }
        solvePart1(initialPositions: initialPositions)
        solvePart2(initialPositions: initialPositions)
    }
    
    private static func solvePart1(initialPositions: Set<Position>) {
        var objectsPresent = initialPositions
        let maxY = objectsPresent.map { $0.y }.max() ?? 0
        var dropCount = 0
        
        allDrops: while true {
            var position = Position(x: 500, y: 0)
            currDrop: while true {
                if position.y >= maxY {
                    break allDrops
                }
                if !objectsPresent.contains(position.down) {
                    position = position.down
                } else if !objectsPresent.contains(position.down.left) {
                    position = position.down.left
                } else if !objectsPresent.contains(position.down.right) {
                    position = position.down.right
                } else {
                    objectsPresent.insert(position)
                    dropCount += 1
                    break currDrop
                }
            }
        }
        print("part 1 (first falling): \(dropCount)")
    }
    
    private static func solvePart2(initialPositions: Set<Position>) {
        var objectsPresent = initialPositions
        let maxY = objectsPresent.map { $0.y }.max() ?? 0
        var dropCount = 0
        
        let startPosition = Position(x: 500, y: 0)
        allDrops: while true {
            var position = startPosition
            if objectsPresent.contains(startPosition) {
                break allDrops
            }
            currDrop: while true {
                if position.y >= maxY + 1 {
                    objectsPresent.insert(position)
                    dropCount += 1
                    break currDrop
                } else if !objectsPresent.contains(position.down) {
                    position = position.down
                } else if !objectsPresent.contains(position.down.left) {
                    position = position.down.left
                } else if !objectsPresent.contains(position.down.right) {
                    position = position.down.right
                } else {
                    objectsPresent.insert(position)
                    dropCount += 1
                    break currDrop
                }
            }
        }
        print("part 2 (until stuck): \(dropCount)")
    }
}
