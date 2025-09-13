import SwiftUI
import FirebaseCore

@main
struct BibleAppApp: App {
    @StateObject private var authState = AuthenticationState()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(authState)
        }
    }
}
