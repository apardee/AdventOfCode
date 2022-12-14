import Foundation

@main
public struct Day1 {
    
//    private static let input: String!
    
    public static func main() {
        solvePart1()
        solvePart2()
    }
    
    private static func getCalorieTotals() -> [Int] {
        let path = Bundle.module.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: path)
        
        // Parse and split up the input in an array for each elf.
        let elfCals = input
            .split(separator: "\n\n")
            .map { $0.split(separator: "\n") }
            .map { $0.compactMap { Int($0) } }
            
        
        // Total up the calories for each.
        return elfCals.map { $0.reduce(0, { $0 + $1 }) }
    }
    
    private static func solvePart1() {
        let totals = getCalorieTotals()
        
        // Find max
        guard let maxCals = totals.max() else {
            fatalError("couldn't find max value")
        }
        
        print("maximum calories: \(maxCals)")
    }
    
    private static func solvePart2() {
        let totals = getCalorieTotals()
        
        let sum = totals.sorted { $0 > $1 }[0..<3]
            .reduce(0, { $0 + $1 })
        
        print("top 3 total: \(sum)")
    }
}
