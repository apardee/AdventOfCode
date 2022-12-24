import Foundation
import Shared

enum Direction {
    case north
    case south
    case east
    case west
}

struct Position: Hashable {
    var x: Int
    var y: Int
    
    var north: Position { Position(x: x, y: y - 1) }
    var south: Position { Position(x: x, y: y + 1) }
    var east: Position { Position(x: x + 1, y: y) }
    var west: Position { Position(x: x - 1, y: y) }
    
    var northEast: Position { north.east }
    var northWest: Position { north.west }
    var southEast: Position { south.east }
    var southWest: Position { south.west }
    
    func shouldMove(withOccupied occupied: Set<Position>) -> Bool {
        return occupied.contains(north) ||
               occupied.contains(south) ||
               occupied.contains(west) ||
               occupied.contains(east) ||
               occupied.contains(northEast) ||
               occupied.contains(northWest) ||
               occupied.contains(southEast) ||
               occupied.contains(southWest)
    }
    
    func moving(direction: Direction, withOccupied occupied: Set<Position>) -> Position? {
        switch direction {
        case .north:
            if occupied.contains(north) == false &&
                occupied.contains(northEast) == false &&
                occupied.contains(northWest) == false {
                return north
            }
        case .south:
            if occupied.contains(south) == false &&
                occupied.contains(southEast) == false &&
                occupied.contains(southWest) == false {
                return south
            }
        case .east:
            if occupied.contains(east) == false &&
                occupied.contains(northEast) == false &&
                occupied.contains(southEast) == false {
                return east
            }
        case .west:
            if occupied.contains(west) == false &&
                occupied.contains(northWest) == false &&
                occupied.contains(southWest) == false {
                return west
            }
        }
        return nil
    }
}

@main
struct Day23 {
    public static func main() {
        let input = try! loadInput(bundle: .module, type: .personal)
        let lines = input.split(separator: "\n")
        
        var originalElfPositions = [Position]()
        for (rowIdx, line) in lines.enumerated() {
            for (colIdx, char) in line.enumerated() {
                if char == "#" {
                    originalElfPositions.append(Position(x: colIdx, y: rowIdx))
                }
            }
        }
        solvePart1(originalElfPositions: originalElfPositions)
        solvePart2(originalElfPositions: originalElfPositions)
    }
    
    private static func solvePart1(originalElfPositions: [Position]) {
        var elfPositions = originalElfPositions
        var directionsConsidered: [Direction] = [ .north, .south, .west, .east ]
        for _ in 0..<10 {
            var proposedElfPositions = [Position]()
            let elfPositionLookup = Set(elfPositions)
            for elfPosition in elfPositions {
                var newPosition: Position? = nil
                if elfPosition.shouldMove(withOccupied: elfPositionLookup) {
                    for direction in directionsConsidered {
                        if let movedPosition = elfPosition.moving(direction: direction, withOccupied: elfPositionLookup) {
                            newPosition = movedPosition
                            break
                        }
                    }
                }
                proposedElfPositions.append(newPosition ?? elfPosition)
            }

            var proposedPositionCounts = [Position:Int]()
            for position in proposedElfPositions {
                proposedPositionCounts[position] = (proposedPositionCounts[position] ?? 0) + 1
            }

            var updatedPositions = [Position]()
            for i in 0..<proposedElfPositions.count {
                let previousPosition = elfPositions[i]
                let proposedPosition = proposedElfPositions[i]
                let proposedPositionCount = proposedPositionCounts[proposedPosition] ?? 0
                if proposedPositionCount > 1 {
                    updatedPositions.append(previousPosition)
                } else {
                    updatedPositions.append(proposedPosition)
                }
            }
            elfPositions = updatedPositions

            let first = directionsConsidered.first!
            directionsConsidered.remove(at: 0)
            directionsConsidered.append(first)
        }

        var mins = Position(x: .max, y: .max)
        var maxs = Position(x: .min, y: .min)
        for elfPosition in elfPositions {
            mins.x = min(elfPosition.x, mins.x)
            mins.y = min(elfPosition.y, mins.y)
            maxs.x = max(elfPosition.x, maxs.x)
            maxs.y = max(elfPosition.y, maxs.y)
        }

        let openAreas = (maxs.y - mins.y + 1) * (maxs.x - mins.x + 1) - elfPositions.count
        print("part 1: \(openAreas)")
    }
    
    private static func solvePart2(originalElfPositions: [Position]) {
        var elfPositions = originalElfPositions
        var directionsConsidered: [Direction] = [ .north, .south, .west, .east ]
        var round = 1
        while true {
            var proposedElfPositions = [Position]()
            let elfPositionLookup = Set(elfPositions)
            for elfPosition in elfPositions {
                var newPosition: Position? = nil
                if elfPosition.shouldMove(withOccupied: elfPositionLookup) {
                    for direction in directionsConsidered {
                        if let movedPosition = elfPosition.moving(direction: direction, withOccupied: elfPositionLookup) {
                            newPosition = movedPosition
                            break
                        }
                    }
                }
                proposedElfPositions.append(newPosition ?? elfPosition)
            }
            
            var proposedPositionCounts = [Position:Int]()
            for position in proposedElfPositions {
                proposedPositionCounts[position] = (proposedPositionCounts[position] ?? 0) + 1
            }
            
            var anyMoved = false
            var updatedPositions = [Position]()
            for i in 0..<proposedElfPositions.count {
                let previousPosition = elfPositions[i]
                let proposedPosition = proposedElfPositions[i]
                let proposedPositionCount = proposedPositionCounts[proposedPosition] ?? 0
                if proposedPositionCount > 1 {
                    updatedPositions.append(previousPosition)
                } else {
                    if proposedPosition != previousPosition {
                        anyMoved = true
                    }
                    updatedPositions.append(proposedPosition)
                }
            }
            
            if anyMoved == false {
                break
            }
            elfPositions = updatedPositions
            
            let first = directionsConsidered.first!
            directionsConsidered.remove(at: 0)
            directionsConsidered.append(first)
            round += 1
        }
        print("part 2 (first non-moving round): \(round)")
    }
    
    private static func dump(positions: Set<Position>) {
        var mins = Position(x: .max, y: .max)
        var maxs = Position(x: .min, y: .min)
        for elfPosition in positions {
            mins.x = min(elfPosition.x, mins.x)
            mins.y = min(elfPosition.y, mins.y)
            maxs.x = max(elfPosition.x, maxs.x)
            maxs.y = max(elfPosition.y, maxs.y)
        }
        
        var output = ""
        for yIdx in mins.y...maxs.y {
            for xIdx in mins.x...maxs.x {
                if positions.contains(Position(x: xIdx, y: yIdx)) {
                    output += "#"
                } else {
                    output += "."
                }
            }
            output += "\n"
        }
        print(output)
    }
}
