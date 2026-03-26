import XCTest
@testable import NurseryApp

final class FormValidationTests: XCTestCase {

    func testIsNotBlankReturnsTrueForValidText() {
        XCTAssertTrue(FormValidation.isNotBlank("Parent Name"))
    }

    func testIsNotBlankReturnsFalseForEmptyOrSpaces() {
        XCTAssertFalse(FormValidation.isNotBlank(""))
        XCTAssertFalse(FormValidation.isNotBlank("   "))
    }

    func testPhoneValidationAcceptsTenDigitsOrMore() {
        XCTAssertTrue(FormValidation.isValidPhone("0771234567"))
        XCTAssertTrue(FormValidation.isValidPhone("+94 77 123 4567"))
    }

    func testPhoneValidationRejectsShortNumbers() {
        XCTAssertFalse(FormValidation.isValidPhone("123"))
        XCTAssertFalse(FormValidation.isValidPhone(""))
    }
}
