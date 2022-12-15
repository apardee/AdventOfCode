// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2022",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
    ],
    targets: [
        .executableTarget(name: "Day1", dependencies: [], resources: [.process("input.txt")]),
        .executableTarget(name: "Day2", dependencies: []),
        .executableTarget(name: "Day3", dependencies: []),
        .executableTarget(name: "Day4", dependencies: []),
        .executableTarget(name: "Day5", dependencies: []),
        .executableTarget(name: "Day6", dependencies: []),
        .executableTarget(name: "Day7", dependencies: []),
        .executableTarget(name: "Day8", dependencies: []),
        .executableTarget(name: "Day9", dependencies: []),
        .executableTarget(name: "Day10", dependencies: []),
        .executableTarget(name: "Day11", dependencies: []),
        .executableTarget(name: "Day12", dependencies: []),
        .executableTarget(name: "Day13", dependencies: []),
        .executableTarget(name: "Day14", dependencies: []),
    ]
)
