import SwiftUI

struct DiaryDetailView: View {
    let entry: DiaryEntry

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
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

                Divider()

                SectionHeaderView("Details")

                Text(entry.details)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(AppTheme.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 3)

                Spacer()
            }
            .padding()
        }
        .background(AppTheme.background)
        .navigationTitle("Entry Details")
        .navigationBarTitleDisplayMode(.inline)
        .tint(AppTheme.primary)
    }
}

