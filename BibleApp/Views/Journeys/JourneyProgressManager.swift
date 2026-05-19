// MARK: - JourneyProgressManager.swift

import Foundation

final class JourneyProgressManager {

    static let shared = JourneyProgressManager()

    private let defaults = UserDefaults.standard

    // Stored format:
    // [ "assurance_moms": [1, 2, 3] ]
    private let storageKey = "journey_progress_data"

    private var progress: [String: Set<Int>] = [:]

    private init() {
        load()
    }

    // MARK: - Public API

    func isCompleted(journeyID: String, day: Int) -> Bool {
        return progress[journeyID]?.contains(day) ?? false
    }

    func markComplete(journeyID: String, day: Int) {
        var set = progress[journeyID] ?? Set<Int>()
        set.insert(day)
        progress[journeyID] = set
        save()
    }

    func markIncomplete(journeyID: String, day: Int) {
        var set = progress[journeyID] ?? Set<Int>()
        set.remove(day)
        progress[journeyID] = set
        save()
    }

    func completedDays(journeyID: String) -> Set<Int> {
        return progress[journeyID] ?? []
    }

    func completedCount(journeyID: String) -> Int {
        return progress[journeyID]?.count ?? 0
    }

    func progressPercent(journeyID: String, totalDays: Int) -> Double {
        guard totalDays > 0 else { return 0 }
        let completed = Double(completedCount(journeyID: journeyID))
        return completed / Double(totalDays)
    }

    // MARK: - Toggle Helper

    func toggleComplete(journeyID: String, day: Int) {
        if isCompleted(journeyID: journeyID, day: day) {
            markIncomplete(journeyID: journeyID, day: day)
        } else {
            markComplete(journeyID: journeyID, day: day)
        }
    }

    // MARK: - Persistence

    private func save() {
        let converted = progress.mapValues { Array($0) }
        if let data = try? JSONEncoder().encode(converted) {
            defaults.set(data, forKey: storageKey)
        }
    }

    private func load() {
        guard let data = defaults.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([String: [Int]].self, from: data)
        else {
            progress = [:]
            return
        }

        progress = decoded.mapValues { Set($0) }
    }

    // MARK: - Debug

    func resetAll() {
        progress = [:]
        defaults.removeObject(forKey: storageKey)
    }
}
