import SwiftUI

enum NurseryZone: String, CaseIterable, Identifiable {
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

    var themeColor: Color {
        switch self {
        case .reading: return .purple
        case .play: return .orange
        case .meal: return .green
        case .rest: return .blue
        }
    }

    // What the child did today
    var todayActivity: String {
        switch self {
        case .reading:
            return "Olivia enjoyed reading 'The Very Hungry Caterpillar' and identifying different fruits."
        case .play:
            return "Olivia joined outdoor-style free play and built a large tower with soft blocks."
        case .meal:
            return "Olivia tried independent spoon-feeding today during lunch (Pasta Bolognese)."
        case .rest:
            return "Olivia had a peaceful 45-minute nap and woke up feeling refreshed."
        }
    }

    var safetyNote: String {
        switch self {
        case .reading:
            return "Soft seating, rounded shelf edges, and age-appropriate books."
        case .play:
            return "Shock-absorbent flooring and daily equipment safety checks."
        case .meal:
            return "High chairs secured and strict allergen-aware food preparation."
        case .rest:
            return "Constant visual monitoring and clear cot safety protocols."
        }
    }

    var learningValue: String {
        switch self {
        case .reading:
            return "Supports early literacy, focus, and language acquisition."
        case .play:
            return "Develops gross motor skills, teamwork, and creative thinking."
        case .meal:
            return "Encourages independence, fine motor control, and social manners."
        case .rest:
            return "Essential for emotional regulation and cognitive processing."
        }
    }

    var staffNote: String {
        switch self {
        case .reading:
            return "Guided by Sarah (Early Years Lead)."
        case .play:
            return "Supervised by Emma and the outdoor activity team."
        case .meal:
            return "Monitored by the dietary coordinator."
        case .rest:
            return "Sleep log maintained by the room lead."
        }
    }

    var parentValue: String {
        switch self {
        case .reading:
            return "Helps parents choose similar books for home reading time."
        case .play:
            return "Gives insight into the child's social preferences and energy levels."
        case .meal:
            return "Provides confidence in the child's nutritional intake and milestones."
        case .rest:
            return "Consistent sleep patterns support a better routine at home."
        }
    }

    var summary: String {
        switch self {
        case .reading:
            return "A calm, quiet space for language development."
        case .play:
            return "Active and creative development through movement."
        case .meal:
            return "Healthy nutrition and social skills development."
        case .rest:
            return "Restorative sleep and emotional well-being."
        }
    }
}
