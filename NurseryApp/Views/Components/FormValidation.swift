import Foundation

enum FormValidation {
    static func isNotBlank(_ value: String) -> Bool {
        !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    static func trimmed(_ value: String) -> String {
        value.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    static func isValidPhone(_ value: String) -> Bool {
        let digits = value.filter(\.isNumber)
        return digits.count >= 7 && digits.count <= 15
    }
}
