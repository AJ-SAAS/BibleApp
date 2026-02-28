import Foundation

func shouldShowDidYouKnow() -> Bool {
    let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
    let lastSeen = UserDefaults.standard.string(forKey: "didYouKnowLastSeen")
    return lastSeen != today
}

func markDidYouKnowAsSeen() {
    let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
    UserDefaults.standard.set(today, forKey: "didYouKnowLastSeen")
}
