import SwiftUI

struct CategorySheet: View {
    let category: BrowseCategory
    @Environment(\.dismiss) private var dismiss

    var situations: [Situation] {
        ContentData.all[category.title]?.situations ?? []
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color(hex: "#fff6f6"), Color(hex: "#fffcfa")],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {

                        // ── Category Header ──
                        VStack(spacing: 10) {
                            Text(category.emoji)
                                .font(.system(size: 48))

                            Text(category.title)
                                .font(.custom("Georgia", size: 28))
                                .italic()
                                .foregroundColor(Color(hex: "#2d1f1e"))

                            Text(category.subtitle)
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#b89896"))
                                .multilineTextAlignment(.center)
                                .lineSpacing(3)
                                .padding(.horizontal, 16)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 28)
                        .padding(.horizontal, 20)
                        .background(Color.white)
                        .cornerRadius(24)
                        .shadow(color: Color(hex: "#f0c8c8").opacity(0.2), radius: 12, x: 0, y: 4)
                        .padding(.horizontal, 20)
                        .padding(.top, 8)

                        // ── Situation Cards ──
                        if situations.isEmpty {
                            Text("Content coming soon.")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#b89896"))
                                .padding(.top, 40)
                        } else {
                            ForEach(situations) { situation in
                                situationCard(situation)
                            }
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationTitle(category.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color(hex: "#c9847a"))
                }
            }
        }
    }

    // MARK: - Situation Card

    private func situationCard(_ situation: Situation) -> some View {
        VStack(alignment: .leading, spacing: 14) {

            // When label
            Text("WHEN YOU NEED THIS")
                .font(.system(size: 9, weight: .semibold))
                .tracking(2.5)
                .foregroundColor(Color(hex: "#c9847a"))

            // Situation headline
            Text(situation.when)
                .font(.custom("Georgia", size: 19))
                .italic()
                .foregroundColor(Color(hex: "#2d1f1e"))
                .lineSpacing(5)
                .fixedSize(horizontal: false, vertical: true)

            // Divider
            Rectangle()
                .fill(Color(hex: "#fde8e8"))
                .frame(height: 1)

            // Reflection
            Text(situation.reflection)
                .font(.system(size: 15))
                .foregroundColor(Color(hex: "#7a5c5a"))
                .lineSpacing(6)
                .fixedSize(horizontal: false, vertical: true)

            // Verse block
            VStack(alignment: .leading, spacing: 8) {
                Text("\u{201C}\(situation.verse)\u{201D}")
                    .font(.custom("Georgia", size: 16))
                    .italic()
                    .foregroundColor(Color(hex: "#2d1f1e"))
                    .lineSpacing(5)
                    .fixedSize(horizontal: false, vertical: true)

                Text("— \(situation.reference)")
                    .font(.system(size: 10, weight: .semibold))
                    .tracking(1.5)
                    .foregroundColor(Color(hex: "#c9847a"))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(16)
            .background(
                LinearGradient(
                    colors: [Color(hex: "#fff6f6"), Color(hex: "#fdf0f0")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(14)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(22)
        .shadow(color: Color(hex: "#f0c8c8").opacity(0.25), radius: 10, x: 0, y: 4)
        .padding(.horizontal, 20)
    }
}
