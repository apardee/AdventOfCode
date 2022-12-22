import Foundation
import Shared

enum EvaluationError: Error {
    case unknownMonkey
}

enum Operation: String {
    case add = "+"
    case sub = "-"
    case mul = "*"
    case div = "/"
    
    func evaluate(_ value1: Int, _ value2: Int) -> Int {
        switch self {
        case .add: return value1 + value2
        case .sub: return value1 - value2
        case .mul: return value1 * value2
        case .div: return value1 / value2
        }
    }
}

struct Monkey: Hashable {
    enum Value: Hashable {
        case value(Int)
        case operation(String, String, Operation)
    }
    let name: String
    let value: Value
}

@main
struct Day21 {
    public static func main() throws {
        let lines = try! loadInput(bundle: .module, type: .personal).split(separator: "\n")
        let valueRegex = #/(?<name>.+): (?<value>\d+)/#
        let operationRegex = #/(?<name>.+): (?<monkey1>.+) (?<operation>[-+*/]) (?<monkey2>.+)/#
        
        var monkeys = [Monkey]()
        for line in lines {
            if let match = try operationRegex.wholeMatch(in: line) {
                let monkey = Monkey(
                    name: String(match.name),
                    value: .operation(
                        String(match.monkey1),
                        String(match.monkey2),
                        Operation(rawValue: String(match.operation))!))
                monkeys.append(monkey)
            } else if let match = try valueRegex.wholeMatch(in: line) {
                let monkey = Monkey(
                    name: String(match.name),
                    value: .value(Int(match.value)!))
                monkeys.append(monkey)
            } else {
                fatalError("unrecognized type...")
            }
        }
        
        try solvePart1(monkeys: monkeys)
        try solvePart2(monkeys: monkeys)
    }
    
    private static func solvePart1(monkeys: [Monkey]) throws {
        let monkeyIndex = Dictionary(uniqueKeysWithValues: monkeys.map { ($0.name, $0) })
        var cachedValues = [String: Int]()
        let value = try evaluate(name: "root", index: monkeyIndex, cachedValues: &cachedValues)!
        print("part 1: \(value)")
    }
    
    private static func solvePart2(monkeys: [Monkey]) throws {
        let monkeyIndex = Dictionary(uniqueKeysWithValues: monkeys.map { ($0.name, $0) })
        
        let root = monkeyIndex["root"]!
        let lhs: String
        let rhs: String
        switch root.value {
            case .operation(let monkeyA, let monkeyB, _):
                lhs = monkeyA
                rhs = monkeyB
            default: fatalError("expected expression...")
        }
        
        let lhsValue: Int?
        do {
            var cachedValues = [String: Int]()
            lhsValue = try evaluate(name: lhs, index: monkeyIndex, skipHumn: true, cachedValues: &cachedValues)
        }

        let rhsValue: Int?
        do {
            var cachedValues = [String: Int]()
            rhsValue = try evaluate(name: rhs, index: monkeyIndex, skipHumn: true, cachedValues: &cachedValues)
        }
        
        let startingMonkeyName: String
        let expectedValue: Int
        if let lhsValue, rhsValue == nil {
            startingMonkeyName = rhs
            expectedValue = lhsValue
        } else if let rhsValue, lhsValue == nil {
            startingMonkeyName = lhs
            expectedValue = rhsValue
        } else {
            fatalError("expected one valid value...")
        }
        
        let solution = try balancedEvaluationDriver(name: startingMonkeyName, index: monkeyIndex, expectedValue: expectedValue)!
        print("part 2: \(solution)")
    }
    
    @discardableResult
    private static func evaluate(name: String, index: [String: Monkey], skipHumn: Bool = false, cachedValues: inout [String: Int]) throws -> Int? {
        if skipHumn == true && name == "humn" {
            return nil
        }
        
        if let value = cachedValues[name] { return value }
        guard let monkey = index[name] else { throw EvaluationError.unknownMonkey }
        
        let result: Int
        switch monkey.value {
        case .value(let value):
            result = value
        case .operation(let monkey1, let monkey2, let operation):
            let a = try evaluate(name: monkey1, index: index, skipHumn: skipHumn, cachedValues: &cachedValues)
            let b = try evaluate(name: monkey2, index: index, skipHumn: skipHumn, cachedValues: &cachedValues)
            guard let a, let b else { return nil }
            result = operation.evaluate(a, b)
        }
        cachedValues[name] = result
        return result
    }
    
    @discardableResult
    private static func balancedEvaluationDriver(name: String, index: [String: Monkey], expectedValue: Int) throws -> Int? {
        guard let monkey = index[name] else { throw EvaluationError.unknownMonkey }
        
        if name == "humn" {
            return expectedValue
        }
        
        let result: Int
        switch monkey.value {
        case .value(let value):
            result = value
        case .operation(let monkey1, let monkey2, let operation):
            var cachedValues = [String: Int]()
            let lhs = try evaluate(name: monkey1, index: index, skipHumn: true, cachedValues: &cachedValues)
            let rhs = try evaluate(name: monkey2, index: index, skipHumn: true, cachedValues: &cachedValues)
            
            if lhs == nil, let rhs {
                switch operation {
                case .add:
                    // x + rhs = expected
                    return try balancedEvaluationDriver(name: monkey1, index: index, expectedValue: expectedValue - rhs)
                case .sub:
                    // x - rhs = expected
                    return try balancedEvaluationDriver(name: monkey1, index: index, expectedValue: expectedValue + rhs)
                case .mul:
                    // x * rhs = expected
                    return try balancedEvaluationDriver(name: monkey1, index: index, expectedValue: expectedValue / rhs)
                case .div:
                    // x / rhs = expected
                    return try balancedEvaluationDriver(name: monkey1, index: index, expectedValue: expectedValue * rhs)
                }
            } else if let lhs, rhs == nil {
                switch operation {
                case .add:
                    // lhs + x = expectedValue
                    return try balancedEvaluationDriver(name: monkey2, index: index, expectedValue: expectedValue - lhs)
                case .sub:
                    // lhs - x = expected
                    return try balancedEvaluationDriver(name: monkey2, index: index, expectedValue: lhs - expectedValue)
                case .mul:
                    // lhs * x = expected
                    return try balancedEvaluationDriver(name: monkey2, index: index, expectedValue: expectedValue / lhs)
                case .div:
                    // lhs / x = expected
                    return try balancedEvaluationDriver(name: monkey2, index: index, expectedValue: lhs / expectedValue)
                }
            } else {
                fatalError("unexpected result...")
            }
        }
        return result
    }
}
