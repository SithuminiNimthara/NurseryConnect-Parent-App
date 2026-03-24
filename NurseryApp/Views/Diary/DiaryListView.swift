import SwiftUI
import SwiftData

struct DiaryListView: View {
    @Query(sort: \DiaryEntry.timestamp, order: .reverse) private var entries: [DiaryEntry]
    @State private var selectedFilter: DiaryEntryType?

    private var filteredEntries: [DiaryEntry] {
        guard let selectedFilter else { return entries }
        return entries.filter { $0.type == selectedFilter }
    }

    var body: some View {
        VStack(spacing: 12) {
            filterScrollView

            if filteredEntries.isEmpty {
                ContentUnavailableView(
                    "No Diary Entries",
                    systemImage: "tray",
                    description: Text("There are no updates for this category.")
                )
                Spacer()
            } else {
                List(filteredEntries) { entry in
                    NavigationLink {
                        DiaryDetailView(entry: entry)
                    } label: {
                        HStack(spacing: 14) {
                            Image(systemName: icon(for: entry.type))
                                .foregroundStyle(AppTheme.primary)
                                .frame(width: 38, height: 38)
                                .background(AppTheme.primary.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.title)
                                    .font(.headline)

                                Text(entry.details)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)

                                Text(entry.timestamp.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
                .listStyle(.plain)
            }
        }
        .padding(.top, 8)
        .background(AppTheme.background)
        .navigationTitle("Daily Diary")
        .navigationBarTitleDisplayMode(.inline)
        .tint(AppTheme.primary)
    }

    private var filterScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                filterChip(title: "All", isSelected: selectedFilter == nil) {
                    selectedFilter = nil
                }

                ForEach(DiaryEntryType.allCases, id: \.self) { type in
                    filterChip(title: type.rawValue, isSelected: selectedFilter == type) {
                        selectedFilter = type
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private func filterChip(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(isSelected ? AppTheme.primary : Color.gray.opacity(0.12))
                .foregroundStyle(isSelected ? .white : .primary)
                .clipShape(Capsule())
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
