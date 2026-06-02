import SwiftUI
import Charts

struct ProgressItem: Identifiable {
    let id = UUID()
    let category: String
    let value: Int
}

struct LearningProgressPanel: View {
    let data: [ProgressItem] = [
        ProgressItem(category: "Communication", value: 35),
        ProgressItem(category: "Physical", value: 25),
        ProgressItem(category: "Social", value: 25),
        ProgressItem(category: "Creative", value: 15)
    ]

    var body: some View {
        VisionCard(title: "Learning Progress", icon: "chart.pie.fill", width: 520, height: 300) {
            Chart(data) { item in
                BarMark(
                    x: .value("Category", item.category),
                    y: .value("Progress", item.value)
                )
            }
            .frame(height: 190)

            Text("This week Olivia showed strong communication and creative learning progress.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
