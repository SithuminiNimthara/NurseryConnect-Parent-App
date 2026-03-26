import SwiftUI

struct TagChip: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(AppTheme.softBackground)
            .foregroundStyle(AppTheme.primary)
            .clipShape(Capsule())
    }
}
