import SwiftUI

// MARK: - BibleChapterView

struct BibleChapterView: View {
    let book: BibleBook
    let chapter: Int

    @ObservedObject private var highlightStore = HighlightStore.shared
    @State private var verses: [KJVVerseData] = []
    @State private var isLoading: Bool = true
    @State private var currentChapter: Int
    @State private var selectedVerse: Int? = nil

    init(book: BibleBook, chapter: Int) {
        self.book = book
        self.chapter = chapter
        self._currentChapter = State(initialValue: chapter)
    }

    var body: some View {
        ZStack {
            Color(hex: "#fdf6f6").ignoresSafeArea()

            if isLoading {
                VStack(spacing: 14) {
                    ProgressView()
                        .tint(.roseGold)
                        .scaleEffect(1.2)
                    Text("Loading \(book.name) \(currentChapter)…")
                        .font(.system(size: 13))
                        .foregroundColor(.textSoft)
                }

            } else if verses.isEmpty {
                VStack(spacing: 16) {
                    Text("📖")
                        .font(.system(size: 48))
                    Text("Chapter not found")
                        .font(.custom("Georgia", size: 20))
                        .italic()
                        .foregroundColor(.textDark)
                    Text("Make sure the JSON files are added\nto your Xcode project Resources folder.")
                        .font(.system(size: 13))
                        .foregroundColor(.textSoft)
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                }
                .padding(40)

            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {

                        // ── Chapter header ───────────────────
                        VStack(alignment: .leading, spacing: 6) {
                            Text(book.name.uppercased())
                                .font(.system(size: 10, weight: .semibold))
                                .tracking(3)
                                .foregroundColor(.roseGold)
                            Text("Chapter \(currentChapter)")
                                .font(.custom("Georgia", size: 28))
                                .italic()
                                .foregroundColor(.textDark)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                        .padding(.top, 28)
                        .padding(.bottom, 24)

                        // ── Verses ───────────────────────────
                        ForEach(verses) { verse in
                            verseRow(verse)
                        }

                        // ── Prev / Next navigation ────────────
                        chapterNavigation
                            .padding(.horizontal, 24)
                            .padding(.top, 16)
                            .padding(.bottom, 60)
                    }
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.3)) {
                        selectedVerse = nil
                    }
                }
            }
        }
        .navigationTitle("\(book.name) \(currentChapter)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { loadVerses() }
    }

    // MARK: - Verse Row

    @ViewBuilder
    private func verseRow(_ verse: KJVVerseData) -> some View {
        let isSelected = selectedVerse == verse.verse
        let highlight  = highlightStore.colour(for: book.name, chapter: currentChapter, verse: verse.verse)

        VStack(alignment: .leading, spacing: 0) {

            HStack(alignment: .top, spacing: 12) {
                // Verse number
                Text("\(verse.verse)")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(isSelected ? .white : .roseGold)
                    .frame(width: 24, alignment: .trailing)
                    .padding(.top, 4)

                // Verse text
                Text(verse.text.trimmingCharacters(in: .whitespacesAndNewlines))
                    .font(.custom("Georgia", size: 18))
                    .foregroundColor(isSelected ? .white : .textDark)
                    .lineSpacing(7)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(rowBackground(isSelected: isSelected, highlight: highlight))
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                    selectedVerse = isSelected ? nil : verse.verse
                }
            }

            // Colour picker slides in below selected verse
            if isSelected {
                highlightPicker(for: verse.verse, current: highlight)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }

    // MARK: - Row Background

    @ViewBuilder
    private func rowBackground(isSelected: Bool, highlight: HighlightColour?) -> some View {
        if isSelected {
            Color.roseGold
        } else if let hl = highlight {
            hl.color
        } else {
            Color.clear
        }
    }

    // MARK: - Highlight Picker

    private func highlightPicker(for verseNum: Int, current: HighlightColour?) -> some View {
        HStack(spacing: 0) {

            ForEach(HighlightColour.allCases, id: \.rawValue) { colour in
                Button(action: {
                    withAnimation(.spring(response: 0.25)) {
                        if current == colour {
                            highlightStore.removeHighlight(book: book.name, chapter: currentChapter, verse: verseNum)
                        } else {
                            highlightStore.setHighlight(book: book.name, chapter: currentChapter, verse: verseNum, colour: colour)
                        }
                        selectedVerse = nil
                    }
                }) {
                    HStack(spacing: 6) {
                        Circle()
                            .fill(colour.color)
                            .frame(width: 18, height: 18)
                            .overlay(
                                Circle().strokeBorder(
                                    current == colour ? Color.white : Color.clear,
                                    lineWidth: 2
                                )
                            )
                        Text(colour.label)
                            .font(.system(size: 13, weight: current == colour ? .semibold : .regular))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 11)
                }
                .buttonStyle(PlainButtonStyle())

                if colour.rawValue != HighlightColour.allCases.last?.rawValue {
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 1, height: 20)
                }
            }

            // Remove button — only shown if verse is already highlighted
            if current != nil {
                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 1, height: 20)

                Button(action: {
                    withAnimation(.spring(response: 0.25)) {
                        highlightStore.removeHighlight(book: book.name, chapter: currentChapter, verse: verseNum)
                        selectedVerse = nil
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                        .frame(width: 44)
                        .padding(.vertical, 11)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .background(Color(hex: "#2d1f1e"))
        .padding(.horizontal, 24)
        .padding(.bottom, 2)
    }

    // MARK: - Chapter Navigation

    private var chapterNavigation: some View {
        HStack(spacing: 16) {
            if currentChapter > 1 {
                Button(action: { navigateTo(currentChapter - 1) }) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 13, weight: .medium))
                        Text("Chapter \(currentChapter - 1)")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(.roseGold)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(14)
                    .shadow(color: Color(hex: "#f0c8c8").opacity(0.25), radius: 8, x: 0, y: 3)
                }
                .buttonStyle(PlainButtonStyle())
            }

            Spacer()

            if currentChapter < book.chapterCount {
                Button(action: { navigateTo(currentChapter + 1) }) {
                    HStack(spacing: 6) {
                        Text("Chapter \(currentChapter + 1)")
                            .font(.system(size: 14, weight: .medium))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient(
                            colors: [Color(hex: "#d4827a"), Color(hex: "#c9847a")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(14)
                    .shadow(color: Color.roseGold.opacity(0.3), radius: 8, x: 0, y: 3)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }

    // MARK: - Helpers

    private func navigateTo(_ newChapter: Int) {
        selectedVerse = nil
        currentChapter = newChapter
        isLoading = true
        verses = []
        loadVerses()
    }

    private func loadVerses() {
        DispatchQueue.global(qos: .userInitiated).async {
            let loaded = BibleLoader.shared.loadChapter(bookName: book.name, chapter: currentChapter)
            DispatchQueue.main.async {
                self.verses = loaded ?? []
                self.isLoading = false
            }
        }
    }
}
