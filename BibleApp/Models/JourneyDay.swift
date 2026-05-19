// MARK: - JourneyDay.swift

import Foundation

struct JourneyDay: Identifiable, Codable {
    let id: String
    let journeyID: String
    let dayNumber: Int
    let title: String
    let verse: String
    let scriptureReference: String
    let reflection: String
    let prayer: String
    let action: String
    let journalPrompt: String
    let isLocked: Bool
}
