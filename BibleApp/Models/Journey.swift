import Foundation

struct Journey: Identifiable, Codable {
    let id: String
    let title: String
    let subtitle: String
    let imageName: String
    let category: String

    let durationDays: Int

    let isPremium: Bool

    let description: String

    let accentColor: String
}
