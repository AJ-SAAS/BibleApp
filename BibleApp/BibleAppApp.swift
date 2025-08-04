import SwiftUI
import FirebaseCore

@main
struct BibleAppApp: App {
    @StateObject private var authState = AuthenticationState()

    init() {
        FirebaseApp.configure()
        print("BibleAppApp: Firebase configured, authState initialized: \(authState.isAuthenticated)")
    }

    var body: some Scene {
        WindowGroup {
            if authState.isAuthenticated {
                HomeView()
                    .environmentObject(authState) // Ensure HomeView also receives authState
            } else {
                AuthView()
                    .environmentObject(authState)
            }
        }
    }
}
