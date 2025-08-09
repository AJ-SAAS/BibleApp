import SwiftUI
import FirebaseCore

@main
struct BibleAppApp: App {
    @StateObject private var authState = AuthenticationState()

    init() {
        configureFirebase()
    }

    private func configureFirebase() {
        FirebaseApp.configure()
        print("BibleAppApp: Firebase configured")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authState)
        }
    }
}
