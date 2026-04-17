import SwiftUI
import SwiftData

struct AddEmergencyContactView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Bindable var child: ChildProfile

    @State private var name = ""
    @State private var relationship = ""
    @State private var phoneNumber = ""

    @State private var errorMessage = ""
    @State private var showError = false
    @State private var showSuccess = false

    private var trimmedName: String { name.trimmingCharacters(in: .whitespacesAndNewlines) }
    private var trimmedRelationship: String { relationship.trimmingCharacters(in: .whitespacesAndNewlines) }
    private var trimmedPhone: String { phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines) }

    private var isValid: Bool {
        FormValidation.isNotBlank(name) &&
        FormValidation.isNotBlank(relationship) &&
        FormValidation.isValidPhone(phoneNumber)
    }

    var body: some View {
        Form {
            Section("Contact Details") {
                TextField("Full Name", text: $name)
                TextField("Relationship", text: $relationship)
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
            }

            Section {
                Text("Emergency contacts will be notified in urgent situations. Ensure numbers are accurate.")
                    .font(.footnote)
                    .foregroundStyle(AppTheme.primary)
            }
        }
        .navigationTitle("Add Contact")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    saveContact()
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
                .accessibilityIdentifier("saveButton")
            }
        }
        .alert("Check Your Input", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
        .alert("Contact Added", isPresented: $showSuccess) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("The emergency contact was saved successfully.")
        }
    }

    private func saveContact() {
        guard !trimmedName.isEmpty else {
            showValidationError("Please enter the contact name.")
            return
        }

        guard !trimmedRelationship.isEmpty else {
            showValidationError("Please enter the relationship.")
            return
        }

        guard FormValidation.isValidPhone(trimmedPhone) else {
            showValidationError("Phone number should contain 7 to 15 digits.")
            return
        }

        let contact = EmergencyContact(
            name: trimmedName,
            relationship: trimmedRelationship,
            phoneNumber: trimmedPhone
        )

        context.insert(contact)
        child.emergencyContacts.append(contact)

        do {
            try context.save()
            showSuccess = true
        } catch {
            showValidationError("Failed to save the emergency contact.")
        }
    }

    private func showValidationError(_ message: String) {
        errorMessage = message
        showError = true
    }
}
