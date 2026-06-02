import SwiftUI
import Charts

struct DiarySummaryChartView: View {
    let entries: [DiaryEntry]

    private var chartData: [(type: String, count: Int)] {
        DiaryEntryType.allCases.map { type in
            (
                type: type.rawValue,
                count: entries.filter { $0.type == type }.count
            )
        }
        .filter { $0.count > 0 }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Daily Activity Summary")
                        .font(.headline)

                    Text("Diary entries grouped by update type")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "chart.bar.xaxis")
                    .font(.title3)
                    .foregroundStyle(AppTheme.primary)
            }

            if chartData.isEmpty {
                ContentUnavailableView(
                    "No Chart Data",
                    systemImage: "chart.bar",
                    description: Text("Diary updates will appear here once added.")
                )
                .frame(height: 180)
            } else {
                Chart(chartData, id: \.type) { item in
                    BarMark(
                        x: .value("Type", item.type),
                        y: .value("Count", item.count)
                    )
                    .foregroundStyle(AppTheme.primary.gradient)
                    .cornerRadius(6)

                    RuleMark(y: .value("Zero", 0))
                        .foregroundStyle(.secondary.opacity(0.2))
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .chartXAxis {
                    AxisMarks { value in
                        AxisGridLine()
                        AxisValueLabel()
                    }
                }
                .frame(height: 220)
                .accessibilityLabel("Daily activity summary chart")
            }
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(AppTheme.border, lineWidth: 1)
        )
        .shadow(color: AppTheme.shadow, radius: 10, x: 0, y: 5)
    }
}
