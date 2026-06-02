import SwiftUI
import SwiftData

@main
struct NurseryAppApp: App {  
    var body: some Scene {
        WindowGroup {
            iPadDashboardView()
                .tint(AppTheme.primary)
        }
        .modelContainer(for: [
            ChildProfile.self,
            DiaryEntry.self,
            EmergencyContact.self,
            AuthorisedCollector.self,
            ConsentSettings.self,
            MedicationNote.self
        ])
    }
}
