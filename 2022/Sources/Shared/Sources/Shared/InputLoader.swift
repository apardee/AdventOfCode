import Foundation

public enum InputType {
    case test
    case personal
}

public func loadInput(bundle: Bundle, type: InputType = .personal) throws -> String {
    let inputFile: String
    switch type {
    case .test:
        inputFile = "TestInput"
    case .personal:
        inputFile = "Input"
    }
    let path = bundle.url(forResource: inputFile, withExtension: "txt")!
    return try! String(contentsOf: path)
}
