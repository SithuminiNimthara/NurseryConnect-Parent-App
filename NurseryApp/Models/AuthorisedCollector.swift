import Foundation
import SwiftData

@Model
final class AuthorisedCollector: Identifiable {
    var id: UUID
    var name: String
    var relationship: String
    var idReference: String

    init(id: UUID = UUID(), name: String, relationship: String, idReference: String) {
        self.id = id
        self.name = name
        self.relationship = relationship
        self.idReference = idReference
    }
}
