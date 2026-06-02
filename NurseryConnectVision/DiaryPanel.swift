import SwiftUI

struct DiaryPanel: View {
    var body: some View {
        VisionCard(title: "Daily Diary", icon: "book.fill") {
            VStack(alignment: .leading, spacing: 16) {
                DiaryRow(time: "9:15 AM", title: "Morning Circle", note: "Joined songs and stories.")
                DiaryRow(time: "11:30 AM", title: "Outdoor Play", note: "Played in the garden.")
                DiaryRow(time: "1:00 PM", title: "Lunch", note: "Ate pasta and vegetables.")
            }
        }
    }
}

struct DiaryRow: View {
    let time: String
    let title: String
    let note: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(time)
                .font(.caption)
                .foregroundStyle(.purple)

            Text(title)
                .font(.headline)

            Text(note)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
