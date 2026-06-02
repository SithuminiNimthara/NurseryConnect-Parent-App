import SwiftUI

@main
struct NurseryConnectVisionApp: App {
    @State private var appModel = VisionAppModel()

    var body: some Scene {
        WindowGroup {
            VisionHomeView()
                .environment(appModel)
        }
        .defaultSize(width: 1200, height: 750)

        ImmersiveSpace(id: "NurseryTour") {
            ImmersiveNurseryTourView()
                .environment(appModel)
        }
    }
}
