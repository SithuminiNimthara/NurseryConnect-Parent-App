import SwiftUI

enum AppTheme {
    static let primary = Color("PrimaryGreen")
    static let secondary = Color("SoftGreen")
    static let accent = Color("AccentGreen")

    static let background = Color(.systemGroupedBackground)
    static let cardBackground = Color(.systemBackground)
    static let softBackground = Color("PrimaryGreen").opacity(0.12)

    static let border = Color.gray.opacity(0.14)
    static let shadow = Color.black.opacity(0.05)
    static let mutedText = Color.secondary
}
