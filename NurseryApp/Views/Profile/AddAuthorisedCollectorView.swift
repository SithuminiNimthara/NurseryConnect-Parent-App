import SwiftUI
import SwiftData

struct AddAuthorisedCollectorView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Bindable var child: ChildProfile

    @State private var name = ""
    @State private var relationship = ""
    @State private var idReference = ""

    @State private var errorMessage = ""
    @State private var showError = false
    @State private var showSuccess = false

    private var trimmedName: String { name.trimmingCharacters(in: .whitespacesAndNewlines) }
    private var trimmedRelationship: String { relationship.trimmingCharacters(in: .whitespacesAndNewlines) }
    private var trimmedIDReference: String { idReference.trimmingCharacters(in: .whitespacesAndNewlines) }

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

            Section {
                Text("An ID reference is required for safeguarding. Collectors must show this ID at pick-up.")
                    .font(.footnote)
                    .foregroundStyle(AppTheme.primary)
            }
        }
        .navigationTitle("Add Collector")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }
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
                }
                .disabled(!isValid)
            }
        }
        .alert("Check Your Input", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
        .alert("Collector Added", isPresented: $showSuccess) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("The authorised collector was saved successfully.")
        }
    }

    private func saveCollector() {
        guard !trimmedName.isEmpty else {
            showValidationError("Please enter the collector name.")
            return
        }

        guard !trimmedRelationship.isEmpty else {
            showValidationError("Please enter the relationship.")
            return
        }

        guard !trimmedIDReference.isEmpty else {
            showValidationError("Please enter an ID reference.")
            return
        }

        let collector = AuthorisedCollector(
            name: trimmedName,
            relationship: trimmedRelationship,
            idReference: trimmedIDReference
        )

        context.insert(collector)
        child.authorisedCollectors.append(collector)

        do {
            try context.save()
            showSuccess = true
        } catch {
            showValidationError("Failed to save the authorised collector.")
        }
    }

    private func showValidationError(_ message: String) {
        errorMessage = message
        showError = true
    }
}
