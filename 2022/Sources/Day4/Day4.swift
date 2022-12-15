import Foundation
import Shared

@main
public struct Day4 {
    
    public struct Range {
        let min: Int
        let max: Int
    }

    public static func main() {
        let elfRanges = readRanges()
        solvePart1(withElfRanges: elfRanges)
        solvePart2(withElfRanges: elfRanges)
    }
    
    private static func readRanges() -> [(elf1: Range, elf2: Range)] {
        let regex = #/(?<min1>\d+)-(?<max1>\d+),(?<min2>\d+)-(?<max2>\d+)/#
        let input = try! loadInput(bundle: Bundle.module)
        return input.split(separator: "\n").map { substr in
            let match = try! regex.wholeMatch(in: String(substr))!
            return (elf1: Range(min: Int(match.min1)!, max: Int(match.max1)!),
                    elf2: Range(min: Int(match.min2)!, max: Int(match.max2)!))
        }
    }
    
    private static func solvePart1(withElfRanges elfRanges: [(elf1: Range, elf2: Range)]) {
        let fullyOverlappingCount = elfRanges.map { range in
            (range.elf1.min >= range.elf2.min && range.elf1.max <= range.elf2.max) ||
            (range.elf2.min >= range.elf1.min && range.elf2.max <= range.elf1.max)
        }.reduce(0, { $0 + ($1 == true ? 1 : 0) })
        print("part1 (fully overlapping count): \(fullyOverlappingCount)")
    }
    
    private static func solvePart2(withElfRanges elfRanges: [(elf1: Range, elf2: Range)]) {
        let overlappingCount = elfRanges.map { range in
            (range.elf1.max < range.elf2.min || range.elf1.min > range.elf2.max) == false
        }.reduce(0, { $0 + ($1 == true ? 1 : 0) })
        print("part2 (partially overlapping count): \(overlappingCount)")
    }
}
