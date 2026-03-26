import Foundation
import SwiftData

enum DiaryEntryType: String, Codable, CaseIterable {
    case meal = "Meal"
    case nap = "Nap"
    case activity = "Activity"
    case mood = "Mood"
    case checkIn = "Check-In"
    case checkOut = "Check-Out"
}

@Model
final class DiaryEntry: Identifiable {
    var id: UUID
    var title: String
    var details: String
    var timestamp: Date
    var typeRawValue: String
    var photoName: String?

    var type: DiaryEntryType {
        get { DiaryEntryType(rawValue: typeRawValue) ?? .activity }
        set { typeRawValue = newValue.rawValue }
    }

    init(
        id: UUID = UUID(),
        title: String,
        details: String,
        timestamp: Date,
        type: DiaryEntryType,
        photoName: String? = nil
    ) {
        self.id = id
        self.title = title
        self.details = details
        self.timestamp = timestamp
        self.typeRawValue = type.rawValue
        self.photoName = photoName
    }
}
