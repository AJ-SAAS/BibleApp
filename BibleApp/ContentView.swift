import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var hasCompletedOnboardingQuestions: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboardingQuestions")
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
                } else if (authState.isAuthenticated || authState.isGuest) && !hasCompletedOnboardingQuestions {
                    OnboardingQuestionsView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                } else if authState.isAuthenticated || authState.isGuest {
                    TabBarView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                } else {
                    OnboardingView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
        .onChange(of: authState.isAuthenticated) { _, _ in
            hasCompletedOnboardingQuestions = UserDefaults.standard.bool(forKey: "hasCompletedOnboardingQuestions")
        }
        .onChange(of: authState.isGuest) { _, newValue in
            if newValue && !authState.isAuthenticated {
                UserDefaults.standard.set(false, forKey: "hasCompletedOnboardingQuestions")
                hasCompletedOnboardingQuestions = false
            }
        }
        .onAppear {
            // Always show splash on every app open
            showSplashView = true
            hasCompletedOnboardingQuestions = UserDefaults.standard.bool(forKey: "hasCompletedOnboardingQuestions")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationState())
}
