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
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                filterScrollView

                if filteredEntries.isEmpty {
                    ContentUnavailableView(
                        "No Diary Entries",
                        systemImage: "book.closed",
                        description: Text("Meals, naps, activities, and mood updates will appear here.")
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.top, 40)
                } else {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredEntries) { entry in
                            NavigationLink {
                                DiaryDetailView(entry: entry)
                            } label: {
                                DiaryRowCard(entry: entry)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            .padding(.bottom, 20)
        }
        .background(AppTheme.background)
        .navigationTitle("Daily Diary")
        .navigationBarTitleDisplayMode(.inline)
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
            .padding(.vertical, 4)
        }
    }

    private func filterChip(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(isSelected ? AppTheme.primary : Color.gray.opacity(0.12))
                .foregroundStyle(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
    }
}
