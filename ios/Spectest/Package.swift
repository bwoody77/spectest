// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "Spectest",
  platforms: [.iOS(.v17), .macOS(.v14)],
  dependencies: [
    // SpecRuntime — local path assumes standard spec monorepo layout.
    // Adjust the path if your project structure differs.
    .package(name: "SpecRuntime", path: "../SpecRuntime"),
  ],
  targets: [
    .executableTarget(
      name: "Spectest",
      dependencies: ["SpecRuntime"],
      path: "."
    ),
  ]
)
