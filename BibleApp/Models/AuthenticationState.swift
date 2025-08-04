import Foundation
import FirebaseAuth // Import FirebaseAuth for Auth class

class AuthenticationState: ObservableObject {
    @Published var isAuthenticated: Bool = false

    init() {
        // Check if user is already logged in
        if Auth.auth().currentUser != nil {
            isAuthenticated = true
        }
    }

    func updateAuthenticationState(isAuthenticated: Bool) {
        self.isAuthenticated = isAuthenticated
    }
}
