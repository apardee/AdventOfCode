import Foundation
import Shared

struct Position: Hashable {
    let x: Int
    let y: Int
    let z: Int
    
    var adjacent: Set<Position> {
        return Set([
            Position(x: x + 1, y: y, z: z),
            Position(x: x - 1, y: y, z: z),
            Position(x: x, y: y + 1, z: z),
            Position(x: x, y: y - 1, z: z),
            Position(x: x, y: y, z: z + 1),
            Position(x: x, y: y, z: z - 1),
        ])
    }
}

@main
struct Day18 {
    public static func main() {
        let regex = #/(?<x>.+),(?<y>.+),(?<z>.+)/#
        let positions = try! loadInput(bundle: .module, type: .personal)
            .split(separator: "\n")
            .map { matchString in
                let (_, x, y, z) = try regex.wholeMatch(in: String(matchString))!.output
                return Position(x: Int(x)!, y: Int(y)!, z: Int(z)!)
            }
        solvePart1(positions: positions)
        solvePart2(positions: positions)
    }
    
    private static func solvePart1(positions: [Position]) {
        let cubePositions = Set(positions)
        var uncoveredFaceCount = 0
        for position in positions {
            uncoveredFaceCount += position.adjacent.subtracting(cubePositions).count
        }
        print("part1 (uncovered): \(uncoveredFaceCount)")
    }
    
    private static func solvePart2(positions: [Position]) {
        let cubePositions = Set(positions)
        
        let xs = positions.map { $0.x }
        let ys = positions.map { $0.y }
        let zs = positions.map { $0.z }
        
        let rangeX = (xs.min()! - 1)...(xs.max()! + 1)
        let rangeY = (ys.min()! - 1)...(ys.max()! + 1)
        let rangeZ = (zs.min()! - 1)...(zs.max()! + 1)
        
        let startPosition = Position(
            x: rangeX.min()!,
            y: rangeY.min()!,
            z: rangeZ.min()!)
        
        var exposed = Set<Position>([ startPosition ])
        var stack = [ startPosition ]
        while let next = stack.popLast() {
            guard rangeX.contains(next.x) else { continue }
            guard rangeY.contains(next.y) else { continue }
            guard rangeZ.contains(next.z) else { continue }
            
            for adjacent in next.adjacent {
                if exposed.contains(adjacent) == false && cubePositions.contains(adjacent) == false {
                    stack.insert(adjacent, at: 0)
                    exposed.insert(adjacent)
                }
            }
        }
        
        var uncoveredFaceCount = 0
        for position in positions {
            uncoveredFaceCount += position.adjacent.intersection(exposed).count
        }
        print("part2 (uncovered): \(uncoveredFaceCount)")
    }
}
