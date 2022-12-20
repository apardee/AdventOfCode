import Foundation
import Shared

struct Blueprint {
    let id: Int
    let oreCost: Int
    let clayOreCost: Int
    let obsidianOreCost: Int
    let obsidianClayCost: Int
    let geodeOreCost: Int
    let geodeObsidianCost: Int
}

struct State: Hashable {
    var oreRobots: Int = 1
    var clayRobots: Int = 0
    var obsidianRobots: Int = 0
    var geodeRobots: Int = 0
    
    var ore: Int = 0
    var clay: Int = 0
    var obsidian: Int = 0
    var geodes: Int = 0
    
    var minutesRemaining: Int
    
    var validated: State? {
        return isValid ? self : nil
    }
    
    var isValid: Bool {
        return ore >= 0 &&
               clay >= 0 &&
               obsidian >= 0 &&
               geodes >= 0
    }
    
    func addingResources() -> State {
        var nextState = self
        nextState.ore = ore + oreRobots
        nextState.clay = clay + clayRobots
        nextState.obsidian = obsidian + obsidianRobots
        nextState.geodes = geodes + geodeRobots
        return nextState
    }
    
    func doNothing() -> State {
        var nextState = self
        nextState.minutesRemaining -= 1
        return nextState
    }
    
    func buyingOreRobot(withBlueprint blueprint: Blueprint) -> State? {
        let maxNeededOre = max(
            blueprint.clayOreCost,
            blueprint.oreCost,
            blueprint.obsidianOreCost,
            blueprint.geodeOreCost)
        
        if oreRobots >= maxNeededOre {
            return nil
        }
        
        var nextState = self
        nextState.oreRobots += 1
        nextState.ore -= blueprint.oreCost
        nextState.minutesRemaining -= 1
        return nextState.validated
    }
    
    func buyingClayRobot(withBlueprint blueprint: Blueprint) -> State? {
        if clayRobots >= blueprint.obsidianClayCost {
            return nil
        }
        
        var nextState = self
        nextState.clayRobots += 1
        nextState.ore -= blueprint.clayOreCost
        nextState.minutesRemaining -= 1
        return nextState.validated
    }
    
    func buyingObsidianRobot(withBlueprint blueprint: Blueprint) -> State? {
        if obsidianRobots >= blueprint.geodeObsidianCost {
            return nil
        }
        
        var nextState = self
        nextState.obsidianRobots += 1
        nextState.ore -= blueprint.obsidianOreCost
        nextState.clay -= blueprint.obsidianClayCost
        nextState.minutesRemaining -= 1
        return nextState.validated
    }
    
    func buyingGeodeRobot(withBlueprint blueprint: Blueprint) -> State? {
        var nextState = self
        nextState.geodeRobots += 1
        nextState.ore -= blueprint.geodeOreCost
        nextState.obsidian -= blueprint.geodeObsidianCost
        nextState.minutesRemaining -= 1
        return nextState.validated
    }
    
    func withResources(from other: State) -> State {
        var newState = self
        newState.ore += other.oreRobots
        newState.clay += other.clayRobots
        newState.obsidian += other.obsidianRobots
        newState.geodes += other.geodeRobots
        return newState
    }
}

@main
struct Day19 {
    public static func main() throws {
        let inputRegex = #/Blueprint (?<id>\d+): Each ore robot costs (?<oreCost>\d+) ore\. Each clay robot costs (?<clayOreCost>\d+) ore\. Each obsidian robot costs (?<obsidianOreCost>\d+) ore and (?<obsidianClayCost>\d+) clay\. Each geode robot costs (?<geodeOreCost>\d+) ore and (?<geodeObsidianCost>\d+) obsidian\./#
        
        let blueprints = try loadInput(bundle: .module, type: .test)
            .split(separator: "\n")
            .map { line in
                let match = try inputRegex.wholeMatch(in: String(line))!
                return Blueprint(
                    id: Int(match.id)!,
                    oreCost: Int(match.oreCost)!,
                    clayOreCost: Int(match.clayOreCost)!,
                    obsidianOreCost: Int(match.obsidianOreCost)!,
                    obsidianClayCost: Int(match.obsidianClayCost)!,
                    geodeOreCost: Int(match.geodeOreCost)!,
                    geodeObsidianCost: Int(match.geodeObsidianCost)!)
            }
        
        solvePart1(withBlueprints: blueprints)
        solvePart2(withBlueprints: blueprints)
    }
    
    private static func solvePart1(withBlueprints blueprints: [Blueprint]) {
        var total = 0
        for blueprint in blueprints {
            var maxSeen = 0
            let state = State(minutesRemaining: 24)
            var memo = [State: Int]()
            let maxGeodes = maxGeodes(blueprint: blueprint, state: state, memo: &memo, maxSeen: &maxSeen)!
            total += maxGeodes * blueprint.id
        }
        print("part 1 (sum for 24): \(total)")
    }
    
    private static func solvePart2(withBlueprints blueprints: [Blueprint]) {
        var total = 1
        for blueprint in blueprints[..<min(blueprints.count, 3)] {
            var maxSeen = 0
            let state = State(minutesRemaining: 32)
            var memo = [State: Int]()
            let maxGeodes = maxGeodes(blueprint: blueprint, state: state, memo: &memo, maxSeen: &maxSeen)!
            total *= maxGeodes
        }
        print("part 2 (product for 32): \(total)")
    }
    
    private static func maxGeodes(blueprint: Blueprint, state: State, memo: inout [State: Int], maxSeen: inout Int) -> Int? {
        guard state.minutesRemaining > 0 else {
            return state.geodes
        }
        
        if let cached = memo[state] {
            if cached == -1 {
                return nil
            }
            return cached
        }
        
        let maxPossible = state.geodes + (state.geodeRobots * state.minutesRemaining) + (state.minutesRemaining * (state.minutesRemaining + 1)) / 2
        if maxPossible <= maxSeen {
            memo[state] = -1
            return nil
        }
        
        let canSaveForClayRobot = true
        let canSaveForObsidianRobot = state.oreRobots > 0 && state.clayRobots > 0
        let canSaveForGeodeRobot = state.obsidianRobots > 0 && state.clayRobots > 0
        var maxPurchaseOptions = 1
        if canSaveForClayRobot {
            maxPurchaseOptions += 1
        }
        if canSaveForObsidianRobot {
            maxPurchaseOptions += 1
        }
        if canSaveForGeodeRobot {
            maxPurchaseOptions += 1
        }
        
        let updatedResources = state.addingResources()
        var options: [State]
        if let buyGeode = state.buyingGeodeRobot(withBlueprint: blueprint) {
            options = [ buyGeode ]
        } else {
            options = [
                state.buyingOreRobot(withBlueprint: blueprint),
                state.buyingClayRobot(withBlueprint: blueprint),
                state.buyingObsidianRobot(withBlueprint: blueprint),
            ].compactMap { $0 }
            if options.count < maxPurchaseOptions {
                options.append(state.doNothing())
            }
        }
        
        let finalOptions = options
            .map { $0.withResources(from: updatedResources) }
            .compactMap { maxGeodes(blueprint: blueprint, state: $0, memo: &memo, maxSeen: &maxSeen) }
        guard let maxGeodes = finalOptions.max() else {
            memo[state] = -1
            return nil
        }
        memo[state] = maxGeodes
        maxSeen = max(maxSeen, maxGeodes)
        return maxGeodes
    }
}
