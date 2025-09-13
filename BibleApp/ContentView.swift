import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var hasCompletedOnboardingQuestions: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboardingQuestions")

    var body: some View {
        Group {
            if authState.isAuthenticated && !hasCompletedOnboardingQuestions {
                OnboardingQuestionsView()
                    .environmentObject(authState)
                    .navigationBarBackButtonHidden(true)
            } else if authState.isAuthenticated || authState.isGuest {
                TabBarView()
                    .environmentObject(authState)
                    .navigationBarBackButtonHidden(true)
            } else {
                SplashView()
                    .environmentObject(authState)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .onChange(of: authState.isAuthenticated) { _, newValue in
            hasCompletedOnboardingQuestions = UserDefaults.standard.bool(forKey: "hasCompletedOnboardingQuestions")
        }
    }
}
