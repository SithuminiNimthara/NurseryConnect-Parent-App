import SwiftUI
import SwiftData

struct EditEmergencyContactView: View {
    @Bindable var contact: EmergencyContact
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var name: String
    @State private var relationship: String
    @State private var phoneNumber: String

    @State private var showSavedAlert = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    init(contact: EmergencyContact) {
        self.contact = contact
        _name = State(initialValue: contact.name)
        _relationship = State(initialValue: contact.relationship)
        _phoneNumber = State(initialValue: contact.phoneNumber)
    }

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
        }
        .navigationTitle("Edit Emergency Contact")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
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
                        .animation(.easeInOut(duration: 0.2), value: isValid)
                }
                .disabled(!isValid)
            }
        }
        .alert("Contact Updated", isPresented: $showSavedAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("The emergency contact was updated successfully.")
        }
        .alert("Unable to Save", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }

    private func saveContact() {
        let trimmedName = FormValidation.trimmed(name)
        let trimmedRelationship = FormValidation.trimmed(relationship)
        let trimmedPhone = FormValidation.trimmed(phoneNumber)

        guard FormValidation.isNotBlank(trimmedName) else {
            errorMessage = "Please enter the contact name."
            showErrorAlert = true
            return
        }

        guard FormValidation.isNotBlank(trimmedRelationship) else {
            errorMessage = "Please enter the relationship."
            showErrorAlert = true
            return
        }

        guard FormValidation.isValidPhone(trimmedPhone) else {
            errorMessage = "Please enter a valid phone number."
            showErrorAlert = true
            return
        }

        contact.name = trimmedName
        contact.relationship = trimmedRelationship
        contact.phoneNumber = trimmedPhone

        do {
            try context.save()
            showSavedAlert = true
        } catch {
            errorMessage = "Something went wrong while saving the contact."
            showErrorAlert = true
        }
    }
}
