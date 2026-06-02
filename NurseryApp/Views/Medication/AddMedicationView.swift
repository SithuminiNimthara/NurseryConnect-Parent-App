import SwiftUI
import SwiftData

struct AddMedicationView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var medicineName = ""
    @State private var dosage = ""
    @State private var time = Date()
    @State private var instructions = ""

    private var isValid: Bool {
        FormValidation.isNotBlank(medicineName) &&
        FormValidation.isNotBlank(dosage)
    }

    var body: some View {
        Form {
            Section("Medication Details") {
                TextField("Medicine Name", text: $medicineName)
                TextField("Dosage", text: $dosage)
                DatePicker("Time", selection: $time)
            }

            Section("Instructions") {
                TextField("Special instructions", text: $instructions, axis: .vertical)
                    .lineLimit(3...5)
            }
        }
        .navigationTitle("Add Medication")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveMedication()
                }
                .disabled(!isValid)
            }
        }
    }

    private func saveMedication() {
        let note = MedicationNote(
            medicineName: FormValidation.trimmed(medicineName),
            dosage: FormValidation.trimmed(dosage),
            time: time,
            instructions: FormValidation.trimmed(instructions)
        )

        context.insert(note)
        try? context.save()
        dismiss()
    }
}
