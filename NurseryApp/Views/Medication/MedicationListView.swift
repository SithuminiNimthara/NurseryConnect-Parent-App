import SwiftUI
import SwiftData

struct MedicationListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \MedicationNote.time, order: .forward) private var notes: [MedicationNote]

    @State private var showAddMedication = false

    var body: some View {
        List {
            Section {
                ForEach(notes) { note in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(note.medicineName)
                                .font(.headline)

                            Spacer()

                            Text(note.isGiven ? "Given" : "Pending")
                                .font(.caption.bold())
                                .foregroundStyle(note.isGiven ? .green : .orange)
                        }

                        Text("Dosage: \(note.dosage)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Text(note.time.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        if !note.instructions.isEmpty {
                            Text(note.instructions)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 6)
                    .swipeActions {
                        Button(note.isGiven ? "Pending" : "Given") {
                            note.isGiven.toggle()
                            try? context.save()
                        }
                        .tint(AppTheme.primary)

                        Button(role: .destructive) {
                            context.delete(note)
                            try? context.save()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }

            Section {
                Button {
                    showAddMedication = true
                } label: {
                    Label("Add Medication Note", systemImage: "plus")
                        .foregroundStyle(AppTheme.primary)
                }
            }
        }
        .navigationTitle("Medication Notes")
        .sheet(isPresented: $showAddMedication) {
            NavigationStack {
                AddMedicationView()
            }
        }
    }
}
