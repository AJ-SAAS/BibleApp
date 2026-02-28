import SwiftUI

// MARK: - BrowseView

struct BrowseView: View {
    @State private var searchText: String = ""
    @State private var selectedCategory: BrowseCategory? = nil  // .sheet(item:) handles nil safely

    let allCategories: [BrowseCategory] = [
        BrowseCategory(emoji: "😤", title: "Anger",            subtitle: "When frustration gets the better of you"),
        BrowseCategory(emoji: "🌟", title: "Assurance",        subtitle: "When you need to know you are enough"),
        BrowseCategory(emoji: "👶", title: "Babies",           subtitle: "For the tender, exhausting newborn days"),
        BrowseCategory(emoji: "🔥", title: "Burnout",          subtitle: "When you have nothing left to give"),
        BrowseCategory(emoji: "👧", title: "Children",         subtitle: "Promises for the ones in your care"),
        BrowseCategory(emoji: "💪", title: "Courage",          subtitle: "When fear is louder than faith"),
        BrowseCategory(emoji: "😢", title: "Depression",       subtitle: "For the days that feel impossibly heavy"),
        BrowseCategory(emoji: "🌿", title: "Encouragement",    subtitle: "A word to lift you when you're low"),
        BrowseCategory(emoji: "🙏", title: "Faith",            subtitle: "When belief feels thin and fragile"),
        BrowseCategory(emoji: "👨‍👩‍👧", title: "Family",           subtitle: "For the people who make your world"),
        BrowseCategory(emoji: "😨", title: "Fear",             subtitle: "When anxiety grips your heart"),
        BrowseCategory(emoji: "💛", title: "Forgiveness",      subtitle: "For yourself and for others"),
        BrowseCategory(emoji: "🔮", title: "Future",           subtitle: "When tomorrow feels uncertain"),
        BrowseCategory(emoji: "😔", title: "Grief",            subtitle: "When loss has hollowed you out"),
        BrowseCategory(emoji: "💖", title: "Hope",             subtitle: "A light for your darkest moments"),
        BrowseCategory(emoji: "🌱", title: "Infertility",      subtitle: "For the long and heartbreaking wait"),
        BrowseCategory(emoji: "✨", title: "Joy",              subtitle: "Celebrating what God has given you"),
        BrowseCategory(emoji: "💔", title: "Miscarriage",      subtitle: "When your arms ache for what was lost"),
        BrowseCategory(emoji: "🤱", title: "Motherhood",       subtitle: "For the calling you carry every day"),
        BrowseCategory(emoji: "😩", title: "Overwhelmed",      subtitle: "When everything feels like too much"),
        BrowseCategory(emoji: "🕊️", title: "Peace",            subtitle: "Stillness for your restless heart"),
        BrowseCategory(emoji: "📿", title: "Prayer",           subtitle: "When you don't know what to say to God"),
        BrowseCategory(emoji: "🛡️", title: "Protection",       subtitle: "Trusting God to guard your children"),
        BrowseCategory(emoji: "😴", title: "Rest",             subtitle: "Permission to stop and be still"),
        BrowseCategory(emoji: "🌙", title: "Sleepless Nights", subtitle: "For the 3am moments no one else sees"),
        BrowseCategory(emoji: "⏳", title: "Waiting",          subtitle: "When God's timing feels too slow"),
        BrowseCategory(emoji: "😓", title: "Weariness",        subtitle: "For the bone-deep tired of motherhood"),
        BrowseCategory(emoji: "🧠", title: "Wisdom",           subtitle: "When you don't know what to do next"),
        BrowseCategory(emoji: "😟", title: "Worry",            subtitle: "Releasing what you cannot control")
    ]

    var filteredCategories: [BrowseCategory] {
        if searchText.isEmpty { return allCategories }
        return allCategories.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.subtitle.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#fde8e8"), Color(hex: "#fdf0f0"), Color(hex: "#ebe8f5")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {

                // Search bar
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(hex: "#b89896"))
                        .font(.system(size: 16))
                    TextField("Search for a topic...", text: $searchText)
                        .font(.system(size: 15))
                        .foregroundColor(Color(hex: "#2d1f1e"))
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color(hex: "#b89896"))
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
                .padding(.bottom, 20)

                // Topic count when searching
                if !searchText.isEmpty {
                    Text("\(filteredCategories.count) topic\(filteredCategories.count == 1 ? "" : "s") found")
                        .font(.system(size: 11))
                        .foregroundColor(Color(hex: "#b89896"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)
                }

                // Single column list
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(filteredCategories) { cat in
                            Button(action: {
                                // Setting item directly triggers .sheet(item:) safely
                                selectedCategory = cat
                            }) {
                                categoryCard(cat)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }
        }
        .navigationTitle("Browse")
        .navigationBarTitleDisplayMode(.large)
        // .sheet(item:) only presents when selectedCategory is non-nil — no blank screens
        .sheet(item: $selectedCategory) { cat in
            CategorySheet(category: cat)
        }
    }

    // MARK: - Category Card

    private func categoryCard(_ cat: BrowseCategory) -> some View {
        HStack(spacing: 18) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "#fff0f0"), Color(hex: "#fde8e8")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 58, height: 58)
                Text(cat.emoji)
                    .font(.system(size: 26))
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(cat.title)
                    .font(.custom("Georgia", size: 18))
                    .foregroundColor(Color(hex: "#2d1f1e"))

                Text(cat.subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#b89896"))
                    .lineLimit(2)
                    .lineSpacing(2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(hex: "#c9847a"))
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color(hex: "#f0c8c8").opacity(0.25), radius: 10, x: 0, y: 4)
    }
}

// MARK: - Preview

#Preview("iPhone 15") {
    NavigationStack {
        BrowseView()
    }
}
