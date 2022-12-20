import Foundation
import Shared

class Node {
    init(value: Int) {
        self.value = value
    }
    let value: Int
    var next: Node? = nil
    var prev: Node? = nil
}

@main
struct Day20 {
    
    public static func main() {
        let values = try! loadInput(bundle: .module).split(separator: "\n").map { Int($0)! }
        solvePart1(values: values)
        solvePart2(values: values)
    }
    
    private static func solvePart1(values: [Int]) {
        print("part 1 (1 mix): \(evaluateSignal(values: values, mixCount: 1))")
    }
    
    private static func solvePart2(values: [Int]) {
        let expandedValues = values.map { $0 * 811589153 }
        print("part 2 (10 mixes & expanded): \(evaluateSignal(values: expandedValues, mixCount: 10))")
    }
    
    private static func evaluateSignal(values: [Int], mixCount: Int = 1) -> Int {
        let nodes = values.map { Node(value: $0) }
        for i in 0..<nodes.count {
            let curr = nodes[i]
            curr.next = nodes[(i + 1) % nodes.count]
            curr.prev = nodes[(i + nodes.count - 1) % nodes.count]
        }
        
        for _ in 0..<mixCount {
            for node in nodes {
                let start = node.prev
                node.prev?.next = node.next
                node.next?.prev = node.prev
                node.next = nil
                node.prev = nil
                
                let steps = abs(node.value) % (nodes.count - 1)
                let backwards = node.value < 0
                var updatedPrev = start
                for _ in 0..<steps {
                    updatedPrev = backwards ?
                    updatedPrev?.prev :
                    updatedPrev?.next
                }
                
                let updatedNext = updatedPrev?.next
                updatedPrev?.next = node
                updatedNext?.prev = node
                node.prev = updatedPrev
                node.next = updatedNext
            }
        }
        
        var nodeIter = nodes.first
        for _ in 0..<nodes.count {
            nodeIter = nodeIter?.next
        }
        
        var currNode = nodes.first(where: { $0.value == 0 })!
        var total = 0
        for i in 1...3000 {
            currNode = currNode.next!
            if i % 1000 == 0 {
                total += currNode.value
            }
        }
        return total
    }
}
