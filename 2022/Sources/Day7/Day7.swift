import Foundation
import Shared

enum FileSystemObject {
    case file(String, Int)
    case directory(String, [FileSystemObject])
    
    var size: Int {
        switch self {
        case .file(_, let size):
            return size
        case .directory(_, let entries):
            return entries.reduce(0, { $0 + $1.size})
        }
    }
    
    func totalForDirectories(under: Int) -> Int {
        switch self {
        case .file(_, _):
            return 0
        case .directory(_, let contents):
            var total = 0
            let containedSize = self.size
            if containedSize <= under {
                total += containedSize
            }
            for object in contents {
                total += object.totalForDirectories(under: under)
            }
            return total
        }
    }
    
    func bestToDelete(toFree minRequired: Int) -> Int? {
        switch self {
        case .file(_, _):
            return nil
        case .directory(_, let contents):
            var bestToDelete = Int.max
            
            let containedSize = self.size
            if containedSize >= minRequired {
                bestToDelete = containedSize
            }
            
            for object in contents {
                if let candidateSize = object.bestToDelete(toFree: minRequired), candidateSize < bestToDelete {
                    bestToDelete = candidateSize
                }
            }
            return (bestToDelete == Int.max) ? nil : bestToDelete
        }
    }
}

@main
public struct Day7 {
    
    private static let cd = #/\$ cd (?<dirName>.+)/#
    private static let ls = #/\$ ls/#
    private static let file = #/(?<fileSize>\d+) (?<fileName>.+)/#
    private static let dir = #/dir (?<dirName>.+)/#
    
    public static func main() {
        let input = try! loadInput(bundle: Bundle.module)
        let output = input.split(separator: "\n")
        let (rootContents, _) = parseDirectory(output: output, index: 1)
        let rootDirectory: FileSystemObject = .directory("/", rootContents)
        
        solvePart1(withRoot: rootDirectory)
        solvePart2(withRoot: rootDirectory)
    }
    
    private static func solvePart1(withRoot rootDirectory: FileSystemObject) {
        print("part1 (total under 100000): \(rootDirectory.totalForDirectories(under: 100000))")
    }
    
    private static func solvePart2(withRoot rootDirectory: FileSystemObject) {
        let totalSize = 70000000
        let requiredFree = 30000000
        let deleteNeeded = requiredFree - (totalSize - rootDirectory.size)
        print("part 2 (best object to remove): \(rootDirectory.bestToDelete(toFree: deleteNeeded)!)")
    }
    
    private static func parseDirectory(output: [Substring], index: Int) -> (contents: [FileSystemObject], newIndex: Int) {
        var contents = [FileSystemObject]()
        var outputIdx = index
        while outputIdx < output.count {
            let commandString = output[outputIdx]
            if let match = try! cd.wholeMatch(in: commandString) {
                let dirName = match.dirName
                if dirName == ".." {
                    break
                } else {
                    let (newContent, newIdx) = parseDirectory(output: output,
                                                              index: outputIdx + 1)
                    contents.append(.directory(String(dirName), newContent))
                    outputIdx = newIdx
                }
            } else if let _ = try! ls.wholeMatch(in: commandString) {
                let (newContent, newIdx) = parseFiles(output: output,
                                                      index: outputIdx + 1)
                contents.append(contentsOf: newContent)
                outputIdx = newIdx
            } else {
                fatalError("unrecognized command")
            }
        }
        return (contents: contents, newIndex: outputIdx + 1)
    }
    
    private static func parseFiles(output: [Substring], index: Int) -> (contents: [FileSystemObject], newIndex: Int) {
        var contents = [FileSystemObject]()
        var outputIdx = index
        while outputIdx < output.count {
            let outputLine = output[outputIdx]
            if let match = try! file.wholeMatch(in: outputLine) {
                contents.append(.file(String(match.fileName), Int(match.fileSize)!))
            } else if let _ = try! dir.wholeMatch(in: outputLine) {
                // skip
            } else {
                break
            }
            outputIdx += 1
        }
        return (contents: contents, newIndex: outputIdx)
    }
}
