import Foundation
import Shared

@main
public struct Day8 {
    
    public static func main() {
        let input = try! loadInput(bundle: Bundle.module)
        let treeHeights = input.split(separator: "\n")
            .map { row in
                row.map { char in
                    Int(String(char))!
                }
            }
        
        solvePart1(treeHeights: treeHeights)
        solvePart2(treeHeights: treeHeights)
    }
    
    private static func solvePart1(treeHeights: [[Int]]) {

        
        let colCount = treeHeights[0].count
        let rowCount = treeHeights.count
        
        var maxLeft = treeHeights
        for rowIdx in 0..<treeHeights.count {
            let row = treeHeights[rowIdx]
            var value = row[0]
            for colIdx in 1..<row.count {
                maxLeft[rowIdx][colIdx] = value
                value = max(value, treeHeights[rowIdx][colIdx])
            }
        }

        var maxRight = treeHeights
        for rowIdx in 0..<treeHeights.count {
            let row = treeHeights[rowIdx]
            var value = row[row.count - 1]
            for colIdx in (0..<row.count - 1).reversed() {
                maxRight[rowIdx][colIdx] = value
                value = max(value, treeHeights[rowIdx][colIdx])
            }
        }

        var maxAbove = treeHeights
        for colIdx in 0..<colCount {
            var value = treeHeights[0][colIdx]
            for rowIdx in 1..<treeHeights.count {
                maxAbove[rowIdx][colIdx] = value
                value = max(value, treeHeights[rowIdx][colIdx])
            }
        }

        var maxBelow = treeHeights
        for colIdx in 0..<colCount {
            var value = treeHeights[treeHeights.count - 1][colIdx]
            for rowIdx in (0..<treeHeights.count - 1).reversed() {
                maxBelow[rowIdx][colIdx] = value
                value = max(value, treeHeights[rowIdx][colIdx])
            }
        }
        
        var visibleCount = rowCount * 2 + colCount * 2 - 4
        for rowIdx in 1..<rowCount - 1 {
            for colIdx in 1..<colCount - 1 {
                let value = treeHeights[rowIdx][colIdx]
                if value > min(maxRight[rowIdx][colIdx],
                               maxLeft[rowIdx][colIdx],
                               maxAbove[rowIdx][colIdx],
                               maxBelow[rowIdx][colIdx]) {
                    visibleCount += 1
                }
            }
        }
        print("part 1 (visible count): \(visibleCount)")
    }
    
    private static func solvePart2(treeHeights: [[Int]]) {
        let colCount = treeHeights[0].count
        let rowCount = treeHeights.count
        
        var maxValue = 0
        for rowIdx in 1..<rowCount - 1 {
            for colIdx in 1..<colCount - 1 {
                
                let value = treeHeights[rowIdx][colIdx]
                
                // Look left
                var leftCount = 0
                for lookColIdx in (0..<colIdx).reversed() {
                    leftCount += 1
                    if treeHeights[rowIdx][lookColIdx] >= value {
                        break
                    }
                }
                
                // Look right
                var rightCount = 0
                for lookColIdx in (colIdx + 1)..<colCount {
                    rightCount += 1
                    if treeHeights[rowIdx][lookColIdx] >= value {
                        break
                    }
                }
                
                // Look up
                var aboveCount = 0
                for lookRowIdx in (0..<rowIdx).reversed() {
                    aboveCount += 1
                    if treeHeights[lookRowIdx][colIdx] >= value {
                        break
                    }
                }
                
                // Look down
                var belowCount = 0
                for lookRowIdx in (rowIdx + 1)..<rowCount {
                    belowCount += 1
                    if treeHeights[lookRowIdx][colIdx] >= value {
                        break
                    }
                }
                
                maxValue = max(maxValue, leftCount * rightCount * aboveCount * belowCount)
            }
        }
        print("part 2 (tree cover): \(maxValue)")
    }
}
