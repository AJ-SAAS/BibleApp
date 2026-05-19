// MARK: - JourneyService.swift

import Foundation

class JourneyService {

    static let shared = JourneyService()

    func loadJourneys() -> [Journey] {

        guard let url = Bundle.main.url(
            forResource: "journeys",
            withExtension: "json"
        ) else {
            print("Could not find journeys.json")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Journey].self, from: data)
        } catch {
            print("Error loading journeys: \(error)")
            return []
        }
    }

    func loadJourneyDays(for journeyID: String) -> [JourneyDay] {

        let fileName = "journey_days_\(journeyID)"

        guard let url = Bundle.main.url(
            forResource: fileName,
            withExtension: "json"
        ) else {
            print("Could not find \(fileName).json")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([JourneyDay].self, from: data)
        } catch {
            print("Error loading journey days for \(journeyID): \(error)")
            return []
        }
    }
}
