import SwiftUI

struct SavedView: View {
    @StateObject private var store = SavedPromisesStore.shared

    // Lets the empty-state CTA jump back to the Today tab.
    // Pass a real binding from TabBarView; defaults to a no-op constant
    // so this view still works and previews fine on its own.
    var selectedTab: Binding<Int> = .constant(0)

    var body: some View {
        Group {
            if store.savedItems.isEmpty {
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
        VStack(spacing: 22) {
            Spacer()

            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "#fdeaea"), Color(hex: "#f7d9d9")],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 88, height: 88)

                Image(systemName: "heart.fill")
                    .font(.system(size: 30))
                    .foregroundColor(Color(hex: "#d4846a"))
            }

            VStack(spacing: 8) {
                Text("Your saved promises live here")
                    .font(.custom("Georgia", size: 19))
                    .foregroundColor(Color(hex: "#2c1f14"))
                    .multilineTextAlignment(.center)

                Text("Tap the heart on today's promise\nto keep it close and come back anytime.")
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#9e7e62"))
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
            }
            .padding(.horizontal, 32)

            Button {
                selectedTab.wrappedValue = 0
            } label: {
                HStack(spacing: 7) {
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 13))
                    Text("Go to today's promise")
                        .font(.system(size: 14, weight: .medium))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 22)
                .padding(.vertical, 13)
                .background(
                    LinearGradient(
                        colors: [Color(hex: "#d4846a"), Color(hex: "#c9847a")],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(Capsule())
                .shadow(color: Color(hex: "#d4846a").opacity(0.3), radius: 10, y: 4)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.top, 4)

            Spacer()
            Spacer()
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Saved List

    private var savedList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(store.savedItems) { item in
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
                    store.remove(id: item.id)
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
