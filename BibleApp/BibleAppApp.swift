import SwiftUI
import FirebaseCore
import RevenueCat

@main
struct BibleAppApp: App {

    @StateObject private var authState = AuthenticationState()
    @StateObject private var purchaseViewModel = PurchaseViewModel()

    init() {

        FirebaseApp.configure()

        Purchases.logLevel = .debug

        Purchases.configure(
            withAPIKey: Constants.revenueCatAPIKey
        )
    }

    var body: some Scene {

        WindowGroup {

            ContentView()
                .environmentObject(authState)
                .environmentObject(purchaseViewModel)
                .preferredColorScheme(.light)

        }

    }

}
