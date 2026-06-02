import SwiftUI

enum SidebarItem: String, CaseIterable, Identifiable {
    case dashboard = "Dashboard"
    case diary = "Daily Diary"
    case profile = "Child Profile"
    case medication = "Medication Notes"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .dashboard:
            return "house.fill"
        case .diary:
            return "book.closed.fill"
        case .profile:
            return "person.crop.circle.fill"
        case .medication:
            return "cross.case.fill"
        }
    }
}

struct iPadDashboardView: View {
    @State private var selectedItem: SidebarItem? = .dashboard

    var body: some View {
        NavigationSplitView {
            List(SidebarItem.allCases, selection: $selectedItem) { item in
                Label(item.rawValue, systemImage: item.icon)
                    .tag(item)
            }
            .navigationTitle("NurseryConnect")
        } detail: {
            NavigationStack {
                selectedDetailView
            }
            .id(selectedItem)
        }
    }

    @ViewBuilder
    private var selectedDetailView: some View {
        switch selectedItem {
        case .dashboard:
            DashboardView()

        case .diary:
            DiaryListView()

        case .profile:
            ProfileView()

        case .medication:
            MedicationListView()

        case .none:
            DashboardView()
        }
    }
}
