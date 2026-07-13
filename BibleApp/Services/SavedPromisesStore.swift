import Foundation
import Combine

// Shared store for the "Today's Promise" save/heart feature.
// Persisted to UserDefaults for now — matches the rest of the app's
// storage pattern. Swap the load/save internals for Firebase later
// without touching HomeView or SavedView.

@MainActor
final class SavedPromisesStore: ObservableObject {
    static let shared = SavedPromisesStore()

    @Published private(set) var savedItems: [SavedPromise] = []

    private let storageKey = "SavedPromises"

    private init() {
        load()
    }

    // MARK: - Queries

    func isSaved(situation: String, verse: String) -> Bool {
        savedItems.contains { $0.situation == situation && $0.verse == verse }
    }

    // MARK: - Mutations

    func save(_ promise: MomPromise) {
        let item = SavedPromise(
            situation: promise.situation,
            verse: promise.verse,
            reference: promise.reference,
            category: promise.category
        )
        guard !isSaved(situation: item.situation, verse: item.verse) else { return }
        savedItems.insert(item, at: 0)
        persist()
    }

    func remove(situation: String, verse: String) {
        savedItems.removeAll { $0.situation == situation && $0.verse == verse }
        persist()
    }

    func remove(id: UUID) {
        savedItems.removeAll { $0.id == id }
        persist()
    }

    func toggle(_ promise: MomPromise) {
        if isSaved(situation: promise.situation, verse: promise.verse) {
            remove(situation: promise.situation, verse: promise.verse)
        } else {
            save(promise)
        }
    }

    // MARK: - Persistence

    private func persist() {
        do {
            let data = try JSONEncoder().encode(savedItems)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("SavedPromisesStore: failed to save — \(error)")
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            savedItems = try JSONDecoder().decode([SavedPromise].self, from: data)
        } catch {
            print("SavedPromisesStore: failed to load — \(error)")
        }
    }
}
