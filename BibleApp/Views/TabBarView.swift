import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            // Home Tab
            GeometryReader { geometry in
                NavigationStack {
                    HomeView()
                        .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
                }
                .navigationTitle("Home")
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)
            
            // Settings Tab
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(1)
        }
        .background(Color.white.ignoresSafeArea())
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
