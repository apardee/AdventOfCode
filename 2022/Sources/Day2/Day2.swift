import Foundation
import Shared

@main
public struct Day2 {
    
    enum Result {
        case win
        case lose
        case draw
        
        func moveToAchieve(against other: Move) -> Move {
            switch self {
                case .win:
                    switch other {
                        case .rock: return .paper
                        case .scissors: return .rock
                        case .paper: return .scissors
                    }
                case .lose:
                    switch other {
                        case .rock: return .scissors
                        case .scissors: return .paper
                        case .paper: return .rock
                    }
                case .draw:
                    switch other {
                        case .rock: return .rock
                        case .scissors: return .scissors
                        case .paper: return .paper
                    }
            }
        }
    }
    
    enum Move {
        case rock
        case scissors
        case paper
        
        var baseScore: Int {
            switch self {
                case .rock: return 1
                case .scissors: return 3
                case .paper: return 2
            }
        }
        
        func score(againstMove other: Move) -> Int {
            switch self {
                case .rock:
                    switch other {
                        case .rock: return 3
                        case .scissors: return 6
                        case .paper: return 0
                    }
                case .scissors:
                    switch other {
                        case .rock: return 0
                        case .scissors: return 3
                        case .paper: return 6
                    }
                case .paper:
                    switch other {
                        case .rock: return 6
                        case .scissors: return 0
                        case .paper: return 3
                    }
            }
        }
    }
    
    public static func main() {
        solvePart1()
        solvePart2()
    }
    
    private static func solvePart1() {
        let input = try! loadInput(bundle: Bundle.module)
        let moves = input.split(separator: "\n")
            .map {
                let moveStrings = $0.split(separator: " ")
                return (moveStrings[0].toMove(), moveStrings[1].toMove())
            }
        print("total score part 1: \(score(moves: moves))")
    }
    
    private static func solvePart2() {
        let input = try! loadInput(bundle: Bundle.module)
        let moves = input.split(separator: "\n")
            .map {
                let moves = $0.split(separator: " ")
                let desiredResult = moves[1].toResult()
                let opponentMove = moves[0].toMove()
                return (opponentMove, desiredResult.moveToAchieve(against: opponentMove))
            }
        print("total score part 2: \(score(moves: moves))")
    }
    
    private static func score(moves: [(Move, Move)]) -> Int {
        return moves
            .map { (opponent, me) in return me.baseScore + me.score(againstMove: opponent) }
            .reduce(0, { $0 + $1 })
    }
}

extension Substring {
    func toMove() -> Day2.Move {
        switch self {
        case "A", "X":
            return .rock
        case "B", "Y":
            return .paper
        case "C", "Z":
            return .scissors
        default:
            fatalError("unrecognized move")
        }
    }
    
    func toResult() -> Day2.Result {
        switch self {
        case "X":
            return .lose
        case "Y":
            return .draw
        case "Z":
            return .win
        default:
            fatalError("unrecognized move")
        }
    }
}
