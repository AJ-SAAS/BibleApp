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

        // Listen immediately for Firebase authentication changes
        authListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }

            // Only update authentication state.
            // Guest mode is managed separately.
            self.isAuthenticated = (user != nil)
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
