import SwiftUI

struct DiaryDetailView: View {
    let entry: DiaryEntry
    @State private var showContent = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                heroSection

                VStack(alignment: .leading, spacing: 10) {
                    Text(entry.title)
                        .font(.title)
                        .fontWeight(.bold)

                    HStack(spacing: 8) {
                        detailBadge(title: entry.type.rawValue, systemImage: icon(for: entry.type))
                        detailBadge(title: timePeriodText(from: entry.timestamp), systemImage: "clock")
                        detailBadge(title: entry.timestamp.formatted(date: .omitted, time: .shortened), systemImage: "calendar")
                    }

                    Text(entry.timestamp.formatted(date: .complete, time: .shortened))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                detailCard(
                    title: "Update Details",
                    systemImage: "doc.text",
                    content: entry.details
                )

                additionalInfoCard

                Spacer(minLength: 20)
            }
            .padding()
            .opacity(showContent ? 1 : 0)
            .offset(y: showContent ? 0 : 16)
            .animation(.easeOut(duration: 0.35), value: showContent)
        }
        .background(AppTheme.background)
        .navigationTitle("Entry Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            showContent = true
        }
    }

    private var heroSection: some View {
        ZStack(alignment: .bottomLeading) {
            if let photoName = entry.photoName, !photoName.isEmpty {
                Image(photoName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .clipped()
            } else {
                LinearGradient(
                    colors: [backgroundColor(for: entry.type), AppTheme.secondary],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .overlay(
                    Image(systemName: icon(for: entry.type))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(AppTheme.primary)
                )
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(entry.type.rawValue)
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.white.opacity(0.9))
                    .clipShape(Capsule())

                Text(highlightText())
                    .font(.headline)
                    .foregroundStyle(.white)
                    .shadow(radius: 3)
            }
            .padding()
        }
        .frame(height: 220)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppTheme.shadow, radius: 10, x: 0, y: 5)
    }

    private func detailCard(title: String, systemImage: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: systemImage)
                .font(.headline)
                .foregroundStyle(AppTheme.primary)

            Text(content)
                .font(.body)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(AppTheme.border, lineWidth: 1)
        )
        .shadow(color: AppTheme.shadow, radius: 8, x: 0, y: 4)
    }

    private var additionalInfoCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Additional Information")
                .font(.headline)

            infoRow(systemImage: "square.grid.2x2.fill", title: "Category", value: entry.type.rawValue)
            infoRow(systemImage: "clock.fill", title: "Time", value: entry.timestamp.formatted(date: .omitted, time: .shortened))
            infoRow(systemImage: "sun.max.fill", title: "Session", value: timePeriodText(from: entry.timestamp))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(AppTheme.border, lineWidth: 1)
        )
        .shadow(color: AppTheme.shadow, radius: 8, x: 0, y: 4)
    }

    private func infoRow(systemImage: String, title: String, value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .foregroundStyle(AppTheme.primary)
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }

            Spacer()
        }
    }

    private func detailBadge(title: String, systemImage: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: systemImage)
            Text(title)
        }
        .font(.caption.weight(.medium))
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(AppTheme.softBackground)
        .foregroundStyle(AppTheme.primary)
        .clipShape(Capsule())
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

    private func backgroundColor(for type: DiaryEntryType) -> Color {
        switch type {
        case .meal:
            return AppTheme.peach
        case .nap:
            return AppTheme.lilac
        case .activity:
            return AppTheme.lemon
        case .mood:
            return AppTheme.sky
        case .checkIn:
            return AppTheme.secondary
        case .checkOut:
            return AppTheme.softBackground
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

    private func highlightText() -> String {
        switch entry.type {
        case .meal:
            return "Meal record added"
        case .nap:
            return "Nap update recorded"
        case .activity:
            return "Activity update recorded"
        case .mood:
            return "Mood update recorded"
        case .checkIn:
            return "Arrival recorded"
        case .checkOut:
            return "Departure recorded"
        }
    }
}
