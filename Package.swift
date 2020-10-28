// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// Name of this Package
let packageName = "SideTide"

// Package creation
let package = Package(name: packageName)

package.products = [
	.library(name: packageName, targets: [packageName])
]

package.platforms = [
	.iOS(.v13),
	.macOS(.v10_15)
]

package.targets = [
	.target(name: packageName, path: "Sources"),
	.testTarget(name: "\(packageName)Tests", dependencies: [Target.Dependency(stringLiteral: packageName)]),
]

package.swiftLanguageVersions = [.v5]
