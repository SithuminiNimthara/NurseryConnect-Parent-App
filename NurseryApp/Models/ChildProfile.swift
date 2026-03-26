import Foundation
import SwiftData

@Model
final class ChildProfile: Identifiable {
    var id: UUID
    var childName: String
    var preferredName: String
    var dietaryNotes: String
    var medicalNotes: String
    var photoName: String?

    @Relationship(deleteRule: .cascade)
    var emergencyContacts: [EmergencyContact]

    @Relationship(deleteRule: .cascade)
    var authorisedCollectors: [AuthorisedCollector]

    @Relationship(deleteRule: .cascade)
    var consentSettings: ConsentSettings?

    init(
        id: UUID = UUID(),
        childName: String,
        preferredName: String,
        dietaryNotes: String,
        medicalNotes: String,
        photoName: String? = nil,
        emergencyContacts: [EmergencyContact] = [],
        authorisedCollectors: [AuthorisedCollector] = [],
        consentSettings: ConsentSettings? = nil
    ) {
        self.id = id
        self.childName = childName
        self.preferredName = preferredName
        self.dietaryNotes = dietaryNotes
        self.medicalNotes = medicalNotes
        self.photoName = photoName
        self.emergencyContacts = emergencyContacts
        self.authorisedCollectors = authorisedCollectors
        self.consentSettings = consentSettings
    }
}
