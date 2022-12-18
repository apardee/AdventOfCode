import Foundation
import Shared

struct State: Hashable {
    let location: String
    let remainingTime: Int
    let openedValves: Set<String>
}

struct Valve {
    let name: String
    let flowRate: Int
    let connections: Set<String>
}

@main
struct Day16 {
    
    public static func main() {
        let input = try! loadInput(bundle: .module, type: .personal)
        let valveRegex = #/Valve (?<valveName>.+) has flow rate=(?<flowRate>\d+); tunnel[s]? lead[s]? to valve[s]? (?<connectedValves>.+)/#
        let valveList = try! input.split(separator: "\n")
            .map {
                let match = try valveRegex.wholeMatch(in: String($0))!
                return Valve(name: String(match.valveName),
                             flowRate: Int(match.flowRate)!,
                             connections: Set(match.connectedValves.split(separator: ", ").map { String($0) }))
            }
        let valves = Dictionary(uniqueKeysWithValues: valveList.map { ($0.name, $0) })
        
    }
    
    private static func solvePart1(withValves valves: [String: Valve]) {
        let initialState = State(location: "AA", remainingTime: 30, openedValves: [])
        var memo = [State: (State, Int)]()
        let maxFlow = maxFlow(with: initialState, valves: valves, memo: &memo)
        print("maxFlow: \(maxFlow)")
    }
    
    private static func solvePart2(withValves valves: [String: Valve]) {
        let initialState = State(location: "AA", remainingTime: 26, openedValves: [])
        var memo = [State: (State, Int)]()
        let (finalState, maxValue) = maxFlow(with: initialState, valves: valves, memo: &memo)
        
        memo = [State: (State, Int)]()
        let elephantInitialState = State(location: "AA", remainingTime: 26, openedValves: finalState.openedValves)
        let (_, elephantMaxValue) = maxFlow(with: elephantInitialState, valves: valves, memo: &memo)
        
        print("\(elephantMaxValue + maxValue)")
    }
    
    private static func maxFlow(with state: State, valves: [String: Valve], memo: inout [State: (State, Int)]) -> (State, Int) {
        guard state.remainingTime > 0 else {
            return (state, 0)
        }
        
        if state.openedValves.count == valves.count {
            return (state, 0)
        }
        
        if let (state, cachedMax) = memo[state] {
            return (state, cachedMax)
        }
        
        let location = valves[state.location]!
        var options: [(location: String, newlyOpened: Set<String>, addedValue: Int)] = []
        if location.flowRate > 0 && state.openedValves.contains(location.name) == false {
            options.append((location: location.name,
                            newlyOpened: [location.name],
                            addedValue: location.flowRate * (state.remainingTime - 1)))
        }
        for next in location.connections {
            options.append((location: next, newlyOpened: [], addedValue: 0))
        }
        
        var maxFinalState: State? = nil
        var maxValueAvailable = 0
        for a in options {
            let newOpenedValves = state.openedValves.union(a.newlyOpened)
            let newState = State(location: a.location,
                                 remainingTime: state.remainingTime - 1,
                                 openedValves: newOpenedValves)
            
            let (finalState, value) = maxFlow(with: newState, valves: valves, memo: &memo)
            let finalValue = a.addedValue + value
            if finalValue >= maxValueAvailable {
                maxFinalState = finalState
                maxValueAvailable = finalValue
            }
            
        }
        memo[state] = (maxFinalState!, maxValueAvailable)
        return (maxFinalState!, maxValueAvailable)
    }
}
