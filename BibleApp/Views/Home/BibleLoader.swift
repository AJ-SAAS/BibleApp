import SwiftUI

// MARK: - JSON Models
// Note: aruljohn/Bible-kjv uses strings for chapter and verse numbers, not integers

struct KJVBookFile: Codable {
    let book: String
    let chapters: [KJVChapterData]
}

struct KJVChapterData: Codable {
    let chapter: Int
    let verses: [KJVVerseData]

    // Chapter numbers come as strings in the JSON ("1", "2", etc.)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let chapterString = try container.decode(String.self, forKey: .chapter)
        self.chapter = Int(chapterString) ?? 0
        self.verses = try container.decode([KJVVerseData].self, forKey: .verses)
    }

    enum CodingKeys: String, CodingKey {
        case chapter, verses
    }
}

struct KJVVerseData: Codable, Identifiable {
    var id: Int { verse }
    let verse: Int
    let text: String

    // Verse numbers also come as strings in the JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let verseString = try container.decode(String.self, forKey: .verse)
        self.verse = Int(verseString) ?? 0
        self.text = try container.decode(String.self, forKey: .text)
    }

    enum CodingKeys: String, CodingKey {
        case verse, text
    }
}

// MARK: - BibleLoader

class BibleLoader {
    static let shared = BibleLoader()
    private var cache: [String: KJVBookFile] = [:]

    func loadChapter(bookName: String, chapter: Int) -> [KJVVerseData]? {
        if let cached = cache[bookName] {
            return cached.chapters.first(where: { $0.chapter == chapter })?.verses
        }

        let filename = filenameFor(bookName: bookName)

        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let bookFile = try? JSONDecoder().decode(KJVBookFile.self, from: data) else {
            return nil
        }

        cache[bookName] = bookFile
        return bookFile.chapters.first(where: { $0.chapter == chapter })?.verses
    }

    func loadBook(bookName: String) -> KJVBookFile? {
        if let cached = cache[bookName] { return cached }

        let filename = filenameFor(bookName: bookName)

        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let bookFile = try? JSONDecoder().decode(KJVBookFile.self, from: data) else {
            return nil
        }

        cache[bookName] = bookFile
        return bookFile
    }

    private func filenameFor(bookName: String) -> String {
        switch bookName {
        case "Song of Solomon": return "SongofSolomon"
        case "1 Samuel":        return "1Samuel"
        case "2 Samuel":        return "2Samuel"
        case "1 Kings":         return "1Kings"
        case "2 Kings":         return "2Kings"
        case "1 Chronicles":    return "1Chronicles"
        case "2 Chronicles":    return "2Chronicles"
        case "1 Corinthians":   return "1Corinthians"
        case "2 Corinthians":   return "2Corinthians"
        case "1 Thessalonians": return "1Thessalonians"
        case "2 Thessalonians": return "2Thessalonians"
        case "1 Timothy":       return "1Timothy"
        case "2 Timothy":       return "2Timothy"
        case "1 Peter":         return "1Peter"
        case "2 Peter":         return "2Peter"
        case "1 John":          return "1John"
        case "2 John":          return "2John"
        case "3 John":          return "3John"
        default:                return bookName
        }
    }
}

// MARK: - Highlight Colour

enum HighlightColour: String, CaseIterable, Equatable {
    case yellow = "yellow"
    case pink   = "pink"
    case green  = "green"

    var color: Color {
        switch self {
        case .yellow: return Color.yellow.opacity(0.45)
        case .pink:   return Color.pink.opacity(0.38)
        case .green:  return Color.green.opacity(0.32)
        }
    }

    var label: String {
        switch self {
        case .yellow: return "Yellow"
        case .pink:   return "Pink"
        case .green:  return "Green"
        }
    }
}

// MARK: - Highlight Store

class HighlightStore: ObservableObject {
    static let shared = HighlightStore()

    private let storageKey = "verse_highlights"

    @Published private(set) var highlights: [String: String] = [:]

    init() { load() }

    func colour(for book: String, chapter: Int, verse: Int) -> HighlightColour? {
        guard let raw = highlights[key(book: book, chapter: chapter, verse: verse)] else { return nil }
        return HighlightColour(rawValue: raw)
    }

    func setHighlight(book: String, chapter: Int, verse: Int, colour: HighlightColour) {
        highlights[key(book: book, chapter: chapter, verse: verse)] = colour.rawValue
        save()
    }

    func removeHighlight(book: String, chapter: Int, verse: Int) {
        highlights.removeValue(forKey: key(book: book, chapter: chapter, verse: verse))
        save()
    }

    private func key(book: String, chapter: Int, verse: Int) -> String { "\(book)-\(chapter)-\(verse)" }
    private func save() { UserDefaults.standard.set(highlights, forKey: storageKey) }
    private func load() { highlights = UserDefaults.standard.dictionary(forKey: storageKey) as? [String: String] ?? [:] }
}
