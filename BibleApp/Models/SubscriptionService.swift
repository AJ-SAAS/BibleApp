import Foundation
import RevenueCat

final class SubscriptionService {

    static let shared = SubscriptionService()

    private init() {}

    // MARK: - Offerings

    func getOfferings() async throws -> Offerings {
        try await Purchases.shared.offerings()
    }

    // MARK: - Purchase

    func purchase(package: Package) async throws -> CustomerInfo {
        let result = try await Purchases.shared.purchase(package: package)
        return result.customerInfo
    }

    // MARK: - Restore

    func restorePurchases() async throws -> CustomerInfo {
        try await Purchases.shared.restorePurchases()
    }

    // MARK: - Customer Info

    func customerInfo() async throws -> CustomerInfo {
        try await Purchases.shared.customerInfo()
    }
}
