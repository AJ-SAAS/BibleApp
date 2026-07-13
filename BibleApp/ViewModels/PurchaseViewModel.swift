import SwiftUI
import RevenueCat
import Combine

@MainActor
final class PurchaseViewModel: ObservableObject {

    @Published var isPremium = false
    @Published var currentOffering: Offering?

    @Published var isLoading = false
    @Published var errorMessage: String?

    private let subscriptionService = SubscriptionService.shared
    private var observationTask: Task<Void, Never>?

    init() {
        observeCustomerInfo()

        Task {
            await loadOfferings()
            await refreshPremiumStatus()
        }
    }

    deinit {
        observationTask?.cancel()
    }

    // MARK: - Packages

    var weeklyPackage: Package? {
        currentOffering?.weekly
    }

    var annualPackage: Package? {
        currentOffering?.annual
    }

    // MARK: - Load Products

    func loadOfferings() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let offerings = try await subscriptionService.getOfferings()
            currentOffering = offerings.current
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Purchase

    func purchase(_ package: Package) async {
        isLoading = true
        defer { isLoading = false }

        do {
            let customerInfo = try await subscriptionService.purchase(package: package)
            updatePremiumStatus(customerInfo)
        } catch let error as ErrorCode {
            if error == .purchaseCancelledError {
                return
            }
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Restore

    func restorePurchases() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let customerInfo = try await subscriptionService.restorePurchases()
            updatePremiumStatus(customerInfo)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Refresh Status

    func refreshPremiumStatus() async {
        do {
            let customerInfo = try await subscriptionService.customerInfo()
            updatePremiumStatus(customerInfo)
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Observe RevenueCat
    private func observeCustomerInfo() {
        observationTask = Task { [weak self] in
            for await customerInfo in Purchases.shared.customerInfoStream {
                guard let self else { return }
                self.updatePremiumStatus(customerInfo)
            }
        }
    }

    // MARK: - Premium Status

    private func updatePremiumStatus(_ customerInfo: CustomerInfo) {
        isPremium =
            customerInfo.entitlements
                .active[Constants.premiumEntitlement] != nil
    }
}
