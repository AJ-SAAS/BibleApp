import SwiftUI

// MARK: - BrowseCategory
// Shared model used by HomeView and BrowseView

struct BrowseCategory: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let subtitle: String
}

// MARK: - MomPromise
// Shared model used by HomeView

struct MomPromise {
    let situation: String
    let reflection: String
    let verse: String
    let reference: String
    let category: String
}

// MARK: - SavedPromise
// Shared model used by SavedView

struct SavedPromise: Identifiable {
    let id = UUID()
    let situation: String
    let verse: String
    let reference: String
    let category: String
}

// MARK: - RoundedCorner Shape
// Shared shape used by HomeView and BrowseView

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
