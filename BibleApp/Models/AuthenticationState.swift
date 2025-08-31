import SwiftUI
import FirebaseAuth

class AuthenticationState: ObservableObject {
    @Published var isAuthenticated: Bool = Auth.auth().currentUser != nil
    @Published var isGuest: Bool = false
    private var authListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        authListenerHandle = Auth.auth().addStateDidChangeListener { _, user in
            self.isAuthenticated = user != nil
            self.isGuest = false
            print("AuthenticationState: isAuthenticated changed to \(self.isAuthenticated), isGuest: \(self.isGuest)")
        }
    }
    
    func updateAuthenticationState(isAuthenticated: Bool, isGuest: Bool = false) {
        self.isAuthenticated = isAuthenticated
        self.isGuest = isGuest
        print("AuthenticationState: Updated to isAuthenticated: \(self.isAuthenticated), isGuest: \(self.isGuest)")
    }
    
    deinit {
        if let handle = authListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
            print("AuthenticationState: Removed auth state listener")
        }
    }
}
