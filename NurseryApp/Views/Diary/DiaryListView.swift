import SwiftUI
import SwiftData

struct DiaryListView: View {
    @Query(sort: \DiaryEntry.timestamp, order: .reverse) private var entries: [DiaryEntry]
    @StateObject private var viewModel = DiaryViewModel()
    @State private var animateCards = false

    private var filteredEntries: [DiaryEntry] {
        viewModel.filteredEntries(from: entries)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                headerSection
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
                        ForEach(Array(filteredEntries.enumerated()), id: \.element.id) { index, entry in
                            NavigationLink {
                                DiaryDetailView(entry: entry)
                            } label: {
                                DiaryRowCard(entry: entry)
                                    .opacity(animateCards ? 1 : 0)
                                    .offset(y: animateCards ? 0 : 12)
                                    .animation(
                                        .easeOut(duration: 0.3).delay(Double(index) * 0.04),
                                        value: animateCards
                                    )
                            }
                            .buttonStyle(.plain)
                            .accessibilityIdentifier("diaryEntry_\(entry.title)")
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
        .onAppear {
            animateCards = true
        }
        .onChange(of: viewModel.selectedFilter) { _, _ in
            animateCards = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                animateCards = true
            }
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Daily Updates")
                .font(.title3.bold())

            Text(viewModel.entryCountText(for: filteredEntries))
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var filterScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                filterChip(title: "All", isSelected: viewModel.selectedFilter == nil) {
                    viewModel.selectedFilter = nil
                }

                ForEach(DiaryEntryType.allCases, id: \.self) { type in
                    filterChip(title: type.rawValue, isSelected: viewModel.selectedFilter == type) {
                        viewModel.selectedFilter = type
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
