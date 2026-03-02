import SwiftUI

// MARK: - BibleBookView

struct BibleBookView: View {
    let book: BibleBook
    @Environment(\.dismiss) private var dismiss

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color(hex: "#fde8e8"), Color(hex: "#fdf0f0"), Color(hex: "#ebe8f5")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 28) {

                        // ── Book header ──────────────────────
                        VStack(spacing: 6) {
                            Text(book.name)
                                .font(.custom("Georgia", size: 32))
                                .italic()
                                .foregroundColor(.textDark)
                            Text("\(book.testament) Testament · \(book.chapterCount) Chapters")
                                .font(.system(size: 13))
                                .foregroundColor(.textSoft)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 28)
                        .padding(.horizontal, 20)
                        .background(Color.white)
                        .cornerRadius(24)
                        .shadow(color: Color(hex: "#f0c8c8").opacity(0.2), radius: 12, x: 0, y: 4)
                        .padding(.horizontal, 20)

                        // ── Chapter label ────────────────────
                        Text("SELECT A CHAPTER")
                            .font(.system(size: 13, weight: .semibold))
                            .tracking(2.5)
                            .foregroundColor(.textDark)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)

                        // ── Chapter grid ─────────────────────
                        LazyVGrid(columns: columns, spacing: 14) {
                            ForEach(1...book.chapterCount, id: \.self) { chapter in
                                NavigationLink(destination: BibleChapterView(book: book, chapter: chapter)) {
                                    Text("\(chapter)")
                                        .font(.system(size: 17, weight: .medium))
                                        .minimumScaleFactor(0.6)
                                        .lineLimit(1)
                                        .foregroundColor(.textDark)
                                        .frame(maxWidth: .infinity)
                                        .aspectRatio(1, contentMode: .fit)
                                        .background(Color.white)
                                        .cornerRadius(16)
                                        .shadow(color: Color(hex: "#f0c8c8").opacity(0.25), radius: 6, x: 0, y: 2)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                    .padding(.top, 16)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.roseGold)
                }
            }
        }
    }
}
