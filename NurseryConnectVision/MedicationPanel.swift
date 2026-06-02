import SwiftUI

struct MedicationPanel: View {
    var body: some View {
        VisionCard(title: "Medication", icon: "pills.fill") {
            VStack(alignment: .leading, spacing: 14) {
                Text("Salbutamol Inhaler")
                    .font(.title3.bold())

                Text("2 puffs as needed")
                    .foregroundStyle(.secondary)

                HStack {
                    Text("Next dose")
                    Spacer()
                    Text("2:30 PM")
                        .font(.headline)
                        .foregroundStyle(.orange)
                }

                Divider()

                Label("Inhaler is in date", systemImage: "checkmark.circle.fill")
                Label("Labelled with Olivia’s name", systemImage: "tag.fill")
                Label("Parent consent on file", systemImage: "doc.text.fill")
            }
            .font(.body)
        }
    }
}
