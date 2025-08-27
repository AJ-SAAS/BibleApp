import SwiftUI
import FirebaseAuth

class AuthenticationState: ObservableObject {
    @Published var isAuthenticated: Bool = Auth.auth().currentUser != nil
    
    init() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.isAuthenticated = user != nil
            print("AuthenticationState: isAuthenticated changed to \(self.isAuthenticated)")
        }
    }
    
    func updateAuthenticationState(isAuthenticated: Bool) {
        self.isAuthenticated = isAuthenticated
    }
}
