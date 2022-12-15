import Foundation
import Shared

struct Monkey {
    enum Operation: String {
        case mul = "*"
        case add = "+"
    }
    
    enum Operand {
        case old
        case number(Int)
        
        static func fromString(_ string: String) throws -> Operand {
            if let _ = try #/old/#.wholeMatch(in: string) {
                return .old
            } else if let (_, numString) = try #/(\d+)/#.wholeMatch(in: string)?.output,
                      let num = Int(numString) {
                return .number(num)
            }
            throw ParseError.failed
        }
    }
    
    func applyOperation(toValue value: Int) -> Int {
        let operand1 = value
        let operand2: Int
        switch operand {
        case .old:
            operand2 = value
        case .number(let number):
            operand2 = number
        }
        
        switch operation {
        case .add:
            return operand1 + operand2
        case .mul:
            return operand1 * operand2
        }
    }
    
    func targetMonkey(forValue value: Int) -> Int {
        return value % testDivisor == 0 ? trueTarget : falseTarget
    }
    
    let index: Int
    let operation: Operation
    let operand: Operand
    let testDivisor: Int
    let trueTarget: Int
    let falseTarget: Int
    
    var items: [Int]
    var evaluations = 0
}

enum ParseError: Error {
    case failed
}

@main
public struct Day11 {
    
    public static func main() throws {
        let input = try loadInput(bundle: .module)
        let monkeys = try input.split(separator: "\n\n")
            .map { try parseMonkey(input: $0) }
        solvePart1(monkeys: monkeys)
        solvePart2(monkeys: monkeys)
    }
    
    private static func solvePart1(monkeys input: [Monkey]) {
        var monkeys = input
        for _ in 0..<20 {
            for i in 0..<monkeys.count {
                let items = monkeys[i].items
                monkeys[i].items = []
                for itemValue in items {
                    monkeys[i].evaluations += 1
                    let updatedValue = monkeys[i].applyOperation(toValue: itemValue) / 3
                    let targetMonkeyIdx = monkeys[i].targetMonkey(forValue: updatedValue)
                    monkeys[targetMonkeyIdx].items.append(updatedValue)
                }
            }
        }
        
        let top = monkeys.sorted {
            $0.evaluations > $1.evaluations
        }
        print("part 1: \(top[0].evaluations * top[1].evaluations)")
    }
    
    private static func solvePart2(monkeys input: [Monkey]) {
        var monkeys = input
        let product = monkeys
            .map { $0.testDivisor }
            .reduce(1, *)
        
        for _ in 0..<10000 {
            for i in 0..<monkeys.count {
                let items = monkeys[i].items
                monkeys[i].items = []
                for itemValue in items {
                    monkeys[i].evaluations += 1
                    let updatedValue = monkeys[i].applyOperation(toValue: itemValue) % product
                    let targetMonkeyIdx = monkeys[i].targetMonkey(forValue: updatedValue)
                    monkeys[targetMonkeyIdx].items.append(updatedValue)
                }
            }
        }
        
        let top = monkeys.sorted {
            $0.evaluations > $1.evaluations
        }
        print("part 2: \(top[0].evaluations * top[1].evaluations)")
    }
    
    private static func parseMonkey(input: any StringProtocol) throws -> Monkey {
        let lines = input.split(separator: "\n").map { String($0) }
        let (op, operand) = try parseOperator(input: lines[2])
        return Monkey(index: try parseMonkeyIndex(input: lines[0]),
                      operation: op,
                      operand: operand,
                      testDivisor: try parseDivisor(input: lines[3]),
                      trueTarget: try parseTarget(input: lines[4]),
                      falseTarget: try parseTarget(input: lines[5]),
                      items: try parseStartingItems(input: lines[1]))
    }
    
    private static func parseMonkeyIndex(input: String) throws -> Int {
        guard let (_, monkeyIndexString) = try #/Monkey (\d+):/#.wholeMatch(in: input)?.output,
              let monkeyIndex = Int(monkeyIndexString) else {
            throw ParseError.failed
        }
        return monkeyIndex
    }
    
    private static func parseStartingItems(input: String) throws -> [Int] {
        guard let (_, startingValuesString) = try #/Starting items: (.+)/#.firstMatch(in: input)?.output else {
            throw ParseError.failed
        }
        return startingValuesString.split(separator: ", ").compactMap { Int($0) }
    }
    
    private static func parseOperator(input: String) throws -> (operation: Monkey.Operation, operand: Monkey.Operand) {
        guard let (_, opString, operandString) = try #/Operation: new = old (.+) (.+)/#.firstMatch(in: input)?.output,
              let operation = Monkey.Operation(rawValue: String(opString)) else {
            throw ParseError.failed
        }
        
        let operand = try Monkey.Operand.fromString(String(operandString))
        return (operation: operation, operand: operand)
    }
    
    private static func parseDivisor(input: String) throws -> Int {
        guard let (_, divisorString) = try #/Test: divisible by (\d+)/#.firstMatch(in: input)?.output,
              let divisor = Int(divisorString) else {
            throw ParseError.failed
        }
        return divisor
    }
    
    private static func parseTarget(input: String) throws -> Int {
        guard let (_, _, targetIndexString) = try #/If (true|false): throw to monkey (\d+)/#.firstMatch(in: input)?.output,
            let targetIndex = Int(targetIndexString) else {
            throw ParseError.failed
        }
        return targetIndex
    }
}
