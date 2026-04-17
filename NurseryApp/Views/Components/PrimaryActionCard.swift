import SwiftUI

struct PrimaryActionCard: View {
    let title: String
    let subtitle: String
    let systemImage: String
    var accessibilityID: String? = nil

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppTheme.primary)

                Image(systemName: systemImage)
                    .font(.title3)
                    .foregroundStyle(.white)
            }
            .frame(width: 54, height: 54)

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.mutedText)
            }

            Spacer()

            ZStack {
                Circle()
                    .fill(AppTheme.softBackground)
                    .frame(width: 34, height: 34)

                Image(systemName: "arrow.right")
                    .font(.footnote.weight(.bold))
                    .foregroundStyle(AppTheme.primary)
            }
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(AppTheme.border, lineWidth: 1)
        )
        .shadow(color: AppTheme.shadow, radius: 10, x: 0, y: 5)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(accessibilityID ?? "")
    }
}
