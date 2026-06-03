import SwiftUI
import Charts

struct VisionHomeView: View {
    @Environment(VisionAppModel.self) private var appModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        VStack(spacing: 32) {
            header
                .padding(.bottom, 12)

            HStack(spacing: 32) {
                ChildProfilePanel()
                MedicationPanel()
                DiaryPanel()
            }

            HStack(spacing: 32) {
                LearningProgressPanel()
                TourLaunchPanel(
                    openAction: openTour,
                    closeAction: closeTour
                )
            }
        }
        .padding(60)
        .background {
            LinearGradient(
                colors: [
                    Color.purple.opacity(0.12),
                    Color.orange.opacity(0.08),
                    Color.white.opacity(0.2)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("NurseryConnect Vision")
                    .font(.system(size: 56, weight: .black)) // More prominent
                
                Text("Spatial Parent Dashboard • Live Nursery Experience")
                    .font(.title)
                    .foregroundStyle(.secondary)
                    .fontWeight(.medium)
            }

            Spacer()

            if appModel.immersiveSpaceOpen {
                Button(role: .destructive, action: closeTour) {
                    Label("Close Tour", systemImage: "xmark.circle.fill")
                        .padding()
                }
                .controlSize(.extraLarge)
            } else {
                Button(action: openTour) {
                    Label("Enter Nursery Tour", systemImage: "visionpro")
                        .padding()
                }
                .controlSize(.extraLarge)
                .buttonStyle(.borderedProminent)
                .tint(.purple)
            }
        }
    }

    private func openTour() {
        Task {
            if !appModel.immersiveSpaceOpen {
                await openImmersiveSpace(id: "NurseryTour")
                appModel.immersiveSpaceOpen = true
            }
        }
    }

    private func closeTour() {
        Task {
            if appModel.immersiveSpaceOpen {
                await dismissImmersiveSpace()
                appModel.immersiveSpaceOpen = false
            }
        }
    }
}
