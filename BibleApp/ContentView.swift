import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authState: AuthenticationState
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var showSplashView: Bool = true

    var body: some View {
        NavigationStack {
            Group {
                if showSplashView {
                    SplashView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                        .onDisappear {
                            showSplashView = false
                        }
                }
                else if !hasCompletedOnboarding {
                    OnboardingView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                }
                else if authState.isAuthenticated || authState.isGuest {
                    TabBarView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                }
                else {
                    OnboardingView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
        .onAppear {
            showSplashView = true
            hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationState())
}
