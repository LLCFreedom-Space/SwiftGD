import Testing
@testable import SwiftGD

@Suite("Image rendering")
struct TestImage {
    /// Список шрифтів, серед яких зазвичай є доступний на платформі.
    /// Тести можуть не пройти, якщо жоден із цих шрифтів не встановлено.
    static let fontList = [
        "SFCompact",
        "ArialMT",
        "Arial",
        "Arial",
        "Roboto",
        "Ubuntu",
        "Noto",
        "Noto Sans",
        "SSTPro-Roman"
    ]

    @Test("Renders text")
    func renderText() throws {
        guard let image = Image(width: 640, height: 480) else {
            throw Error.invalidImage(reason: "Could not initialize image")
        }

        let bounds = image.renderText(
            "SwiftGD",
            from: Point(x: 320, y: 240),
            fontList: Self.fontList,
            color: .red,
            size: 50,
            angle: .degrees(-15)
        )

        #expect(try !isEmptyBounds(for: bounds))
    }

    @Test("Empty text returns empty bounds")
    func renderEmptyText() throws {
        guard let image = Image(width: 640, height: 480) else {
            throw Error.invalidImage(reason: "Could not initialize image")
        }

        let bounds = image.renderText(
            "",
            from: .zero,
            fontList: ["Arial", "Ubuntu", "Roboto"],
            color: .black,
            size: 18
        )

        #expect(try isEmptyBounds(for: bounds))
    }

    @Test("Empty font list returns empty bounds")
    func renderWithEmptyFontList() throws {
        guard let image = Image(width: 640, height: 480) else {
            throw Error.invalidImage(reason: "Could not create image")
        }

        let bounds = image.renderText(
            "Hello, World",
            from: .zero,
            fontList: [],
            color: .white,
            size: 18
        )

        #expect(try isEmptyBounds(for: bounds))
    }

    @Test("Exports an AVIF image")
    func createAndExportAVIFImage() throws {
        guard let image = Image(width: 640, height: 480) else {
            throw Error.invalidImage(reason: "Could not initialize image")
        }

        image.renderText(
            "SwiftGD AVIF Test",
            from: Point(x: 320, y: 240),
            fontList: Self.fontList,
            color: .red,
            size: 50,
            angle: .degrees(0)
        )

        let avifData = try image.export(as: .avif)
        #expect(!avifData.isEmpty)
    }

    private func isEmptyBounds(
        for result: (
            upperLeft: Point,
            upperRight: Point,
            lowerRight: Point,
            lowerLeft: Point
        )
    ) -> Bool {
        [
            result.upperLeft,
            result.upperRight,
            result.lowerRight,
            result.lowerLeft
        ].allSatisfy { $0 == .zero }
    }
}
