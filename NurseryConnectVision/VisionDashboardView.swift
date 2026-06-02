import SwiftUI

struct VisionDashboardView: View {
    var body: some View {
        HStack(spacing: 30) {
            VisionCard(title: "Child Summary", icon: "person.crop.circle.fill") {
                Text("Olivia")
                    .font(.title.bold())
                Text("Sunshine Room")
                Text("Mood: Happy")
                Text("Meals: Great")
                Text("Sleep: 2h 15m")
                Text("Activities: 4")
            }

            VisionCard(title: "Medication", icon: "pills.fill") {
                Text("Salbutamol Inhaler")
                    .font(.title3.bold())
                Text("2 puffs as needed")
                Text("Next dose: 2:30 PM")
                    .foregroundStyle(.orange)
                Text("Parent consent on file")
            }

            VisionCard(title: "Daily Diary", icon: "book.fill") {
                Text("9:15 AM - Morning Circle")
                Text("11:30 AM - Outdoor Play")
                Text("1:00 PM - Lunch")
                Text("Olivia had a wonderful day!")
            }
        }
        .padding(40)
    }
}
