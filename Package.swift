import PackageDescription

let package = Package(
	name: "SwiftFFDB",
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 3)
	])
