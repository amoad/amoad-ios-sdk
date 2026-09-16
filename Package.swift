// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "AMoAd",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "AMoAd", targets: ["AMoAdTarget"])
    ],
    targets: [
        .binaryTarget(name: "AMoAd", path: "Modules/AMoAd.xcframework"),
        .binaryTarget(name: "OMSDK_Cyberagentcojp3", path: "Modules/OMSDK_Cyberagentcojp3.xcframework"),
        .target(
            name: "AMoAdTarget",
            dependencies: [
                "AMoAd",
                "OMSDK_Cyberagentcojp3"
            ],
            path: "Sources/AMoAdTarget",
            // binaryTarget には linkerSettings を書けないため、
            // AMoAd.podspec の s.frameworks と同じリンク指定をこのターゲットで行う
            linkerSettings: [
                .linkedFramework("AdSupport"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("ImageIO"),
                .linkedFramework("StoreKit")
            ]
        )
    ]
)
