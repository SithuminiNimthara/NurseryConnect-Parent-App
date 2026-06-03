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
        VisionCard(title: "Learning Progress", icon: "chart.bar.xaxis", width: 520, height: 320) {
            Chart(data) { item in
                BarMark(
                    x: .value("Category", item.category),
                    y: .value("Progress", item.value),
                    width: 40
                )
                .foregroundStyle(by: .value("Category", item.category))
                .cornerRadius(8)
            }
            .chartLegend(.hidden)
            .frame(height: 180)
            .padding(.top, 10)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Circle().fill(.purple).frame(width: 8, height: 8)
                    Text("Top Insight:").bold()
                    Text("Olivia’s vocabulary is expanding rapidly through group activities.")
                }
                .font(.caption)
                
                Text("Based on Early Years Foundation Stage (EYFS) 2024 standards.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 10)
        }
    }
}
