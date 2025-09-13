import SwiftUI
import FirebaseAuth

class AuthenticationState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var isGuest: Bool = false
    private var authListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        // Delay listener to avoid immediate override
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.authListenerHandle = Auth.auth().addStateDidChangeListener { _, user in
                // Only update if not manually set
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
    }

    deinit {
        if let handle = authListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
