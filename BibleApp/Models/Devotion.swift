import Foundation

struct Devotion: Equatable {
    let month: Int // 1 = January, ..., 12 = December
    let day: Int // 1 to 31
    let verse: String
    let reference: String
    let task: String
}
