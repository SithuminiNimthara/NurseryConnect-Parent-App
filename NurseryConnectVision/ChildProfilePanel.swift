import SwiftUI

struct ChildProfilePanel: View {
    var body: some View {
        VisionCard(title: "Child Profile", icon: "person.crop.circle.fill") {
            VStack(alignment: .leading, spacing: 14) {
                Text("Olivia")
                    .font(.title.bold())

                Text("Sunshine Room")
                    .foregroundStyle(.secondary)

                Label("Age: 2y 8m", systemImage: "birthday.cake.fill")
                Label("Mood: Happy", systemImage: "face.smiling.fill")
                Label("Attendance: Present", systemImage: "checkmark.circle.fill")
                Label("Keyworker: Emma", systemImage: "person.fill.badge.plus")
            }
            .font(.body)
        }
    }
}
