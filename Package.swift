import PackageDescription

let package = Package(
	name: "SwiftFFDB",
	targets: [
		Target(name: "Swift-FFDB/Classes/Component", dependencies: []),
		Target(name: "Swift-FFDB/Classes/Depend", dependencies: [])
	],
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 3)
	])
