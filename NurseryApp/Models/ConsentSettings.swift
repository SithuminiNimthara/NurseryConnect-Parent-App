import Foundation
import SwiftData

@Model
final class ConsentSettings {
    var id: UUID
    var photographyConsent: Bool
    var socialMediaConsent: Bool
    var medicalTreatmentConsent: Bool
    var gpsTrackingConsent: Bool

    init(
        id: UUID = UUID(),
        photographyConsent: Bool = true,
        socialMediaConsent: Bool = false,
        medicalTreatmentConsent: Bool = true,
        gpsTrackingConsent: Bool = true
    ) {
        self.id = id
        self.photographyConsent = photographyConsent
        self.socialMediaConsent = socialMediaConsent
        self.medicalTreatmentConsent = medicalTreatmentConsent
        self.gpsTrackingConsent = gpsTrackingConsent
    }
}
