import Foundation
import Shared

struct Range {
    let start: Int
    let size: Int
}

struct Position: Hashable {
    let x: Int
    let y: Int
    
    var left: Position {
        Position(x: x - 1, y: y)
    }
    
    var right: Position {
        Position(x: x + 1, y: y)
    }
    
    func distance(to: Position) -> Int {
        abs(to.y - y) + abs(to.x - x)
    }
}

@main
struct Day15 {
    
    private static let inputType: InputType = .personal
    
    public static func main() {
        let input = try! loadInput(bundle: .module, type: inputType)
        
        let regex = #/Sensor at x=(?<sensorX>.+), y=(?<sensorY>.+): closest beacon is at x=(?<beaconX>.+), y=(?<beaconY>.+)/#
        let sensorProximities = input.split(separator: "\n")
            .map { input in
                let match = try! regex.wholeMatch(in: String(input))!
                return (sensor: Position(x: Int(match.sensorX)!, y: Int(match.sensorY)!),
                        closestBeacon: Position(x: Int(match.beaconX)!, y: Int(match.beaconY)!))
             }
        solvePart1(sensorProximities: sensorProximities)
        solvePart2(sensorProximities: sensorProximities)
    }
    
    private static func solvePart1(sensorProximities: [(sensor: Position, closestBeacon: Position)]) {
        var unavailable = Set<Position>()
        var knownBeacons = Set<Position>()
        for sensorProximity in sensorProximities {
            let sensor = sensorProximity.sensor
            let beacon = sensorProximity.closestBeacon
            let distance = sensor.distance(to: beacon)
            knownBeacons.insert(beacon)

            let start = Position(x: sensor.x,
                                 y: inputType == .test ? 10 : 2000000)
            var left = start
            var right = start
            while left.distance(to: sensor) <= distance {
                unavailable.insert(left)
                unavailable.insert(right)
                left = left.left
                right = right.right
            }
        }
        unavailable = unavailable.subtracting(knownBeacons)
        
        print("part 1 (coverage): \(unavailable.count)")
    }
    
    private static func solvePart2(sensorProximities: [(sensor: Position, closestBeacon: Position)]) {
        let sensorProximities = sensorProximities.map { (sensor, beacon) in
            return (sensor: sensor,
                    closestBeacon: beacon,
                    distance: sensor.distance(to: beacon))
        }
        
        let endPoint = inputType == .test ? 20 : 4000000
        let beaconPositions = Set(sensorProximities.map { $0.closestBeacon })
        
        for y in 0...endPoint {
            var unavailable = [Range]()
            for sensorProximity in sensorProximities {
                let sensor = sensorProximity.sensor
                let distance = sensorProximity.distance
                let offset = abs(sensor.y - y)
                let initialCovered = (distance * 2) + 1
                let covered = initialCovered - (offset * 2)
                let coveredRange = Range(start: sensor.x - (covered / 2), size: covered)
                if covered > 0 {
                    unavailable.append(coveredRange)
                }
            }
            
            let sorted = unavailable.sorted { $0.start < $1.start }
            var maxX: Int? = nil
            for range in sorted {
                if let actualMaxX = maxX {
                    if range.start > actualMaxX {
                        let candidatePosition = Position(x: range.start - 1, y: y)
                        if !beaconPositions.contains(candidatePosition) {
                            print("part 2 (signal): \(candidatePosition.x * 4000000 + candidatePosition.y)")
                            return
                        }
                    }
                    maxX = max(actualMaxX, range.size + range.start)
                } else {
                    maxX = range.size + range.start
                }
                if let maxX, maxX >= endPoint {
                    break
                }
            }
        }
        print("couldn't find an available space!")
    }
}
