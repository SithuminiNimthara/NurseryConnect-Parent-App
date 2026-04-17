import Foundation
import Combine

final class DiaryViewModel: ObservableObject {
    @Published var selectedFilter: DiaryEntryType? = nil

    func filteredEntries(from entries: [DiaryEntry]) -> [DiaryEntry] {
        guard let selectedFilter else { return entries }
        return entries.filter { $0.type == selectedFilter }
    }

    func timePeriodText(from date: Date) -> String {
        let hour = Calendar.current.component(.hour, from: date)

        switch hour {
        case 5..<12:
            return "Morning"
        case 12..<17:
            return "Afternoon"
        default:
            return "Evening"
        }
    }

    func entryCountText(for entries: [DiaryEntry]) -> String {
        switch entries.count {
        case 0:
            return "No diary entries"
        case 1:
            return "1 diary entry"
        default:
            return "\(entries.count) diary entries"
        }
    }
}
