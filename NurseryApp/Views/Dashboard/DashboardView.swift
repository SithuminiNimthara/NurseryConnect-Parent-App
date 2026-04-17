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

    private var latestEntry: DiaryEntry? {
        entries.first
    }

    private var latestDiaryCountText: String {
        switch entries.count {
        case 0:
            return "No updates yet today"
        case 1:
            return "1 update available today"
        default:
            return "\(entries.count) updates available today"
        }
    }

    private var headerCard: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 28)
                .fill(
                    LinearGradient(
                        colors: [AppTheme.secondary, AppTheme.peach],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Circle()
                .fill(AppTheme.accent.opacity(0.18))
                .frame(width: 120, height: 120)
                .offset(x: 30, y: -30)

            VStack(alignment: .leading, spacing: 18) {
                Text("Welcome back")
                    .font(.headline)
                    .foregroundStyle(AppTheme.primary)

                if let child {
                    HStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.9))
                                .frame(width: 64, height: 64)

                            if let photoName = child.photoName, !photoName.isEmpty {
                                Image(photoName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 58, height: 58)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 34, height: 34)
                                    .foregroundStyle(AppTheme.primary)
                            }
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(child.preferredName)
                                .font(.title2.bold())

                            Text("Parent / Guardian Dashboard")
                                .font(.subheadline)
                                .foregroundStyle(AppTheme.mutedText)
                        }

                        Spacer()
                    }

                    HStack(spacing: 10) {
                        smallBadge("Diary Updates")
                        smallBadge("Profile Ready")
                    }
                } else {
                    Text("No child profile available")
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 185)
        .shadow(color: AppTheme.shadow, radius: 12, x: 0, y: 6)
    }

    private func smallBadge(_ text: String) -> some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(Color.white.opacity(0.8))
            .clipShape(Capsule())
    }

    private var todaySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeaderView("Today at Nursery")

            SummaryCard(
                title: "Daily Diary",
                subtitle: latestDiaryCountText,
                systemImage: "book.closed"
            )

            if let latestEntry {
                SummaryCard(
                    title: "Latest Update",
                    subtitle: latestEntry.title,
                    systemImage: "clock.arrow.circlepath"
                )
            }

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
                    systemImage: "doc.text.image",
                    accessibilityID: "diaryButton"
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                ProfileView()
            } label: {
                PrimaryActionCard(
                    title: "Manage Profile",
                    subtitle: "Profile & consent",
                    systemImage: "person.crop.circle.badge.checkmark",
                    accessibilityID: "profileButton"
                )
            }
            .buttonStyle(.plain)
        }
    }
}
