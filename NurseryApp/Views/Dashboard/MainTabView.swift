import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack { DashboardView() }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            NavigationStack { DiaryListView() }
                .tabItem {
                    Label("Diary", systemImage: "book.closed.fill")
                }

            NavigationStack { ProfileView() }
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
        .tint(AppTheme.primary)
    }
}
