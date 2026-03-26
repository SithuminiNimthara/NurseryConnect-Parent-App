import SwiftUI

struct DiaryRowCard: View {
    let entry: DiaryEntry

    var body: some View {
        HStack(spacing: 14) {
            thumbnail

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(entry.details)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                Text(entry.timestamp.formatted(date: .omitted, time: .shortened))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppTheme.border, lineWidth: 1)
        )
    }

    @ViewBuilder
    private var thumbnail: some View {
        if let photoName = entry.photoName, !photoName.isEmpty {
            Image(photoName)
                .resizable()
                .scaledToFill()
                .frame(width: 52, height: 52)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        } else {
            Image(systemName: icon(for: entry.type))
                .foregroundStyle(AppTheme.primary)
                .frame(width: 52, height: 52)
                .background(AppTheme.softBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private func icon(for type: DiaryEntryType) -> String {
        switch type {
        case .meal:
            return "fork.knife"
        case .nap:
            return "bed.double.fill"
        case .activity:
            return "figure.play"
        case .mood:
            return "face.smiling.fill"
        case .checkIn:
            return "arrow.down.circle.fill"
        case .checkOut:
            return "arrow.up.circle.fill"
        }
    }
}
