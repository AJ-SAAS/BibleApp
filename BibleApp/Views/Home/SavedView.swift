import SwiftUI

struct SavedView: View {
    // TODO: Replace with Firebase fetch when ready
    @State private var savedItems: [SavedPromise] = []

    var body: some View {
        Group {
            if savedItems.isEmpty {
                emptyState
            } else {
                savedList
            }
        }
        .background(Color(hex: "#faf6f0").ignoresSafeArea())
        .navigationTitle("Saved")
        .navigationBarTitleDisplayMode(.large)
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()

            Text("♡")
                .font(.system(size: 60))
                .foregroundColor(Color(hex: "#e8c88a"))

            Text("Your saved promises")
                .font(.custom("Georgia", size: 22))
                .italic()
                .foregroundColor(Color(hex: "#2c1f14"))

            Text("Tap the heart on any promise\nto save it here for later.")
                .font(.system(size: 14))
                .foregroundColor(Color(hex: "#9e7e62"))
                .multilineTextAlignment(.center)
                .lineSpacing(5)

            Spacer()
        }
        .padding(.horizontal, 40)
    }

    // MARK: - Saved List

    private var savedList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(savedItems) { item in
                    savedCard(item)
                }
            }
            .padding(16)
            .padding(.bottom, 80)
        }
    }

    // MARK: - Saved Card

    private func savedCard(_ item: SavedPromise) -> some View {
        VStack(alignment: .leading, spacing: 10) {

            HStack {
                Text(item.category.uppercased())
                    .font(.system(size: 9, weight: .semibold))
                    .tracking(2)
                    .foregroundColor(Color(hex: "#c4924a"))
                Spacer()
                Button(action: {
                    savedItems.removeAll { $0.id == item.id }
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color(hex: "#d4846a"))
                        .font(.system(size: 14))
                }
                .buttonStyle(PlainButtonStyle())
            }

            Text(item.situation)
                .font(.system(size: 10, weight: .medium))
                .tracking(1)
                .foregroundColor(Color(hex: "#9e7e62"))

            Text("\u{201C}\(item.verse)\u{201D}")
                .font(.custom("Georgia", size: 15))
                .italic()
                .foregroundColor(Color(hex: "#2c1f14"))
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            Text(item.reference)
                .font(.system(size: 9, weight: .bold))
                .tracking(1.5)
                .foregroundColor(Color(hex: "#c4924a"))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(18)
        .background(.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
        .overlay(
            HStack {
                RoundedRectangle(cornerRadius: 2)
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "#c4924a"), Color(hex: "#d4846a")],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 3)
                    .padding(.vertical, 18)
                Spacer()
            }
            .clipShape(RoundedRectangle(cornerRadius: 18))
        )
    }
}

#Preview("iPhone 15") {
    NavigationStack {
        SavedView()
    }
}
