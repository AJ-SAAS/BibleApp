import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var hasCompletedOnboardingQuestions: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboardingQuestions")
    @State private var showSplashView: Bool = false

    var body: some View {
        NavigationStack {
            Group {
                if showSplashView {
                    SplashView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                        .onDisappear {
                            // Save timestamp when SplashView disappears (after animation)
                            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "lastSplashViewTime")
                            print("ContentView: SplashView disappeared, timestamp saved: \(Date().timeIntervalSince1970)")
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
            // Check if SplashView should be shown (first launch or >24 hours since last)
            let lastSplashTime = UserDefaults.standard.double(forKey: "lastSplashViewTime")
            let currentTime = Date().timeIntervalSince1970
            let twentyFourHours: Double = 24 * 60 * 60 // 24 hours in seconds
            showSplashView = lastSplashTime == 0 || currentTime - lastSplashTime >= twentyFourHours
            print("ContentView: onAppear, showSplashView: \(showSplashView), lastSplashTime: \(lastSplashTime), currentTime: \(currentTime), hours since last: \((currentTime - lastSplashTime) / 3600)")
            
            // Update onboarding state
            hasCompletedOnboardingQuestions = UserDefaults.standard.bool(forKey: "hasCompletedOnboardingQuestions")
            print("ContentView: onAppear, isGuest: \(authState.isGuest), isAuthenticated: \(authState.isAuthenticated), hasCompletedOnboardingQuestions: \(hasCompletedOnboardingQuestions)")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationState())
}
