import SwiftUI
import SwiftData

struct EditAuthorisedCollectorView: View {
    @Bindable var collector: AuthorisedCollector
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var name: String
    @State private var relationship: String
    @State private var idReference: String

    @State private var showSavedAlert = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    init(collector: AuthorisedCollector) {
        self.collector = collector
        _name = State(initialValue: collector.name)
        _relationship = State(initialValue: collector.relationship)
        _idReference = State(initialValue: collector.idReference)
    }

    private var isValid: Bool {
        FormValidation.isNotBlank(name) &&
        FormValidation.isNotBlank(relationship) &&
        FormValidation.isNotBlank(idReference)
    }

    var body: some View {
        Form {
            Section("Collector Details") {
                TextField("Full Name", text: $name)
                TextField("Relationship", text: $relationship)
                TextField("ID Reference", text: $idReference)
            }
        }
        .navigationTitle("Edit Collector")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    saveCollector()
                } label: {
                    Text("Save")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(isValid ? AppTheme.primary : Color.gray.opacity(0.35))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .animation(.easeInOut(duration: 0.2), value: isValid)
                }
                .disabled(!isValid)
            }
        }
        .alert("Collector Updated", isPresented: $showSavedAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("The authorised collector was updated successfully.")
        }
        .alert("Unable to Save", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }

    private func saveCollector() {
        let trimmedName = FormValidation.trimmed(name)
        let trimmedRelationship = FormValidation.trimmed(relationship)
        let trimmedID = FormValidation.trimmed(idReference)

        guard FormValidation.isNotBlank(trimmedName) else {
            errorMessage = "Please enter the collector name."
            showErrorAlert = true
            return
        }

        guard FormValidation.isNotBlank(trimmedRelationship) else {
            errorMessage = "Please enter the relationship."
            showErrorAlert = true
            return
        }

        guard FormValidation.isNotBlank(trimmedID) else {
            errorMessage = "Please enter the ID reference."
            showErrorAlert = true
            return
        }

        collector.name = trimmedName
        collector.relationship = trimmedRelationship
        collector.idReference = trimmedID

        do {
            try context.save()
            showSavedAlert = true
        } catch {
            errorMessage = "Something went wrong while saving the collector."
            showErrorAlert = true
        }
    }
}
