import SwiftUI

struct InitialsAvatarView: View {
    let name: String
    let size: CGFloat

    private var initials: String {
        let parts = name.split(separator: " ")
        let letters = parts.prefix(2).compactMap { $0.first }.map { String($0) }
        return letters.joined().uppercased()
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(AppTheme.softBackground)

            Text(initials.isEmpty ? "?" : initials)
                .font(.system(size: size * 0.34, weight: .bold))
                .foregroundStyle(AppTheme.primary)
        }
        .frame(width: size, height: size)
        .overlay(
            Circle()
                .stroke(AppTheme.primary.opacity(0.25), lineWidth: 1)
        )
    }
}
