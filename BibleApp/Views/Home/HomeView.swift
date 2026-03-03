import SwiftUI

// MARK: - Design Tokens

extension Color {
    static let blushWhite   = Color(hex: "#fffcfa")
    static let blushLight   = Color(hex: "#fdf0f0")
    static let blushMid     = Color(hex: "#f7d9d9")
    static let roseGold     = Color(hex: "#c9847a")
    static let roseDeep     = Color(hex: "#a85d55")
    static let sageLight    = Color(hex: "#e8f0ea")
    static let lavenderHint = Color(hex: "#ede8f5")
    static let textDark     = Color(hex: "#2d1f1e")
    static let textMid      = Color(hex: "#7a5c5a")
    static let textSoft     = Color(hex: "#b89896")
}

// MARK: - HomeView

struct HomeView: View {
    @EnvironmentObject var authState: AuthenticationState
    @StateObject private var viewModel = DevotionViewModel()

    @State private var selectedFeeling: String = "overwhelmed"
    @State private var savedVerses: Set<String> = []
    @State private var showShareSheet: Bool = false
    @State private var shareText: String = ""
    @State private var cardVisible: Bool = false
    @State private var selectedCategory: BrowseCategory? = nil  // .sheet(item:) handles nil safely

    let feelings = ["Overwhelmed", "Worried", "Tired", "Grateful", "Lonely"]

    let promises: [String: MomPromise] = [
        "overwhelmed": MomPromise(
            situation: "When you're overwhelmed",
            reflection: "You are not failing. You are carrying more than most could bear — and God sees every quiet act of love you give your family.",
            verse: "Come to me, all you who are weary and burdened, and I will give you rest.",
            reference: "Matthew 11:28",
            category: "Overwhelmed"
        ),
        "worried": MomPromise(
            situation: "When worry won't let go",
            reflection: "The same God who holds the stars holds your children. You can release what you cannot control into hands far more capable than yours.",
            verse: "Cast all your anxiety on him because he cares for you.",
            reference: "1 Peter 5:7",
            category: "Worry"
        ),
        "tired": MomPromise(
            situation: "When you're running on empty",
            reflection: "Rest is not laziness — it is trust. God does not require you to pour from an empty vessel. He renews what the world depletes.",
            verse: "He gives strength to the weary and increases the power of the weak.",
            reference: "Isaiah 40:29",
            category: "Weariness"
        ),
        "grateful": MomPromise(
            situation: "When your heart is full",
            reflection: "Gratitude is a form of worship. Every good thing in your home is a fingerprint of God's faithfulness to you.",
            verse: "Give thanks to the Lord, for he is good; his love endures forever.",
            reference: "Psalm 107:1",
            category: "Joy"
        ),
        "lonely": MomPromise(
            situation: "When motherhood feels isolating",
            reflection: "You may feel unseen — but you are deeply known. God is present in the quiet, unwitnessed work of loving your children well.",
            verse: "The Lord himself goes before you and will be with you; he will never leave you nor forsake you.",
            reference: "Deuteronomy 31:8",
            category: "Encouragement"
        )
    ]

    let featuredCategories: [BrowseCategory] = [
        BrowseCategory(emoji: "😩", title: "Overwhelmed",      subtitle: "When everything feels like too much"),
        BrowseCategory(emoji: "🌙", title: "Sleepless Nights", subtitle: "For the 3am moments no one else sees"),
        BrowseCategory(emoji: "🙏", title: "Prayer",           subtitle: "When you don't know what to say to God")
    ]

    var currentPromise: MomPromise {
        promises[selectedFeeling] ?? promises["overwhelmed"]!
    }

    var greetingText: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }

    var formattedDate: String {
        let f = DateFormatter()
        f.dateFormat = "EEEE, MMMM d"
        return f.string(from: Date())
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#fde8e8"), Color(hex: "#fdf0f0"), Color(hex: "#e8eaf5")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    headerSection
                    VStack(spacing: 24) {
                        feelingSection
                        promiseCard
                        DailyQuizCard()
                        browseTeaserSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    .padding(.bottom, 110)
                }
            }
        }
        .navigationBarHidden(true)
        // Share sheet
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: [shareText])
        }
        // Category sheet — .sheet(item:) guarantees content is ready before presenting
        .sheet(item: $selectedCategory) { cat in
            CategorySheet(category: cat)
        }
        .onAppear {
            viewModel.loadCompletedDaysForWeek()
            withAnimation(.easeOut(duration: 0.6)) { cardVisible = true }
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [Color(hex: "#f9d4d4"), Color(hex: "#fce8e8"), Color(hex: "#fff6f6")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(maxWidth: .infinity)
            .frame(height: 240)

            Circle()
                .fill(Color.white.opacity(0.4))
                .frame(width: 200, height: 200)
                .offset(x: 120, y: -60)
                .blur(radius: 30)

            Circle()
                .fill(Color(hex: "#f9d4d4").opacity(0.5))
                .frame(width: 140, height: 140)
                .offset(x: -130, y: 20)
                .blur(radius: 20)

            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("DEAR MOM")
                            .font(.system(size: 10, weight: .semibold))
                            .tracking(3.5)
                            .foregroundColor(.roseGold)

                        Text(formattedDate)
                            .font(.system(size: 12))
                            .foregroundColor(.textSoft)
                    }

                    Spacer()

                    HStack(spacing: 5) {
                        Text("🌸")
                            .font(.system(size: 14))
                        Text("\(max(viewModel.completedDays.count, 1)) day streak")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.roseDeep)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.7))
                    .clipShape(Capsule())
                    .shadow(color: Color.roseGold.opacity(0.15), radius: 6, x: 0, y: 2)
                }
                .padding(.horizontal, 24)
                .padding(.top, 56)

                Spacer()

                VStack(alignment: .leading, spacing: 4) {
                    Text(greetingText)
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(.textMid)
                        .tracking(0.5)

                    Text("precious mom.")
                        .font(.custom("Georgia", size: 32))
                        .italic()
                        .foregroundColor(.textDark)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 28)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 240)
        }
        .clipShape(RoundedCorner(radius: 36, corners: [.bottomLeft, .bottomRight]))
        .shadow(color: Color(hex: "#f9d4d4").opacity(0.5), radius: 20, x: 0, y: 8)
    }

    // MARK: - Feeling Section

    private var feelingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("HOW ARE YOU FEELING?")
                .font(.system(size: 10, weight: .semibold))
                .tracking(2.5)
                .foregroundColor(.textSoft)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(feelings, id: \.self) { feeling in
                        let key = feeling.lowercased()
                        Button(action: {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                                selectedFeeling = key
                            }
                        }) {
                            Text(feeling)
                                .font(.system(size: 14, weight: selectedFeeling == key ? .semibold : .regular))
                                .foregroundColor(selectedFeeling == key ? .white : .roseGold)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 10)
                                .background(
                                    selectedFeeling == key
                                        ? LinearGradient(colors: [Color(hex: "#d4827a"), Color(hex: "#c9847a")],
                                                         startPoint: .topLeading, endPoint: .bottomTrailing)
                                        : LinearGradient(colors: [Color.white, Color.white],
                                                         startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .clipShape(Capsule())
                                .shadow(
                                    color: selectedFeeling == key ? Color.roseGold.opacity(0.35) : Color.black.opacity(0.05),
                                    radius: selectedFeeling == key ? 8 : 4,
                                    x: 0, y: 3
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 2)
                .padding(.vertical, 4)
            }
        }
    }

    // MARK: - Promise Card

    private var promiseCard: some View {
        VStack(alignment: .leading, spacing: 0) {

            HStack {
                Text("✦  TODAY'S PROMISE")
                    .font(.system(size: 10, weight: .semibold))
                    .tracking(2)
                    .foregroundColor(.roseGold)
                Spacer()
                Text(currentPromise.category.uppercased())
                    .font(.system(size: 9, weight: .medium))
                    .tracking(1.5)
                    .foregroundColor(.textSoft)
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 14)
            .background(Color(hex: "#fdf0f0"))

            VStack(alignment: .leading, spacing: 18) {

                Text(currentPromise.situation)
                    .font(.system(size: 12, weight: .medium))
                    .tracking(0.5)
                    .foregroundColor(.textSoft)
                    .padding(.top, 4)

                Text("\u{201C}\(currentPromise.reflection)\u{201D}")
                    .font(.custom("Georgia", size: 19))
                    .italic()
                    .foregroundColor(.textDark)
                    .lineSpacing(7)
                    .fixedSize(horizontal: false, vertical: true)

                Rectangle()
                    .fill(Color.blushMid)
                    .frame(height: 1)

                VStack(alignment: .leading, spacing: 10) {
                    Text(currentPromise.verse)
                        .font(.custom("Georgia", size: 17))
                        .foregroundColor(.textMid)
                        .lineSpacing(6)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("— \(currentPromise.reference)")
                        .font(.system(size: 11, weight: .semibold))
                        .tracking(1.5)
                        .foregroundColor(.roseGold)
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
                .cornerRadius(16)

                HStack(spacing: 10) {
                    Button(action: {
                        withAnimation(.spring()) {
                            if savedVerses.contains(currentPromise.reference) {
                                savedVerses.remove(currentPromise.reference)
                            } else {
                                savedVerses.insert(currentPromise.reference)
                            }
                        }
                    }) {
                        HStack(spacing: 7) {
                            Image(systemName: savedVerses.contains(currentPromise.reference) ? "heart.fill" : "heart")
                                .font(.system(size: 14))
                                .foregroundColor(savedVerses.contains(currentPromise.reference) ? Color(hex: "#d4827a") : .textSoft)
                            Text(savedVerses.contains(currentPromise.reference) ? "Saved" : "Save")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.textMid)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(Color.blushLight)
                        .cornerRadius(14)
                    }
                    .buttonStyle(PlainButtonStyle())

                    Button(action: {
                        shareText = "\u{201C}\(currentPromise.verse)\u{201D}\n\u{2014} \(currentPromise.reference)\n\nShared from Dear Mom: Bible Promises"
                        showShareSheet = true
                    }) {
                        HStack(spacing: 7) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 14))
                            Text("Share")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(
                            LinearGradient(
                                colors: [Color(hex: "#d4827a"), Color(hex: "#c9847a")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(14)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(22)
        }
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color(hex: "#f0c8c8").opacity(0.4), radius: 20, x: 0, y: 8)
        .opacity(cardVisible ? 1 : 0)
        .offset(y: cardVisible ? 0 : 12)
        .animation(.easeOut(duration: 0.5).delay(0.1), value: cardVisible)
    }

    // MARK: - Browse Teaser

    private var browseTeaserSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("FIND A PROMISE FOR THIS MOMENT")
                .font(.system(size: 10, weight: .semibold))
                .tracking(2)
                .foregroundColor(.textSoft)

            VStack(spacing: 10) {
                ForEach(featuredCategories) { cat in
                    teaserRow(cat)
                }
            }

            NavigationLink(destination: BrowseView()) {
                Text("Browse all topics →")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.roseGold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 4)
            }
        }
    }

    // MARK: - Teaser Row

    private func teaserRow(_ cat: BrowseCategory) -> some View {
        Button(action: {
            // Setting item directly triggers .sheet(item:) safely
            selectedCategory = cat
        }) {
            HStack(spacing: 16) {
                Text(cat.emoji)
                    .font(.system(size: 28))
                    .frame(width: 50, height: 50)
                    .background(Color(hex: "#fff0f0"))
                    .cornerRadius(14)

                VStack(alignment: .leading, spacing: 3) {
                    Text(cat.title)
                        .font(.custom("Georgia", size: 16))
                        .foregroundColor(.textDark)
                    Text(cat.subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.textSoft)
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.textSoft)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(18)
            .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 3)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview

#Preview("iPhone 15") {
    NavigationStack {
        HomeView()
            .environmentObject(AuthenticationState())
    }
}
