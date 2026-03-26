import SwiftUI
import SwiftData

struct ConsentSettingsView: View {
    @Bindable var child: ChildProfile
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var photographyConsent: Bool
    @State private var socialMediaConsent: Bool
    @State private var medicalTreatmentConsent: Bool
    @State private var gpsTrackingConsent: Bool

    @State private var showSavedAlert = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    init(child: ChildProfile) {
        self.child = child

        let consent = child.consentSettings ?? ConsentSettings()

        _photographyConsent = State(initialValue: consent.photographyConsent)
        _socialMediaConsent = State(initialValue: consent.socialMediaConsent)
        _medicalTreatmentConsent = State(initialValue: consent.medicalTreatmentConsent)
        _gpsTrackingConsent = State(initialValue: consent.gpsTrackingConsent)
    }

    var body: some View {
        Form {
            Section("Media") {
                Toggle("Photography Consent", isOn: $photographyConsent)
                Toggle("Social Media Consent", isOn: $socialMediaConsent)
            }

            Section("Health & Transport") {
                Toggle("Medical Treatment Consent", isOn: $medicalTreatmentConsent)
                Toggle("GPS Tracking Consent", isOn: $gpsTrackingConsent)
            }

            Section {
                Text("These consent options are shown from the parent or guardian perspective and can be updated in this MVP app.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Consent Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveConsentSettings()
                }
            }
        }
        .alert("Consent Updated", isPresented: $showSavedAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Consent settings were saved successfully.")
        }
        .alert("Unable to Save", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }

    private func saveConsentSettings() {
        let consent = child.consentSettings ?? ConsentSettings()

        consent.photographyConsent = photographyConsent
        consent.socialMediaConsent = socialMediaConsent
        consent.medicalTreatmentConsent = medicalTreatmentConsent
        consent.gpsTrackingConsent = gpsTrackingConsent

        if child.consentSettings == nil {
            child.consentSettings = consent
            context.insert(consent)
        }

        do {
            try context.save()
            showSavedAlert = true
        } catch {
            errorMessage = "Something went wrong while saving the consent settings."
            showErrorAlert = true
        }
    }
}
