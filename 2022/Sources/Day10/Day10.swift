import Foundation
import Shared

enum Instruction {
    enum ParseError: Error {
        case unrecognized
    }
    
    case addx(Int)
    case noop
    
    var cycleCount: Int {
        switch self {
        case .addx:
            return 2
        case .noop:
            return 1
        }
    }
    
    static func from(string: String) throws -> Instruction {
        if let match = try addRegex.wholeMatch(in: string),
           let value = Int(match.value) {
            return .addx(value)
        } else if let _ = try noopRegex.wholeMatch(in: string) {
            return .noop
        } else {
            throw ParseError.unrecognized
        }
    }
    
    private static let addRegex = #/addx (?<value>.+)/#
    private static let noopRegex = #/noop/#
}

struct RegisterState {
    var x: Int = 1
    
    func spriteContains(index: Int) -> Bool {
        (x..<x+3).contains(index)
    }
    
    mutating func execute(instruction: Instruction) {
        switch instruction {
        case .addx(let xval):
            x += xval
        case .noop:
            break
        }
    }
}

@main
public struct Day10 {
    
    public static func main() {
        let input = try! loadInput(bundle: .module)
        let instructions = input.split(separator: "\n")
            .compactMap { try? Instruction.from(string: String($0)) }
        
        solvePart1(instructions: instructions)
        solvePart2(instructions: instructions)
    }
    
    private static func solvePart1(instructions: [Instruction]) {
        var cycle = 0
        var accum = 0
        var registerState = RegisterState()
        for instruction in instructions {
            let cycleCount = instruction.cycleCount
            for _ in 1...cycleCount {
                cycle += 1
                let shouldCount = (cycle - 20) % 40 == 0
                if shouldCount {
                    accum += cycle * registerState.x
                }
            }
            registerState.execute(instruction: instruction)
        }
        print("part 1 (accum): \(accum)")
    }
    
    private static func solvePart2(instructions: [Instruction]) {
        var pixelsLit = [Bool](repeating: false, count: 240)
        var cycle = 0
        var registerState = RegisterState()
        for instruction in instructions {
            let cycleCount = instruction.cycleCount
            for _ in 1...cycleCount {
                cycle += 1
                let pixelIsLit = registerState.spriteContains(index: cycle % 40)
                pixelsLit[cycle - 1] = pixelIsLit
            }
            registerState.execute(instruction: instruction)
        }
        
        print("part 2:")
        var outputString = ""
        for i in 0..<pixelsLit.count {
            if i != 0, i % 40 == 0 {
                outputString += "\n"
            }
            outputString += pixelsLit[i] ? "#" : "."
        }
        print(outputString)
    }
}
