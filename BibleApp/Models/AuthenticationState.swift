import SwiftUI
import FirebaseAuth

class AuthenticationState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var isGuest: Bool = false
    private var authListenerHandle: AuthStateDidChangeListenerHandle?

    private let isGuestKey = "authState_isGuest"
    private let hasCompletedOnboardingKey = "hasCompletedOnboardingQuestions"

    init() {
        // Restore guest session from UserDefaults on launch
        self.isGuest = UserDefaults.standard.bool(forKey: isGuestKey)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.authListenerHandle = Auth.auth().addStateDidChangeListener { _, user in
                if !self.isAuthenticated && !self.isGuest {
                    self.isAuthenticated = user != nil
                    self.isGuest = user == nil && self.isGuest
                }
            }
        }
    }

    func updateAuthenticationState(isAuthenticated: Bool, isGuest: Bool = false) {
        self.isAuthenticated = isAuthenticated
        self.isGuest = isGuest

        // Persist guest state so it survives app restarts
        UserDefaults.standard.set(isGuest, forKey: isGuestKey)
    }

    deinit {
        if let handle = authListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
