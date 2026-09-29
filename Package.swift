// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "SwiftGD",
    products: [
        .library(
            name: "SwiftGD",
            targets: ["SwiftGD"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/LLCFreedom-Space/Cgd", from: "2.0.0")
    ],
    targets: [
        .systemLibrary(
            name: "gd",
            pkgConfig: "gdlib",
            providers: [.apt(["libgd-dev"]), .brew(["gd"])]
        ),
        .target(
            name: "SwiftGD",
            dependencies: ["gd"]
        ),
        .testTarget(
            name: "SwiftGDTests",
            dependencies: ["SwiftGD"]
        )
    ]
)
