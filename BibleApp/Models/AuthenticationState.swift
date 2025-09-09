import SwiftUI
import FirebaseAuth

class AuthenticationState: ObservableObject {
    @Published var isAuthenticated: Bool = Auth.auth().currentUser != nil
    @Published var isGuest: Bool = false
    private var authListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        authListenerHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.isAuthenticated = user != nil
            self.isGuest = user == nil && self.isGuest
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
