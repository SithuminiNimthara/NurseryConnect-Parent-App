import SwiftUI

struct NurseryZoneDetailPanel: View {
    let zone: NurseryZone
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            // Header
            HStack(spacing: 24) {
                ZStack {
                    Circle()
                        .fill(zone.themeColor.opacity(0.15))
                        .frame(width: 100, height: 100)
                    
                    Image(systemName: zone.icon)
                        .font(.system(size: 56))
                        .foregroundStyle(zone.themeColor)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(zone.rawValue)
                        .font(.system(size: 60, weight: .bold))
                    
                    Text("Today’s Experience for Olivia")
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                TagView(text: "Live Activity", color: .green)
            }
            
            Divider()
            
            // Detail Grid
            Grid(alignment: .leading, horizontalSpacing: 60, verticalSpacing: 50) {
                GridRow {
                    DetailSection(
                        title: "Activity Summary",
                        content: zone.todayActivity,
                        icon: "sun.max.fill"
                    )
                    DetailSection(
                        title: "Learning Value",
                        content: zone.learningValue,
                        icon: "graduationcap.fill"
                    )
                }
                
                GridRow {
                    DetailSection(
                        title: "Safety Note",
                        content: zone.safetyNote,
                        icon: "shield.fill"
                    )
                    DetailSection(
                        title: "Staff Supervision",
                        content: zone.staffNote,
                        icon: "person.badge.shield.checkered.fill"
                    )
                }
            }
            
            // Parent Value Footer
            HStack(spacing: 20) {
                Image(systemName: "hand.thumbsup.fill")
                    .font(.title)
                    .foregroundStyle(.purple)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Parent Benefit")
                        .font(.headline)
                        .foregroundStyle(.purple)
                    Text(zone.parentValue)
                        .font(.title3)
                }
            }
            .padding(32)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(zone.themeColor.opacity(0.1))
            .cornerRadius(20)
        }
        .padding(60)
        .frame(width: 1000)
        .glassBackgroundEffect()
    }
}

struct DetailSection: View {
    let title: String
    let content: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(.purple)
                Text(title)
                    .font(.title2.bold())
                    .foregroundStyle(.secondary)
            }
            
            Text(content)
                .font(.title3)
                .lineLimit(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TagView: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text.uppercased())
            .font(.caption2.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(color.opacity(0.2))
            .foregroundStyle(color)
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(color.opacity(0.3), lineWidth: 1)
            )
    }
}

#Preview {
    NurseryZoneDetailPanel(zone: .play)
}
