import SwiftUI

struct NurseryAreaPanel: View {
    let area: NurseryArea

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: area.icon)
                    .font(.title2)
                    .foregroundStyle(.purple)

                Text(area.rawValue)
                    .font(.title3.bold())
            }

            Text(area.description)
                .font(.caption)
                .foregroundStyle(.secondary)

            Divider()

            Text("Safety Note")
                .font(.headline)

            Text(area.safetyNote)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .frame(width: 280, height: 210)
        .glassBackgroundEffect()
    }
}
