import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var hasCompletedOnboardingQuestions: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboardingQuestions")

    var body: some View {
        NavigationStack {
            Group {
                if (authState.isAuthenticated || authState.isGuest) && !hasCompletedOnboardingQuestions {
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
        }
        .onChange(of: authState.isAuthenticated) { _, newValue in
            hasCompletedOnboardingQuestions = UserDefaults.standard.bool(forKey: "hasCompletedOnboardingQuestions")
            print("ContentView: isAuthenticated changed to \(newValue), hasCompletedOnboardingQuestions: \(hasCompletedOnboardingQuestions)")
        }
        .onChange(of: authState.isGuest) { _, newValue in
            if newValue && !authState.isAuthenticated {
                UserDefaults.standard.set(false, forKey: "hasCompletedOnboardingQuestions")
                hasCompletedOnboardingQuestions = false
                print("ContentView: isGuest changed to \(newValue), hasCompletedOnboardingQuestions set to false")
            }
        }
        .onAppear {
            // Reset for clean testing
            UserDefaults.standard.set(false, forKey: "hasCompletedOnboardingQuestions")
            hasCompletedOnboardingQuestions = false
            print("ContentView: onAppear, isGuest: \(authState.isGuest), hasCompletedOnboardingQuestions: \(hasCompletedOnboardingQuestions)")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationState())
}
