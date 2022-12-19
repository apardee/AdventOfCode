import Foundation
import Shared

enum Direction: Character {
    case left = "<"
    case right = ">"
    case down = "v"
}

struct Position: Hashable {
    let x: Int
    let y: Int
    
    func moving(direction: Direction) -> Position {
        switch direction {
        case .left:
            return Position(x: x - 1, y: y)
        case .right:
            return Position(x: x + 1, y: y)
        case .down:
            return Position(x: x, y: y - 1)
        }
    }
}

struct Size {
    let width: Int
    let height: Int
}

struct Piece {
    let extents: Size
    let collidableOffsets: Set<Position>
    
    func collidableLocations(at position: Position) -> Set<Position> {
        Set(collidableOffsets.map {
            Position(
                x: position.x + $0.x,
                y: position.y + $0.y)
        })
    }
    
    init(string: String) {
        let rows = string.split(separator: "\n").map { Array($0) }
        var collidableOffsets: [Position] = []
        for (rowIdx, row) in rows.enumerated() {
            for (colIdx, value) in row.enumerated() {
                if value == "#" {
                    collidableOffsets.append(Position(x: colIdx,
                                                      y: rows.count - rowIdx - 1))
                }
            }
        }
        self.collidableOffsets = Set(collidableOffsets)
        self.extents = Size(width: rows[0].count, height: rows.count)
    }
}

struct PieceState {
    let pieceType: Piece
    let position: Position
    
    var minX: Int { position.x }
    var maxX: Int { position.x + pieceType.extents.width - 1 }
    var minY: Int { position.y }
    var maxY: Int { position.y + pieceType.extents.height - 1 }
    
    func moving(direction: Direction) -> PieceState {
        PieceState(
            pieceType: pieceType,
            position: position.moving(direction: direction))
    }
    
    func intersects(other: PieceState) -> Bool {
        if minX > other.maxX { return false }
        if maxX < other.minX { return false }
        if minY > other.maxY { return false }
        if maxY < other.minY { return false }
        
        let positions = pieceType.collidableLocations(at: position)
        let otherPositions = other.pieceType.collidableLocations(at: other.position)
        return positions.intersection(otherPositions).count > 0
    }
}

struct Board {
    let width: Int = 7
    var pieces: [PieceState] = []
    
    mutating func add(pieceState: PieceState) {
        pieces.append(pieceState)
    }
    
    var height: Int {
        let highestPiece = pieces.max { a, b in
            a.maxY < b.maxY
        }
        return highestPiece?.maxY ?? -1
    }
    
    func intersects(pieceState: PieceState) -> Bool {
        guard pieceState.minX >= 0 else { return true }
        guard pieceState.minY >= 0 else { return true }
        guard pieceState.maxX < width else { return true }
        
        for other in pieces {
            if pieceState.intersects(other: other) {
                return true
            }
        }
        return false
    }
    
    func moving(pieceState: PieceState, direction: Direction) -> (Bool, PieceState) {
        let candidatePosition = pieceState.moving(direction: direction)
        if intersects(pieceState: candidatePosition) {
            return (false, pieceState)
        } else {
            return (true, candidatePosition)
        }
    }
}

@main
struct Day17 {
    private static let inputType = InputType.personal
    
    public static func main() {
        let pieces = [
            "####",
            
            """
            .#.
            ###
            .#.
            """,
            
            """
            ..#
            ..#
            ###
            """,
            
            """
            #
            #
            #
            #
            """,
            
            """
            ##
            ##
            """
        ].map { Piece(string: $0) }
        
        let jetPattern = try! loadInput(
            bundle: .module,
            type: inputType).compactMap { Direction(rawValue: $0) }
        
        solvePart1(withPieces: pieces, jetPattern: jetPattern)
        solvePart2(withPieces: pieces, jetPattern: jetPattern)
    }
    
    private static func solvePart1(withPieces pieces: [Piece], jetPattern: [Direction]) {
        var pieceIdx = 0
        var jetPatternIdx = 0
        var board = Board()
        
        // start dropping a piece...
        allDone: while true {
            let nextPiece = pieces[pieceIdx]
            pieceIdx = (pieceIdx + 1) % pieces.count
            
            // dropping...
            var dropPieceState = PieceState(
                pieceType: nextPiece,
                position: Position(x: 2, y: board.height + 4))
            
            pieceDone: while true {
                // apply jet position
                do {
                    let direction = jetPattern[jetPatternIdx]
                    jetPatternIdx = (jetPatternIdx + 1) % jetPattern.count
                    let (_, newState) = board.moving(
                        pieceState: dropPieceState,
                        direction: direction)
                    dropPieceState = newState
                }
                
                // move down
                do {
                    let (moved, newState) = board.moving(
                        pieceState: dropPieceState,
                        direction: .down)
                    dropPieceState = newState
                    
                    if !moved {
                        board.add(pieceState: dropPieceState)
                        if board.pieces.count == 2022 {
                            break allDone
                        }
                        break pieceDone
                    }
                }
            }
        }
        print("part 1 (height after 2022): \(board.height + 1)")
    }
    
    private static func solvePart2(withPieces pieces: [Piece], jetPattern: [Direction]) {
        var pieceIdx = 0
        var jetPatternIdx = 0
        var board = Board()
        
        // Cycle start and period will only work for the challenge input. Cycle detection TODO
        let cycleStartIdx: Int = 283
        let cycleLength: Int = 1745
        var cycleValues = [Int: Int]()
        var preCycleHeight = 0
        
        // start dropping a piece...
        allDone: while true {
            let nextPiece = pieces[pieceIdx]
            pieceIdx = (pieceIdx + 1) % pieces.count
            
            // dropping...
            var dropPieceState = PieceState(
                pieceType: nextPiece,
                position: Position(x: 2, y: board.height + 4))
            
            pieceDone: while true {
                // apply jet position
                do {
                    let direction = jetPattern[jetPatternIdx]
                    jetPatternIdx = (jetPatternIdx + 1) % jetPattern.count
                    let (_, newState) = board.moving(
                        pieceState: dropPieceState,
                        direction: direction)
                    dropPieceState = newState
                }
                
                // move down
                do {
                    let (moved, newState) = board.moving(
                        pieceState: dropPieceState,
                        direction: .down)
                    dropPieceState = newState
                    
                    if !moved {
                        let heightBefore = board.height
                        board.add(pieceState: dropPieceState)
                        let heightAfter = board.height
                        
                        if board.pieces.count == cycleLength + cycleStartIdx {
                            break allDone
                        }
                        
                        let patternIdx = board.pieces.count - cycleStartIdx
                        if patternIdx == -1 {
                            preCycleHeight = board.height
                        }
                        if patternIdx >= 0 {
                            cycleValues[patternIdx % cycleLength] = heightAfter - heightBefore
                        }
                        break pieceDone
                    }
                }
            }
        }
        
        let moveEvaluated = 1000000000000
        var value = preCycleHeight
        let cycleIdx = moveEvaluated - cycleStartIdx
        
        let fullCycleCount = cycleIdx / cycleLength
        let fullCycleHeight = cycleValues.reduce(0) { $0 + $1.value }
        value += fullCycleHeight * fullCycleCount
        
        let remainder = cycleIdx % cycleLength + 1
        for i in 0..<remainder {
            value += cycleValues[i]!
        }
        print("part 2 (move: \(moveEvaluated) value): \(value + 1)")
    }
}
