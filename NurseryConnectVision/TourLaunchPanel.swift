import SwiftUI

struct TourLaunchPanel: View {
    let openAction: () -> Void
    let closeAction: () -> Void

    var body: some View {
        VisionCard(title: "Immersive Nursery Tour", icon: "cube.transparent.fill", width: 520, height: 300) {
            VStack(alignment: .leading, spacing: 18) {
                Text("Explore Sunshine Room as a spatial nursery environment.")
                    .font(.title3)

                Text("Parents can view the reading corner, play area, meal area, and rest area using floating 3D panels.")
                    .foregroundStyle(.secondary)

                HStack(spacing: 16) {
                    Button("Open Tour") {
                        openAction()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Close Tour") {
                        closeAction()
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}
