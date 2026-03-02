import SwiftUI

// MARK: - Bible Book Model

struct BibleBook: Identifiable {
    let id = UUID()
    let name: String
    let testament: String
    let abbreviation: String
    let chapterCount: Int
}

// MARK: - BibleView

struct BibleView: View {
    @State private var searchText: String = ""
    @State private var selectedBook: BibleBook? = nil

    let oldTestament: [BibleBook] = [
        BibleBook(name: "Genesis",        testament: "Old", abbreviation: "Gen",   chapterCount: 50),
        BibleBook(name: "Exodus",         testament: "Old", abbreviation: "Exod",  chapterCount: 40),
        BibleBook(name: "Leviticus",      testament: "Old", abbreviation: "Lev",   chapterCount: 27),
        BibleBook(name: "Numbers",        testament: "Old", abbreviation: "Num",   chapterCount: 36),
        BibleBook(name: "Deuteronomy",    testament: "Old", abbreviation: "Deut",  chapterCount: 34),
        BibleBook(name: "Joshua",         testament: "Old", abbreviation: "Josh",  chapterCount: 24),
        BibleBook(name: "Judges",         testament: "Old", abbreviation: "Judg",  chapterCount: 21),
        BibleBook(name: "Ruth",           testament: "Old", abbreviation: "Ruth",  chapterCount: 4),
        BibleBook(name: "1 Samuel",       testament: "Old", abbreviation: "1Sam",  chapterCount: 31),
        BibleBook(name: "2 Samuel",       testament: "Old", abbreviation: "2Sam",  chapterCount: 24),
        BibleBook(name: "1 Kings",        testament: "Old", abbreviation: "1Kgs",  chapterCount: 22),
        BibleBook(name: "2 Kings",        testament: "Old", abbreviation: "2Kgs",  chapterCount: 25),
        BibleBook(name: "1 Chronicles",   testament: "Old", abbreviation: "1Chr",  chapterCount: 29),
        BibleBook(name: "2 Chronicles",   testament: "Old", abbreviation: "2Chr",  chapterCount: 36),
        BibleBook(name: "Ezra",           testament: "Old", abbreviation: "Ezra",  chapterCount: 10),
        BibleBook(name: "Nehemiah",       testament: "Old", abbreviation: "Neh",   chapterCount: 13),
        BibleBook(name: "Esther",         testament: "Old", abbreviation: "Esth",  chapterCount: 10),
        BibleBook(name: "Job",            testament: "Old", abbreviation: "Job",   chapterCount: 42),
        BibleBook(name: "Psalms",         testament: "Old", abbreviation: "Ps",    chapterCount: 150),
        BibleBook(name: "Proverbs",       testament: "Old", abbreviation: "Prov",  chapterCount: 31),
        BibleBook(name: "Ecclesiastes",   testament: "Old", abbreviation: "Eccl",  chapterCount: 12),
        BibleBook(name: "Song of Solomon",testament: "Old", abbreviation: "Song",  chapterCount: 8),
        BibleBook(name: "Isaiah",         testament: "Old", abbreviation: "Isa",   chapterCount: 66),
        BibleBook(name: "Jeremiah",       testament: "Old", abbreviation: "Jer",   chapterCount: 52),
        BibleBook(name: "Lamentations",   testament: "Old", abbreviation: "Lam",   chapterCount: 5),
        BibleBook(name: "Ezekiel",        testament: "Old", abbreviation: "Ezek",  chapterCount: 48),
        BibleBook(name: "Daniel",         testament: "Old", abbreviation: "Dan",   chapterCount: 12),
        BibleBook(name: "Hosea",          testament: "Old", abbreviation: "Hos",   chapterCount: 14),
        BibleBook(name: "Joel",           testament: "Old", abbreviation: "Joel",  chapterCount: 3),
        BibleBook(name: "Amos",           testament: "Old", abbreviation: "Amos",  chapterCount: 9),
        BibleBook(name: "Obadiah",        testament: "Old", abbreviation: "Obad",  chapterCount: 1),
        BibleBook(name: "Jonah",          testament: "Old", abbreviation: "Jonah", chapterCount: 4),
        BibleBook(name: "Micah",          testament: "Old", abbreviation: "Mic",   chapterCount: 7),
        BibleBook(name: "Nahum",          testament: "Old", abbreviation: "Nah",   chapterCount: 3),
        BibleBook(name: "Habakkuk",       testament: "Old", abbreviation: "Hab",   chapterCount: 3),
        BibleBook(name: "Zephaniah",      testament: "Old", abbreviation: "Zeph",  chapterCount: 3),
        BibleBook(name: "Haggai",         testament: "Old", abbreviation: "Hag",   chapterCount: 2),
        BibleBook(name: "Zechariah",      testament: "Old", abbreviation: "Zech",  chapterCount: 14),
        BibleBook(name: "Malachi",        testament: "Old", abbreviation: "Mal",   chapterCount: 4)
    ]

    let newTestament: [BibleBook] = [
        BibleBook(name: "Matthew",        testament: "New", abbreviation: "Matt",  chapterCount: 28),
        BibleBook(name: "Mark",           testament: "New", abbreviation: "Mark",  chapterCount: 16),
        BibleBook(name: "Luke",           testament: "New", abbreviation: "Luke",  chapterCount: 24),
        BibleBook(name: "John",           testament: "New", abbreviation: "John",  chapterCount: 21),
        BibleBook(name: "Acts",           testament: "New", abbreviation: "Acts",  chapterCount: 28),
        BibleBook(name: "Romans",         testament: "New", abbreviation: "Rom",   chapterCount: 16),
        BibleBook(name: "1 Corinthians",  testament: "New", abbreviation: "1Cor",  chapterCount: 16),
        BibleBook(name: "2 Corinthians",  testament: "New", abbreviation: "2Cor",  chapterCount: 13),
        BibleBook(name: "Galatians",      testament: "New", abbreviation: "Gal",   chapterCount: 6),
        BibleBook(name: "Ephesians",      testament: "New", abbreviation: "Eph",   chapterCount: 6),
        BibleBook(name: "Philippians",    testament: "New", abbreviation: "Phil",  chapterCount: 4),
        BibleBook(name: "Colossians",     testament: "New", abbreviation: "Col",   chapterCount: 4),
        BibleBook(name: "1 Thessalonians",testament: "New", abbreviation: "1Thes", chapterCount: 5),
        BibleBook(name: "2 Thessalonians",testament: "New", abbreviation: "2Thes", chapterCount: 3),
        BibleBook(name: "1 Timothy",      testament: "New", abbreviation: "1Tim",  chapterCount: 6),
        BibleBook(name: "2 Timothy",      testament: "New", abbreviation: "2Tim",  chapterCount: 4),
        BibleBook(name: "Titus",          testament: "New", abbreviation: "Titus", chapterCount: 3),
        BibleBook(name: "Philemon",       testament: "New", abbreviation: "Phlm",  chapterCount: 1),
        BibleBook(name: "Hebrews",        testament: "New", abbreviation: "Heb",   chapterCount: 13),
        BibleBook(name: "James",          testament: "New", abbreviation: "Jas",   chapterCount: 5),
        BibleBook(name: "1 Peter",        testament: "New", abbreviation: "1Pet",  chapterCount: 5),
        BibleBook(name: "2 Peter",        testament: "New", abbreviation: "2Pet",  chapterCount: 3),
        BibleBook(name: "1 John",         testament: "New", abbreviation: "1John", chapterCount: 5),
        BibleBook(name: "2 John",         testament: "New", abbreviation: "2John", chapterCount: 1),
        BibleBook(name: "3 John",         testament: "New", abbreviation: "3John", chapterCount: 1),
        BibleBook(name: "Jude",           testament: "New", abbreviation: "Jude",  chapterCount: 1),
        BibleBook(name: "Revelation",     testament: "New", abbreviation: "Rev",   chapterCount: 22)
    ]

    var allBooks: [BibleBook] { oldTestament + newTestament }

    var filteredOT: [BibleBook] {
        searchText.isEmpty ? oldTestament :
        oldTestament.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var filteredNT: [BibleBook] {
        searchText.isEmpty ? newTestament :
        newTestament.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var isSearching: Bool { !searchText.isEmpty }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#fde8e8"), Color(hex: "#fdf0f0"), Color(hex: "#ebe8f5")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Search bar ───────────────────────────────
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.textSoft)
                        .font(.system(size: 16))
                    TextField("Search books of the Bible...", text: $searchText)
                        .font(.system(size: 15))
                        .foregroundColor(.textDark)
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.textSoft)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 13)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color(hex: "#f0c8c8").opacity(0.3), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 16)

                // ── Book list ────────────────────────────────
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {

                        // Old Testament
                        if !filteredOT.isEmpty {
                            testamentSection(
                                title: "OLD TESTAMENT",
                                subtitle: "\(oldTestament.count) books",
                                books: filteredOT
                            )
                        }

                        // New Testament
                        if !filteredNT.isEmpty {
                            testamentSection(
                                title: "NEW TESTAMENT",
                                subtitle: "\(newTestament.count) books",
                                books: filteredNT
                            )
                        }

                        // No results
                        if filteredOT.isEmpty && filteredNT.isEmpty {
                            VStack(spacing: 12) {
                                Text("📖")
                                    .font(.system(size: 40))
                                Text("No books found for \"\(searchText)\"")
                                    .font(.system(size: 14))
                                    .foregroundColor(.textSoft)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 60)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }
        }
        .navigationTitle("Bible Study")
        .navigationBarTitleDisplayMode(.large)
        .sheet(item: $selectedBook) { book in
            BibleBookView(book: book)
        }
    }

    // MARK: - Testament Section

    private func testamentSection(title: String, subtitle: String, books: [BibleBook]) -> some View {
        VStack(alignment: .leading, spacing: 12) {

            // Section header
            HStack(alignment: .bottom) {
                Text(title)
                    .font(.system(size: 10, weight: .semibold))
                    .tracking(2.5)
                    .foregroundColor(.textSoft)
                Spacer()
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundColor(.textSoft)
            }

            // Book cards
            VStack(spacing: 8) {
                ForEach(books) { book in
                    Button(action: { selectedBook = book }) {
                        bookRow(book)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }

    // MARK: - Book Row

    private func bookRow(_ book: BibleBook) -> some View {
        HStack(spacing: 16) {

            // Abbreviation badge
            Text(book.abbreviation)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.roseGold)
                .frame(width: 46, height: 46)
                .background(Color(hex: "#fff0f0"))
                .cornerRadius(12)

            // Name + chapter count
            VStack(alignment: .leading, spacing: 3) {
                Text(book.name)
                    .font(.custom("Georgia", size: 17))
                    .foregroundColor(.textDark)
                Text("\(book.chapterCount) chapter\(book.chapterCount == 1 ? "" : "s")")
                    .font(.system(size: 12))
                    .foregroundColor(.textSoft)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.textSoft)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: Color(hex: "#f0c8c8").opacity(0.22), radius: 8, x: 0, y: 3)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        BibleView()
    }
}
