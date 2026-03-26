import SwiftUI
import SwiftData

@main
struct NurseryAppApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .tint(AppTheme.primary)
        }
        .modelContainer(for: [
            ChildProfile.self,
            DiaryEntry.self,
            EmergencyContact.self,
            AuthorisedCollector.self,
            ConsentSettings.self
        ])
    }
}
