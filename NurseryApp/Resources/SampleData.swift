import Foundation
import SwiftData

enum SampleData {
    static func seedIfNeeded(context: ModelContext, profiles: [ChildProfile], entries: [DiaryEntry]) {
        guard profiles.isEmpty, entries.isEmpty else { return }

        let consent = ConsentSettings(
            photographyConsent: true,
            socialMediaConsent: false,
            medicalTreatmentConsent: true,
            gpsTrackingConsent: true
        )

        let contact1 = EmergencyContact(
            name: "Sarah Johnson",
            relationship: "Mother",
            phoneNumber: "+44 7700 900123"
        )

        let contact2 = EmergencyContact(
            name: "Mark Johnson",
            relationship: "Father",
            phoneNumber: "+44 7700 900456"
        )

        let collector1 = AuthorisedCollector(
            name: "Emma Wilson",
            relationship: "Aunt",
            idReference: "DL-2024-EMW"
        )

        let child = ChildProfile(
            childName: "Oliver Johnson",
            preferredName: "Ollie",
            dietaryNotes: "No nuts. Lactose intolerant.",
            medicalNotes: "Mild asthma — inhaler kept in red bag.",
            photoName: nil,
            emergencyContacts: [contact1, contact2],
            authorisedCollectors: [collector1],
            consentSettings: consent
        )

        let calendar = Calendar.current
        let now = Date()

        let entry1 = DiaryEntry(
            title: "Morning Check-In",
            details: "Arrived happy and settled quickly after saying goodbye.",
            timestamp: calendar.date(byAdding: .hour, value: -5, to: now) ?? now,
            type: .checkIn
        )

        let entry2 = DiaryEntry(
            title: "Breakfast",
            details: "Porridge with banana. Ate well and drank water.",
            timestamp: calendar.date(byAdding: .hour, value: -4, to: now) ?? now,
            type: .meal
        )

        let entry3 = DiaryEntry(
            title: "Morning Nap",
            details: "Slept soundly for 45 minutes.",
            timestamp: calendar.date(byAdding: .hour, value: -3, to: now) ?? now,
            type: .nap
        )

        let entry4 = DiaryEntry(
            title: "Art Activity",
            details: "Ollie joined the morning art session with great enthusiasm. He chose blue and yellow paint to create a butterfly painting. Very proud of his work.",
            timestamp: calendar.date(byAdding: .hour, value: -2, to: now) ?? now,
            type: .activity
        )

        let entry5 = DiaryEntry(
            title: "Lunch",
            details: "Pasta with tomato sauce. Finished most of the meal.",
            timestamp: calendar.date(byAdding: .hour, value: -1, to: now) ?? now,
            type: .meal
        )

        context.insert(consent)
        context.insert(contact1)
        context.insert(contact2)
        context.insert(collector1)
        context.insert(child)

        context.insert(entry1)
        context.insert(entry2)
        context.insert(entry3)
        context.insert(entry4)
        context.insert(entry5)

        do {
            try context.save()
        } catch {
            print("Failed to seed sample data: \(error)")
        }
    }
}
