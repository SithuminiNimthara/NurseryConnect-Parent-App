import SwiftUI

struct EditProfileView: View {
    @Bindable var child: ChildProfile
    @Environment(\.dismiss) private var dismiss
    @State private var showSavedAlert = false

    var body: some View {
        Form {
            Section("Basic Information") {
                TextField("Full Name", text: $child.childName)
                TextField("Preferred Name", text: $child.preferredName)
            }

            Section("Care Information") {
                TextField("Dietary Notes", text: $child.dietaryNotes, axis: .vertical)
                    .lineLimit(3...5)

                TextField("Medical Notes", text: $child.medicalNotes, axis: .vertical)
                    .lineLimit(3...5)
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    showSavedAlert = true
                }
                .foregroundStyle(AppTheme.primary)
            }
        }
        .alert("Profile Updated", isPresented: $showSavedAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your profile details were saved successfully.")
        }
        .tint(AppTheme.primary)
    }
}

