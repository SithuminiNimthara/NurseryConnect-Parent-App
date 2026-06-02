import SwiftUI
import Charts

struct VisionHomeView: View {
    @Environment(VisionAppModel.self) private var appModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        VStack(spacing: 28) {
            header

            HStack(spacing: 28) {
                ChildProfilePanel()
                MedicationPanel()
                DiaryPanel()
            }

            HStack(spacing: 28) {
                LearningProgressPanel()
                TourLaunchPanel(
                    openAction: openTour,
                    closeAction: closeTour
                )
            }
        }
        .padding(40)
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
            VStack(alignment: .leading, spacing: 8) {
                Text("NurseryConnect Vision")
                    .font(.largeTitle.bold())

                Text("Spatial parent dashboard for Olivia’s nursery day")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "visionpro.fill")
                .font(.system(size: 42))
                .foregroundStyle(.purple)
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
