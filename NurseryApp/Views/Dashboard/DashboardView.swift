import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) private var context
    @Query private var profiles: [ChildProfile]
    @Query(sort: \DiaryEntry.timestamp, order: .reverse) private var diaryEntries: [DiaryEntry]

    var body: some View {
        NavigationStack {
            Group {
                if let child = profiles.first {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            dashboardHeader(for: child)

                            SectionHeaderView(
                                "Today at Nursery",
                                subtitle: "A quick summary of your child’s updates"
                            )

                            SummaryCard(
                                title: "Daily Diary",
                                subtitle: "\(diaryEntries.count) updates available today",
                                systemImage: "book.closed.fill"
                            )

                            SummaryCard(
                                title: "Dietary Information",
                                subtitle: child.dietaryNotes.isEmpty ? "No dietary notes available" : child.dietaryNotes,
                                systemImage: "fork.knife"
                            )

                            SummaryCard(
                                title: "Medical Information",
                                subtitle: child.medicalNotes.isEmpty ? "No medical notes available" : child.medicalNotes,
                                systemImage: "cross.case.fill"
                            )

                            SectionHeaderView(
                                "Quick Actions",
                                subtitle: "Manage your child’s information and view updates"
                            )

                            VStack(spacing: 14) {
                                NavigationLink {
                                    DiaryListView()
                                } label: {
                                    actionButtonLabel(
                                        title: "View Daily Diary",
                                        subtitle: "See meals, naps, activities and more",
                                        icon: "list.bullet.rectangle.portrait.fill"
                                    )
                                }

                                NavigationLink {
                                    ProfileView()
                                } label: {
                                    actionButtonLabel(
                                        title: "Manage Profile",
                                        subtitle: "Update profile details and consent settings",
                                        icon: "person.text.rectangle.fill"
                                    )
                                }
                            }
                        }
                        .padding()
                    }
                    .background(AppTheme.background)
                } else {
                    ContentUnavailableView(
                        "No Child Profile Found",
                        systemImage: "person.crop.circle.badge.exclamationmark",
                        description: Text("Please check your saved data.")
                    )
                }
            }
            .navigationTitle("NurseryConnect")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                SampleData.insertIfNeeded(context: context)
            }
        }
        .tint(AppTheme.primary)
    }

    @ViewBuilder
    private func dashboardHeader(for child: ChildProfile) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Welcome Back")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(child.preferredName)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Parent / Guardian Dashboard")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: [
                    AppTheme.primary.opacity(0.20),
                    AppTheme.accent.opacity(0.10)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    @ViewBuilder
    private func actionButtonLabel(title: String, subtitle: String, icon: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 50, height: 50)
                .background(AppTheme.primary)
                .clipShape(RoundedRectangle(cornerRadius: 14))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

