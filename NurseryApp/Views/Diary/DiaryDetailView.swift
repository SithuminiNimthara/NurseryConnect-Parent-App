import SwiftUI

struct DiaryDetailView: View {
    let entry: DiaryEntry

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                heroImage

                VStack(alignment: .leading, spacing: 8) {
                    Text(entry.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(entry.type.rawValue)
                        .font(.headline)
                        .foregroundStyle(AppTheme.primary)

                    Text(entry.timestamp.formatted(date: .complete, time: .shortened))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 10) {
                    SectionHeaderView("Details")

                    Text(entry.details)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(AppTheme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(AppTheme.border, lineWidth: 1)
                        )
                }

                VStack(alignment: .leading, spacing: 10) {
                    SectionHeaderView("Entry Summary")

                    HStack(spacing: 8) {
                        TagChip(title: entry.type.rawValue)
                        TagChip(title: timePeriodText(from: entry.timestamp))
                        if entry.photoName != nil {
                            TagChip(title: "Photo attached")
                        }
                    }
                }

                Spacer(minLength: 10)
            }
            .padding()
        }
        .background(AppTheme.background)
        .navigationTitle("Entry Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var heroImage: some View {
        if let photoName = entry.photoName, !photoName.isEmpty {
            Image(photoName)
                .resizable()
                .scaledToFill()
                .frame(height: 190)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 18))
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(AppTheme.softBackground)

                Image(systemName: heroIcon(for: entry.type))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56, height: 56)
                    .foregroundStyle(AppTheme.primary)
            }
            .frame(height: 190)
        }
    }

    private func heroIcon(for type: DiaryEntryType) -> String {
        switch type {
        case .meal:
            return "fork.knife"
        case .nap:
            return "bed.double.fill"
        case .activity:
            return "paintpalette"
        case .mood:
            return "face.smiling"
        case .checkIn:
            return "arrow.down.circle"
        case .checkOut:
            return "arrow.up.circle"
        }
    }

    private func timePeriodText(from date: Date) -> String {
        let hour = Calendar.current.component(.hour, from: date)
        switch hour {
        case 5..<12:
            return "Morning"
        case 12..<17:
            return "Afternoon"
        default:
            return "Evening"
        }
    }
}
