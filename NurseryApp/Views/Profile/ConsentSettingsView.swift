import SwiftUI

struct ConsentSettingsView: View {
    @Bindable var child: ChildProfile

    var body: some View {
        Form {
            if let consent = child.consentSettings {
                Section("Consent Preferences") {
                    Toggle("Photography Consent", isOn: Binding(
                        get: { consent.photographyConsent },
                        set: { consent.photographyConsent = $0 }
                    ))

                    Toggle("Social Media Consent", isOn: Binding(
                        get: { consent.socialMediaConsent },
                        set: { consent.socialMediaConsent = $0 }
                    ))

                    Toggle("Medical Treatment Consent", isOn: Binding(
                        get: { consent.medicalTreatmentConsent },
                        set: { consent.medicalTreatmentConsent = $0 }
                    ))

                    Toggle("GPS Tracking Consent", isOn: Binding(
                        get: { consent.gpsTrackingConsent },
                        set: { consent.gpsTrackingConsent = $0 }
                    ))
                }

                Section("Information") {
                    Text("These settings help parents control how child information, photos, and transport-related data are handled in the nursery system.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            } else {
                Section {
                    Text("No consent settings available.")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Consent Settings")
        .navigationBarTitleDisplayMode(.inline)
        .tint(AppTheme.primary)
    }
}
