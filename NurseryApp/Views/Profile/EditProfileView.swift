import SwiftUI
import SwiftData

struct EditProfileView: View {
    @Bindable var child: ChildProfile
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var childName: String
    @State private var preferredName: String
    @State private var dietaryNotes: String
    @State private var medicalNotes: String

    @State private var showSavedAlert = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    init(child: ChildProfile) {
        self.child = child
        _childName = State(initialValue: child.childName)
        _preferredName = State(initialValue: child.preferredName)
        _dietaryNotes = State(initialValue: child.dietaryNotes)
        _medicalNotes = State(initialValue: child.medicalNotes)
    }

    private var isValid: Bool {
        FormValidation.isNotBlank(childName) &&
        FormValidation.isNotBlank(preferredName)
    }

    var body: some View {
        Form {
            Section("Basic Information") {
                TextField("Full Name", text: $childName)
                TextField("Preferred Name", text: $preferredName)
            }

            Section("Care Information") {
                TextField("Dietary Notes", text: $dietaryNotes, axis: .vertical)
                    .lineLimit(3...5)

                TextField("Medical Notes", text: $medicalNotes, axis: .vertical)
                    .lineLimit(3...5)
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveProfile()
                }
                .disabled(!isValid)
            }
        }
        .alert("Profile Updated", isPresented: $showSavedAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your changes were saved successfully.")
        }
        .alert("Unable to Save", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }

    private func saveProfile() {
        let trimmedChildName = FormValidation.trimmed(childName)
        let trimmedPreferredName = FormValidation.trimmed(preferredName)

        guard FormValidation.isNotBlank(trimmedChildName) else {
            errorMessage = "Please enter the child's full name."
            showErrorAlert = true
            return
        }

        guard FormValidation.isNotBlank(trimmedPreferredName) else {
            errorMessage = "Please enter the child's preferred name."
            showErrorAlert = true
            return
        }

        child.childName = trimmedChildName
        child.preferredName = trimmedPreferredName
        child.dietaryNotes = FormValidation.trimmed(dietaryNotes)
        child.medicalNotes = FormValidation.trimmed(medicalNotes)

        do {
            try context.save()
            showSavedAlert = true
        } catch {
            errorMessage = "Something went wrong while saving the profile."
            showErrorAlert = true
        }
    }
}
