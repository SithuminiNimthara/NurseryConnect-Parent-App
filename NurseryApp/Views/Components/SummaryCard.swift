import SwiftUI

struct SummaryCard: View {
    let title: String
    let subtitle: String
    let systemImage: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundStyle(AppTheme.primary)
                .frame(width: 50, height: 50)
                .background(AppTheme.softBackground)
                .clipShape(RoundedRectangle(cornerRadius: 14))

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Spacer()
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

