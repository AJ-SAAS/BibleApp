import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var authState: AuthenticationState
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
                    .environmentObject(authState)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
                    .environment(\.symbolVariants, .none)
            }
            .tag(0)
            
            NavigationStack {
                SettingsView()
                    .environmentObject(authState)
            }
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
