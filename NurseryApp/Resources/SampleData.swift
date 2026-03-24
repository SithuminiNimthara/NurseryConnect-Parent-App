import Foundation
import SwiftData

enum SampleData {
    static func insertIfNeeded(context: ModelContext) {
        let descriptor = FetchDescriptor<ChildProfile>()
        let existingProfiles = (try? context.fetch(descriptor)) ?? []

        guard existingProfiles.isEmpty else { return }

        let consent = ConsentSettings(
            photographyConsent: true,
            socialMediaConsent: false,
            medicalTreatmentConsent: true,
            gpsTrackingConsent: true
        )

        let child = ChildProfile(
            childName: "Amelia Johnson",
            preferredName: "Amelia",
            dietaryNotes: "Nut-free diet. Avoid strawberries.",
            medicalNotes: "Mild eczema. Apply cream if needed.",
            emergencyContacts: [
                EmergencyContact(name: "Sarah Johnson", relationship: "Mother", phoneNumber: "0712345678"),
                EmergencyContact(name: "David Johnson", relationship: "Father", phoneNumber: "0798765432")
            ],
            authorisedCollectors: [
                AuthorisedCollector(name: "Emma Smith", relationship: "Aunt", idReference: "Passport ending 4821"),
                AuthorisedCollector(name: "Liam Brown", relationship: "Grandfather", idReference: "Driving Licence ending 2109")
            ],
            consentSettings: consent
        )

        let calendar = Calendar.current
        let now = Date()

        let entries = [
            DiaryEntry(
                title: "Morning Check-In",
                details: "Amelia arrived happy and settled. Mother shared that she slept well last night.",
                timestamp: calendar.date(byAdding: .hour, value: -8, to: now) ?? now,
                type: .checkIn
            ),
            DiaryEntry(
                title: "Breakfast",
                details: "Ate most of porridge and banana. Drank a small cup of milk.",
                timestamp: calendar.date(byAdding: .hour, value: -7, to: now) ?? now,
                type: .meal
            ),
            DiaryEntry(
                title: "Outdoor Play",
                details: "Joined group play in the garden and enjoyed ball activities with friends.",
                timestamp: calendar.date(byAdding: .hour, value: -5, to: now) ?? now,
                type: .activity
            ),
            DiaryEntry(
                title: "Nap Time",
                details: "Slept from 12:35 PM to 1:20 PM. Settled quickly and woke up calm.",
                timestamp: calendar.date(byAdding: .hour, value: -4, to: now) ?? now,
                type: .nap
            ),
            DiaryEntry(
                title: "Lunch",
                details: "Had pasta bolognese and cucumber slices. Finished most of the meal.",
                timestamp: calendar.date(byAdding: .hour, value: -3, to: now) ?? now,
                type: .meal
            ),
            DiaryEntry(
                title: "Afternoon Mood",
                details: "Cheerful and engaged during story time and drawing activity.",
                timestamp: calendar.date(byAdding: .hour, value: -2, to: now) ?? now,
                type: .mood
            ),
            DiaryEntry(
                title: "Collection Time",
                details: "Collected by Mother. Handover given about meals, nap, and play activity.",
                timestamp: calendar.date(byAdding: .hour, value: -1, to: now) ?? now,
                type: .checkOut
            )
        ]

        context.insert(child)
        entries.forEach { context.insert($0) }

        try? context.save()
    }
}

