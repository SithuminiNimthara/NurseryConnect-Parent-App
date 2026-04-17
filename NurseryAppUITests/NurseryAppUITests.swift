import XCTest

final class NurseryAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testDashboardShowsDiaryCard() throws {
        let app = XCUIApplication()
        app.launch()

        let diaryText = app.staticTexts["View Daily Diary"]
        XCTAssertTrue(diaryText.waitForExistence(timeout: 5))
    }

    @MainActor
    func testDashboardShowsProfileCard() throws {
        let app = XCUIApplication()
        app.launch()

        let profileText = app.staticTexts["Manage Profile"]
        XCTAssertTrue(profileText.waitForExistence(timeout: 5))
    }
}
