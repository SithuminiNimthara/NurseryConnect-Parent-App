import Foundation
import SwiftData

@Model
final class MedicationNote: Identifiable {
    var id: UUID
    var medicineName: String
    var dosage: String
    var time: Date
    var instructions: String
    var isGiven: Bool

    init(
        id: UUID = UUID(),
        medicineName: String,
        dosage: String,
        time: Date,
        instructions: String,
        isGiven: Bool = false
    ) {
        self.id = id
        self.medicineName = medicineName
        self.dosage = dosage
        self.time = time
        self.instructions = instructions
        self.isGiven = isGiven
    }
}
