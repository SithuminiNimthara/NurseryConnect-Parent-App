import Foundation
import SwiftData

@Model
final class ChildProfile {
    var id: UUID
    var childName: String
    var preferredName: String
    var dietaryNotes: String
    var medicalNotes: String

    @Relationship(deleteRule: .cascade)
    var emergencyContacts: [EmergencyContact]

    @Relationship(deleteRule: .cascade)
    var authorisedCollectors: [AuthorisedCollector]

    var consentSettings: ConsentSettings?

    init(
        id: UUID = UUID(),
        childName: String,
        preferredName: String,
        dietaryNotes: String,
        medicalNotes: String,
        emergencyContacts: [EmergencyContact] = [],
        authorisedCollectors: [AuthorisedCollector] = [],
        consentSettings: ConsentSettings? = nil
    ) {
        self.id = id
        self.childName = childName
        self.preferredName = preferredName
        self.dietaryNotes = dietaryNotes
        self.medicalNotes = medicalNotes
        self.emergencyContacts = emergencyContacts
        self.authorisedCollectors = authorisedCollectors
        self.consentSettings = consentSettings
    }
}
