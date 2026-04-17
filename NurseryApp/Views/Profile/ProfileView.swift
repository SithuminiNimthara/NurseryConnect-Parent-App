import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) private var context
    @Query private var profiles: [ChildProfile]

    @State private var showAddEmergencyContact = false
    @State private var showAddCollector = false

    @State private var selectedEmergencyContact: EmergencyContact?
    @State private var selectedCollector: AuthorisedCollector?

    @State private var contactToDelete: EmergencyContact?
    @State private var collectorToDelete: AuthorisedCollector?

    @State private var showDeleteErrorAlert = false
    @State private var deleteErrorMessage = ""

    var body: some View {
        Group {
            if let child = profiles.first {
                List {
                    Section {
                        ProfileHeaderCard(child: child)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                    }

                    Section {
                        VStack(alignment: .leading, spacing: 14) {
                            SectionHeaderView("Care Information")

                            VStack(alignment: .leading, spacing: 14) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Dietary Notes")
                                        .font(.subheadline.weight(.semibold))

                                    Text(child.dietaryNotes.isEmpty ? "Not provided" : child.dietaryNotes)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }

                                Divider()

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Medical Notes")
                                        .font(.subheadline.weight(.semibold))

                                    Text(child.medicalNotes.isEmpty ? "Not provided" : child.medicalNotes)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding()
                            .background(AppTheme.cardBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(AppTheme.border, lineWidth: 1)
                            )
                        }
                    }
                    .listRowBackground(Color.clear)

                    Section {
                        VStack(alignment: .leading, spacing: 10) {
                            SectionHeaderView("Emergency Contacts")

                            if child.emergencyContacts.isEmpty {
                                emptyStateCard(
                                    title: "No emergency contacts",
                                    message: "Add at least one emergency contact for safeguarding."
                                )
                            } else {
                                ForEach(child.emergencyContacts) { contact in
                                    HStack(spacing: 12) {
                                        ContactRowCard(
                                            name: contact.name,
                                            subtitle: contact.relationship,
                                            trailingText: contact.phoneNumber
                                        )

                                        Spacer()

                                        Button {
                                            selectedEmergencyContact = contact
                                        } label: {
                                            Image(systemName: "pencil")
                                                .font(.headline)
                                                .foregroundStyle(AppTheme.primary)
                                                .frame(width: 36, height: 36)
                                                .background(AppTheme.softBackground)
                                                .clipShape(Circle())
                                        }
                                        .buttonStyle(.plain)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(AppTheme.cardBackground)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(AppTheme.border, lineWidth: 1)
                                    )
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button {
                                            selectedEmergencyContact = contact
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        .tint(.blue)

                                        Button(role: .destructive) {
                                            contactToDelete = contact
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                }
                            }

                            Button {
                                showAddEmergencyContact = true
                            } label: {
                                Label("Add Emergency Contact", systemImage: "plus")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(AppTheme.primary)
                            }
                            .padding(.top, 4)
                            .accessibilityIdentifier("addContactButton")
                        }
                    }
                    .listRowBackground(Color.clear)

                    Section {
                        VStack(alignment: .leading, spacing: 10) {
                            SectionHeaderView("Authorised Collectors")

                            if child.authorisedCollectors.isEmpty {
                                emptyStateCard(
                                    title: "No authorised collectors",
                                    message: "Add approved adults who are allowed to collect the child."
                                )
                            } else {
                                ForEach(child.authorisedCollectors) { collector in
                                    HStack(spacing: 12) {
                                        ContactRowCard(
                                            name: collector.name,
                                            subtitle: collector.relationship,
                                            trailingText: "ID: \(collector.idReference)"
                                        )

                                        Spacer()

                                        Button {
                                            selectedCollector = collector
                                        } label: {
                                            Image(systemName: "pencil")
                                                .font(.headline)
                                                .foregroundStyle(AppTheme.primary)
                                                .frame(width: 36, height: 36)
                                                .background(AppTheme.softBackground)
                                                .clipShape(Circle())
                                        }
                                        .buttonStyle(.plain)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(AppTheme.cardBackground)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(AppTheme.border, lineWidth: 1)
                                    )
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button {
                                            selectedCollector = collector
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        .tint(.blue)

                                        Button(role: .destructive) {
                                            collectorToDelete = collector
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                }
                            }

                            Button {
                                showAddCollector = true
                            } label: {
                                Label("Add Authorised Collector", systemImage: "plus")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(AppTheme.primary)
                            }
                            .padding(.top, 4)
                            .accessibilityIdentifier("addCollectorButton")
                        }
                    }
                    .listRowBackground(Color.clear)

                    Section {
                        NavigationLink("Edit Profile") {
                            EditProfileView(child: child)
                        }

                        NavigationLink("Consent Settings") {
                            ConsentSettingsView(child: child)
                        }
                    } header: {
                        SectionHeaderView("Manage")
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .background(AppTheme.background)
                .navigationTitle("Child Profile")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $showAddEmergencyContact) {
                    NavigationStack {
                        AddEmergencyContactView(child: child)
                    }
                }
                .sheet(isPresented: $showAddCollector) {
                    NavigationStack {
                        AddAuthorisedCollectorView(child: child)
                    }
                }
                .sheet(item: $selectedEmergencyContact) { contact in
                    NavigationStack {
                        EditEmergencyContactView(contact: contact)
                    }
                }
                .sheet(item: $selectedCollector) { collector in
                    NavigationStack {
                        EditAuthorisedCollectorView(collector: collector)
                    }
                }
                .alert("Delete Emergency Contact?", isPresented: deleteContactBinding) {
                    Button("Delete", role: .destructive) {
                        if let contact = contactToDelete {
                            deleteEmergencyContact(contact, from: child)
                        }
                    }
                    Button("Cancel", role: .cancel) {
                        contactToDelete = nil
                    }
                } message: {
                    Text("This contact will be removed from the child profile.")
                }
                .alert("Delete Authorised Collector?", isPresented: deleteCollectorBinding) {
                    Button("Delete", role: .destructive) {
                        if let collector = collectorToDelete {
                            deleteCollector(collector, from: child)
                        }
                    }
                    Button("Cancel", role: .cancel) {
                        collectorToDelete = nil
                    }
                } message: {
                    Text("This authorised collector will be removed from the child profile.")
                }
                .alert("Unable to Delete", isPresented: $showDeleteErrorAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(deleteErrorMessage)
                }
            } else {
                ContentUnavailableView("Profile not found", systemImage: "person.slash")
            }
        }
    }

    private var deleteContactBinding: Binding<Bool> {
        Binding(
            get: { contactToDelete != nil },
            set: { if !$0 { contactToDelete = nil } }
        )
    }

    private var deleteCollectorBinding: Binding<Bool> {
        Binding(
            get: { collectorToDelete != nil },
            set: { if !$0 { collectorToDelete = nil } }
        )
    }

    @ViewBuilder
    private func emptyStateCard(title: String, message: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline.weight(.semibold))

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppTheme.border, lineWidth: 1)
        )
    }

    private func deleteEmergencyContact(_ contact: EmergencyContact, from child: ChildProfile) {
        if let index = child.emergencyContacts.firstIndex(where: { $0.id == contact.id }) {
            child.emergencyContacts.remove(at: index)
        }

        context.delete(contact)

        do {
            try context.save()
            contactToDelete = nil
        } catch {
            deleteErrorMessage = "The emergency contact could not be deleted."
            showDeleteErrorAlert = true
        }
    }

    private func deleteCollector(_ collector: AuthorisedCollector, from child: ChildProfile) {
        if let index = child.authorisedCollectors.firstIndex(where: { $0.id == collector.id }) {
            child.authorisedCollectors.remove(at: index)
        }

        context.delete(collector)

        do {
            try context.save()
            collectorToDelete = nil
        } catch {
            deleteErrorMessage = "The authorised collector could not be deleted."
            showDeleteErrorAlert = true
        }
    }
}
