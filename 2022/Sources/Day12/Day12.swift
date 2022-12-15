import Foundation
import Shared

private struct Area {
    struct Coordinate: Hashable {
        let row: Int
        let column: Int
    }
    
    typealias Size = (rows: Int, columns: Int)
    
    let heightMap: [[Character]]
    
    var dimensions: Size {
        return (rows: heightMap.count,
                columns: heightMap[0].count)
    }
    
    var size: Int {
        dimensions.rows * dimensions.columns
    }
    
    func coordinate(forCharacter character: Character) -> Coordinate? {
        for (rowIdx, row) in heightMap.enumerated() {
            if let colIdx = row.firstIndex(of: character) {
                return Coordinate(row: rowIdx, column: colIdx)
            }
        }
        return nil
    }
    
    func shortestDistance(from startIdx: Coordinate, toValue targetValue: Character, isReverse: Bool = false) -> Int? {
        var shortest = [startIdx: 0]
        var visited = Set<Area.Coordinate>()
        while true {
            let (currentIdx, currentCost) = shortest
                .filter { visited.contains($0.0) == false }
                .min { $0.value < $1.value }!
            visited.insert(currentIdx)
            if value(at: currentIdx) == targetValue {
                return currentCost
            }
            let connected = traversableConnections(from: currentIdx, isReverse: isReverse)
            for connectedIdx in connected {
                if let prevShortest = shortest[connectedIdx], prevShortest <= currentCost + 1 {
                    continue
                }
                shortest[connectedIdx] = currentCost + 1
            }
        }
    }
    
    private func value(at idx: Coordinate) -> Character? {
        let dimensions = dimensions
        guard idx.row >= 0, idx.row < dimensions.rows,
              idx.column >= 0, idx.column < dimensions.columns else {
            return nil
        }
        return heightMap[idx.row][idx.column]
    }
    
    private func height(at idx: Coordinate) -> Int? {
        guard let value = value(at: idx) else { return nil }
        let heightChar: Character
        switch value {
        case "S": heightChar = "a"
        case "E": heightChar = "z"
        case (let char): heightChar = char
        }
        guard let char = heightChar.asciiValue,
              let a = ("a" as Character).asciiValue else {
            return nil
        }
        return Int(char - a)
    }
    
    private func traversableConnections(from idx: Coordinate, isReverse: Bool) -> [Coordinate] {
        return [
            destinationIfCanTraverse(from: idx, to: Coordinate(row: idx.row + 1, column: idx.column), isReverse: isReverse),
            destinationIfCanTraverse(from: idx, to: Coordinate(row: idx.row - 1, column: idx.column), isReverse: isReverse),
            destinationIfCanTraverse(from: idx, to: Coordinate(row: idx.row, column: idx.column + 1), isReverse: isReverse),
            destinationIfCanTraverse(from: idx, to: Coordinate(row: idx.row, column: idx.column - 1), isReverse: isReverse)
        ].compactMap { $0 }
    }
    
    private func destinationIfCanTraverse(from source: Coordinate,
                                          to destination: Coordinate,
                                          isReverse: Bool) -> Coordinate? {
        guard let sourceHeight = height(at: source),
              let destinationHeight = height(at: destination) else {
            return nil
        }
        return isReverse ?
            (sourceHeight - destinationHeight <= 1 ? destination : nil) :
            (destinationHeight - sourceHeight <= 1 ? destination : nil)
            
    }
}

@main
public struct Day12 {
    
    public static func main() {
        let input = try! loadInput(bundle: .module)
        let area = Area(heightMap: input
            .split(separator: "\n")
            .map { Array($0) })
        solvePart1(withArea: area)
        solvePart2(withArea: area)
    }
    
    private static func solvePart1(withArea area: Area) {
        guard let startIdx = area.coordinate(forCharacter: "S"),
              let shortestDistance = area.shortestDistance(from: startIdx, toValue: "E") else {
            fatalError("couldn't find start...")
        }
        print("part 1 (shortest start to end): \(shortestDistance)")
    }
    
    private static func solvePart2(withArea area: Area) {
        guard let startIdx = area.coordinate(forCharacter: "E"),
              let shortestFullPath = area.shortestDistance(from: startIdx,
                                                           toValue: "a",
                                                           isReverse: true) else {
            fatalError("couldn't find start...")
        }
        print("part 2 (shortest full path): \(shortestFullPath)")
    }
}
