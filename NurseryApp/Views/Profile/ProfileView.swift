import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query private var profiles: [ChildProfile]

    var body: some View {
        Group {
            if let child = profiles.first {
                List {
                    Section {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(child.childName)
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("Preferred name: \(child.preferredName)")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 6)
                    }

                    Section("Care Information") {
                        LabeledContent("Dietary Notes") {
                            Text(child.dietaryNotes.isEmpty ? "Not provided" : child.dietaryNotes)
                                .multilineTextAlignment(.trailing)
                        }

                        LabeledContent("Medical Notes") {
                            Text(child.medicalNotes.isEmpty ? "Not provided" : child.medicalNotes)
                                .multilineTextAlignment(.trailing)
                        }
                    }

                    Section("Emergency Contacts") {
                        if child.emergencyContacts.isEmpty {
                            Text("No emergency contacts added")
                                .foregroundStyle(.secondary)
                        } else {
                            ForEach(child.emergencyContacts) { contact in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(contact.name)
                                        .font(.headline)
                                    Text(contact.relationship)
                                        .foregroundStyle(.secondary)
                                    Text(contact.phoneNumber)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }

                    Section("Authorised Collectors") {
                        if child.authorisedCollectors.isEmpty {
                            Text("No authorised collectors added")
                                .foregroundStyle(.secondary)
                        } else {
                            ForEach(child.authorisedCollectors) { collector in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(collector.name)
                                        .font(.headline)
                                    Text(collector.relationship)
                                        .foregroundStyle(.secondary)
                                    Text(collector.idReference)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }

                    Section("Manage") {
                        NavigationLink("Edit Profile") {
                            EditProfileView(child: child)
                        }

                        NavigationLink("Consent Settings") {
                            ConsentSettingsView(child: child)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(AppTheme.background)
                .navigationTitle("Child Profile")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                ContentUnavailableView("Profile not found", systemImage: "person.slash")
            }
        }
        .tint(AppTheme.primary)
    }
}

