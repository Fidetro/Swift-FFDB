import PackageDescription

let package = Package(
	name: "SwiftFFDB",
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 3)
	],
	exclude:["Podfile","Podfile.lock","Pods","src","Swift-FFDB","Swift-FFDB.xcodeproj","Swift-FFDB.xcworkspace","Swift-FFDBTests","SwiftFFDB.podspec"]
)
