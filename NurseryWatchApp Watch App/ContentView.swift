import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                headerSection

                statusCard(
                    title: "Latest Update",
                    value: "Lunch completed",
                    icon: "fork.knife"
                )

                statusCard(
                    title: "Medication",
                    value: "Penadol pending",
                    icon: "cross.case.fill"
                )

                statusCard(
                    title: "Pickup Note",
                    value: "Aunt Emma authorised",
                    icon: "person.badge.key.fill"
                )
            }
            .padding()
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("NurseryConnect")
                .font(.headline)

            Text("Ollie")
                .font(.title2.bold())

            Text("Parent Watch Companion")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func statusCard(title: String, value: String, icon: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(.purple)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.subheadline.bold())
            }

            Spacer()
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    ContentView()
}
