import Testing
@testable import SwiftGD

@Suite("SwiftGD")
struct SwiftGDTests {
    @Test("Reduce colors with and without dithering")
    func reduceColors() throws {
        let size = 16
        let color = Color(
            red: 0.2,
            green: 0.10,
            blue: 0.77,
            alpha: 1.0
        )

        let image = try #require(Image(width: size, height: size))
        image.fillRectangle(
            topLeft: .zero,
            bottomRight: Point(x: size, y: size),
            color: color
        )

        try image.reduceColors(max: 4, shouldDither: false)
        try image.reduceColors(max: 2, shouldDither: true)

        for value in -1...1 {
            #expect(throws: (Error).self) {
                try image.reduceColors(max: value)
            }
        }
    }
}
