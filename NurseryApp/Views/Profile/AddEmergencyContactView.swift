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
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveContact()
                }
                .foregroundStyle(AppTheme.primary)
                .disabled(!isValid)
            }
        }
        .alert("Check Your Input", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
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

        let digitsOnly = trimmedPhone.filter(\.isNumber)

        guard !digitsOnly.isEmpty else {
            showValidationError("Please enter a valid phone number.")
            return
        }

        guard digitsOnly.count >= 7 && digitsOnly.count <= 15 else {
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
            dismiss()
        } catch {
            showValidationError("Failed to save the emergency contact.")
        }
    }

    private func showValidationError(_ message: String) {
        errorMessage = message
        showError = true
    }
}
