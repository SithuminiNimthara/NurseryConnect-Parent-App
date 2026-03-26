import SwiftUI

struct ContactRowCard: View {
    let name: String
    let subtitle: String
    let trailingText: String

    var body: some View {
        HStack(spacing: 12) {
            InitialsAvatarView(name: name, size: 42)

            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(trailingText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}
