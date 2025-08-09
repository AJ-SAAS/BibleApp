import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authState: AuthenticationState

    var body: some View {
        if authState.isAuthenticated {
            TabBarView() // Replace HomeView with TabBarView
        } else {
            AuthView()
        }
    }
}
