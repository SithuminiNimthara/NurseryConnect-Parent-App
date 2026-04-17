import XCTest
@testable import NurseryApp

final class NurseryAppTests: XCTestCase {

    func testDiaryEntryTypeConversion() {
        let entry = DiaryEntry(
            title: "Lunch",
            details: "Ate pasta",
            timestamp: Date(),
            type: .meal
        )

        XCTAssertEqual(entry.type, .meal)
        XCTAssertEqual(entry.typeRawValue, "Meal")
    }
}
