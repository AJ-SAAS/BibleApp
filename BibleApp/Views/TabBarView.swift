import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            // Home Tab
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
                    .environment(\.symbolVariants, .none)
            }
            .tag(0)

            // Settings Tab
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                        .environment(\.symbolVariants, .none)
                }
                .tag(1)
        }
        .tint(.black)
        .background(Color.white)
    }
}

#Preview("iPhone 14") {
    TabBarView()
        .environmentObject(AuthenticationState())
}

#Preview("iPad Pro") {
    TabBarView()
        .environmentObject(AuthenticationState())
}
