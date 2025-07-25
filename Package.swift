// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MarketData",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "MarketData",
            targets: ["MarketData"]
        ),
    ],
    dependencies: [
       
    ],
    targets: [
        .target(
            name: "MarketData",
            dependencies: [],
            path: "Sources/MarketData",
            resources: [
                .process("CoreDataManager/MarketData.xcdatamodel")
            ]
        ),
        .testTarget(
            name: "MarketDataTests",
            dependencies: ["MarketData"]
        )
    ]
)
