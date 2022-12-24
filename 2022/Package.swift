// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

func dailyExecutableTarget(name: String) -> Target {
    return .executableTarget(
        name: name,
        dependencies: [
            "Shared"
        ],
        resources: [
            .process("Input.txt"),
            .process("TestInput.txt")
        ])
}

let package = Package(
    name: "AdventOfCode2022",
    platforms: [
        .macOS(.v13)
    ],
    products: [
    ],
    dependencies: [
        .package(path: "./Sources/Shared")
    ],
    targets: [
        dailyExecutableTarget(name: "Day1"),
        dailyExecutableTarget(name: "Day2"),
        dailyExecutableTarget(name: "Day3"),
        dailyExecutableTarget(name: "Day4"),
        dailyExecutableTarget(name: "Day5"),
        dailyExecutableTarget(name: "Day6"),
        dailyExecutableTarget(name: "Day7"),
        dailyExecutableTarget(name: "Day8"),
        dailyExecutableTarget(name: "Day9"),
        dailyExecutableTarget(name: "Day10"),
        dailyExecutableTarget(name: "Day11"),
        dailyExecutableTarget(name: "Day12"),
        dailyExecutableTarget(name: "Day13"),
        dailyExecutableTarget(name: "Day14"),
        dailyExecutableTarget(name: "Day15"),
        dailyExecutableTarget(name: "Day16"),
        dailyExecutableTarget(name: "Day17"),
        dailyExecutableTarget(name: "Day18"),
        dailyExecutableTarget(name: "Day19"),
        dailyExecutableTarget(name: "Day20"),
        dailyExecutableTarget(name: "Day21"),
        dailyExecutableTarget(name: "Day22"),
        dailyExecutableTarget(name: "Day23"),
        dailyExecutableTarget(name: "Day24"),
    ]
)
