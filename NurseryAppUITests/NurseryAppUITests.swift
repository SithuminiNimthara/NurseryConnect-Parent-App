import XCTest

final class NurseryAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testDiaryNavigationFlow() throws {
        let app = XCUIApplication()
        app.launch()

        // Navigate to Diary
        let diaryButton = app.buttons["View Daily Diary"]
        XCTAssertTrue(diaryButton.waitForExistence(timeout: 3))
        diaryButton.tap()

        // Tap first diary item
        let firstCell = app.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 3))
        firstCell.tap()

        // Check detail screen
        XCTAssertTrue(app.navigationBars["Entry Details"].waitForExistence(timeout: 3))
    }

    @MainActor
    func testAddEmergencyContactFlow() throws {
        let app = XCUIApplication()
        app.launch()

        // Navigate to Profile
        let profileButton = app.buttons["Manage Profile"]
        XCTAssertTrue(profileButton.waitForExistence(timeout: 3))
        profileButton.tap()

        // Open Add Contact screen
        let addButton = app.buttons["Add Emergency Contact"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 3))
        addButton.tap()

        // Fill form
        let nameField = app.textFields["Full Name"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 3))
        nameField.tap()
        nameField.typeText("Nimal Perera")

        let relationshipField = app.textFields["Relationship"]
        relationshipField.tap()
        relationshipField.typeText("Father")

        let phoneField = app.textFields["Phone Number"]
        phoneField.tap()
        phoneField.typeText("0771234567")

        // Save
        let saveButton = app.buttons["Save Contact"]
        XCTAssertTrue(saveButton.isEnabled)
        saveButton.tap()
    }
}
