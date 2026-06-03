import SwiftUI

struct TourLaunchPanel: View {
    let openAction: () -> Void
    let closeAction: () -> Void

    var body: some View {
        VisionCard(title: "Spatial Immersion", icon: "visionpro", width: 520, height: 300) {
            VStack(alignment: .leading, spacing: 20) {
                Text("Step into Olivia's World")
                    .font(.system(size: 32, weight: .bold))
                
                Text("Experience the Sunshine Room as a realistic 3D environment. Interact with floating panels to see exactly how Olivia learns, plays, and rests.")
                    .font(.body)
                    .foregroundStyle(.secondary)

                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: openAction) {
                        Text("Launch Immersive Tour")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
                    .controlSize(.large)
                }
            }
        }
    }
}
