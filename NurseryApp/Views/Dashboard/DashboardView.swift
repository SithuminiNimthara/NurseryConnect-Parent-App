import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) private var context
    @Query private var profiles: [ChildProfile]
    @Query(sort: \DiaryEntry.timestamp, order: .reverse) private var entries: [DiaryEntry]

    @State private var animateContent = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    headerCard
                    todaySection
                    quickActionsSection
                }
                .padding()
                .opacity(animateContent ? 1 : 0)
                .offset(y: animateContent ? 0 : 16)
                .animation(.easeOut(duration: 0.45), value: animateContent)
            }
            .background(AppTheme.background)
            .navigationTitle("NurseryConnect")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                SampleData.seedIfNeeded(context: context, profiles: profiles, entries: entries)
                animateContent = true
            }
        }
    }

    private var child: ChildProfile? {
        profiles.first
    }

    private var latestDiaryCountText: String {
        let count = entries.count
        return count == 1 ? "1 update today" : "\(count) updates today"
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Welcome back")
                .font(.headline)
                .foregroundStyle(AppTheme.primary)

            if let child {
                HStack(spacing: 14) {
                    if let photoName = child.photoName, !photoName.isEmpty {
                        Image(photoName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 58, height: 58)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 46, height: 46)
                            .foregroundStyle(AppTheme.primary)
                            .frame(width: 58, height: 58)
                            .background(Color.white.opacity(0.55))
                            .clipShape(Circle())
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(child.preferredName)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)

                        Text("Parent / Guardian Dashboard")
                            .font(.subheadline)
                            .foregroundStyle(.primary.opacity(0.75))
                    }

                    Spacer()
                }
            } else {
                Text("No child profile available")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(AppTheme.secondary.opacity(0.75))
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    private var todaySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeaderView("Today at Nursery")

            SummaryCard(
                title: "Daily Diary",
                subtitle: latestDiaryCountText,
                systemImage: "book.closed"
            )

            SummaryCard(
                title: "Dietary Info",
                subtitle: child?.dietaryNotes.isEmpty == false ? child?.dietaryNotes ?? "" : "No dietary notes recorded",
                systemImage: "fork.knife"
            )

            SummaryCard(
                title: "Medical Info",
                subtitle: child?.medicalNotes.isEmpty == false ? child?.medicalNotes ?? "" : "No medical notes recorded",
                systemImage: "cross.case"
            )
        }
    }

    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeaderView("Quick Actions")

            NavigationLink {
                DiaryListView()
            } label: {
                PrimaryActionCard(
                    title: "View Daily Diary",
                    subtitle: "Meals, naps, activities",
                    systemImage: "doc.text.image"
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                ProfileView()
            } label: {
                PrimaryActionCard(
                    title: "Manage Profile",
                    subtitle: "Profile & consent",
                    systemImage: "person.crop.circle.badge.checkmark"
                )
            }
            .buttonStyle(.plain)
        }
    }
}
