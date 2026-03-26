import Foundation
import SwiftData

@Model
final class EmergencyContact: Identifiable {
    var id: UUID
    var name: String
    var relationship: String
    var phoneNumber: String

    init(id: UUID = UUID(), name: String, relationship: String, phoneNumber: String) {
        self.id = id
        self.name = name
        self.relationship = relationship
        self.phoneNumber = phoneNumber
    }
}
