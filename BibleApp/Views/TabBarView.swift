import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {

            // ── Home ──
            NavigationStack {
                HomeView()
                    .environmentObject(authState)
                    .navigationBarHidden(true)
            }
            .tabItem {
                Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
            }
            .tag(0)

            // ── Browse ──
            NavigationStack {
                BrowseView()
                    .environmentObject(authState)
            }
            .tabItem {
                Label("Browse", systemImage: selectedTab == 1 ? "books.vertical.fill" : "books.vertical")
            }
            .tag(1)

            // ── Bible Study ──
            NavigationStack {
                BibleView()
                    .environmentObject(authState)
            }
            .tabItem {
                Label("Bible Study", systemImage: selectedTab == 2 ? "book.fill" : "book")
            }
            .tag(2)
            
            // ── Settings ──
            NavigationStack {
                SettingsView()
                    .environmentObject(authState)
                    .navigationTitle("Settings")
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
            .tag(3)
        }
        .accentColor(Color(hex: "#2c1f14"))
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color(hex: "#faf6f0"))

            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color(hex: "#c4b5a5"))
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor(Color(hex: "#c4b5a5")),
                .font: UIFont.systemFont(ofSize: 10, weight: .medium)
            ]

            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color(hex: "#2c1f14"))
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor(Color(hex: "#2c1f14")),
                .font: UIFont.systemFont(ofSize: 10, weight: .semibold)
            ]

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview("iPhone 15") {
    TabBarView()
        .environmentObject(AuthenticationState())
}
