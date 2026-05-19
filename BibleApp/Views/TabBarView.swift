import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var selectedTab: Int = 0

    var body: some View {

        TabView(selection: $selectedTab) {

            // MARK: - Today
            NavigationStack {
                HomeView()
                    .environmentObject(authState)
                    .navigationBarHidden(true)
            }
            .tabItem {
                Label(
                    "Today",
                    systemImage: selectedTab == 0
                    ? "sun.max.fill"
                    : "sun.max"
                )
            }
            .tag(0)

            // MARK: - Journeys
            NavigationStack {
                JourneyBrowseView()
                    .environmentObject(authState)
            }
            .tabItem {
                Label(
                    "Journeys",
                    systemImage: selectedTab == 1
                    ? "heart.text.square.fill"
                    : "heart.text.square"
                )
            }
            .tag(1)

            // MARK: - Bible
            NavigationStack {
                BibleView()
                    .environmentObject(authState)
            }
            .tabItem {
                Label(
                    "Bible",
                    systemImage: selectedTab == 2
                    ? "book.fill"
                    : "book"
                )
            }
            .tag(2)

            // MARK: - Saved
            NavigationStack {
                SavedView()
                    .environmentObject(authState)
            }
            .tabItem {
                Label(
                    "Saved",
                    systemImage: selectedTab == 3
                    ? "bookmark.fill"
                    : "bookmark"
                )
            }
            .tag(3)

            // MARK: - Settings
            NavigationStack {
                SettingsView()
                    .environmentObject(authState)
            }
            .tabItem {
                Label(
                    "Settings",
                    systemImage: selectedTab == 4
                    ? "gearshape.fill"
                    : "gearshape"
                )
            }
            .tag(4)
        }
        .accentColor(Color(hex: "#2c1f14"))
        .onAppear {

            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()

            appearance.backgroundColor = UIColor(
                Color(hex: "#faf6f0")
            )

            // MARK: Normal
            appearance.stackedLayoutAppearance.normal.iconColor =
            UIColor(Color(hex: "#c4b5a5"))

            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor(Color(hex: "#c4b5a5")),
                .font: UIFont.systemFont(ofSize: 10, weight: .medium)
            ]

            // MARK: Selected
            appearance.stackedLayoutAppearance.selected.iconColor =
            UIColor(Color(hex: "#2c1f14"))

            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor(Color(hex: "#2c1f14")),
                .font: UIFont.systemFont(ofSize: 10, weight: .semibold)
            ]

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
