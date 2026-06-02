import SwiftUI

@Observable
class VisionAppModel {
    var immersiveSpaceOpen = false
    var selectedArea: NurseryArea? = nil
}

enum NurseryArea: String, CaseIterable, Identifiable {
    case reading = "Reading Corner"
    case play = "Play Area"
    case meal = "Meal Area"
    case rest = "Rest Area"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .reading: return "book.fill"
        case .play: return "teddybear.fill"
        case .meal: return "fork.knife"
        case .rest: return "moon.zzz.fill"
        }
    }

    var description: String {
        switch self {
        case .reading:
            return "A calm space where children listen to stories and develop early language skills."
        case .play:
            return "An active area for creative play, movement, and social development."
        case .meal:
            return "A supervised space for healthy meals, snacks, and hydration tracking."
        case .rest:
            return "A quiet rest area used for nap time and calm emotional regulation."
        }
    }

    var safetyNote: String {
        switch self {
        case .reading:
            return "Soft seating, safe shelves, and supervised reading sessions."
        case .play:
            return "Toys are age-appropriate and checked daily."
        case .meal:
            return "Allergy notes and meal records are monitored."
        case .rest:
            return "Children are checked regularly during rest periods."
        }
    }
}
