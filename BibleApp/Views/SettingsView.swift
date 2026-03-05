import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var authState: AuthenticationState
    @StateObject private var viewModel = AuthViewModel()
    @State private var name: String = ""
    @State private var ageRange: String = ""
    @State private var email: String = ""
    @State private var denomination: String = ""
    @State private var church: String = ""
    @State private var bibleGoal: String = ""
    @State private var readingFrequency: String = ""
    @State private var spiritualGoal: String = ""
    @State private var guidancePreference: String = ""
    @State private var biggestChallenge: String = ""
    @State private var showDeleteConfirmation: Bool = false
    @State private var deletionError: String?
    @State private var isDeleting: Bool = false

    let ageRanges = ["13–17", "18–24", "25–34", "35–44", "45–54", "55+"]
    let denominations = ["Orthodox", "Catholic", "Baptist", "Methodist", "Pentecostal", "Other"]
    let bibleGoals = ["To study and learn the Bible", "To find guidance for life's challenges"]
    let readingFrequencies = ["Almost every day", "A few times a week", "Rarely", "I'm new to the Bible"]
    let spiritualGoals = ["Deepen my daily faith", "Overcome challenges", "Share my faith with others", "Build lasting habits"]
    let guidancePreferences = ["Daily verses & tasks", "In-depth Bible study", "Encouragement from community", "Guided prayers"]
    let biggestChallenges = ["Staying consistent", "Feeling disconnected", "Life's challenges", "Understanding the Bible"]

    private let privacyPolicyURL = URL(string: "https://www.faithformoms.com/r/privacy")!
    private let websiteURL = URL(string: "https://www.faithformoms.com/")!
    private let termsOfUseURL = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!
    private let supportEmailURL = URL(string: "mailto:faithformoms@gmail.com?subject=Daily%20Bible%20App%20Support")!

    private let userDefaults = UserDefaults.standard
    private let nameKey = "UserName"
    private let ageRangeKey = "UserAgeGroup"
    private let emailKey = "UserEmail"
    private let denominationKey = "UserFaithBackground"
    private let churchKey = "UserChurch"
    private let bibleGoalKey = "UserBibleGoal"
    private let readingFrequencyKey = "UserReadingFrequency"
    private let spiritualGoalKey = "UserSpiritualGoal"
    private let guidancePreferenceKey = "UserGuidancePreference"
    private let biggestChallengeKey = "UserBiggestChallenge"

    init() {
        _name = State(initialValue: UserDefaults.standard.string(forKey: "UserName") ?? "")
        _ageRange = State(initialValue: UserDefaults.standard.string(forKey: "UserAgeGroup") ?? "")
        _email = State(initialValue: UserDefaults.standard.string(forKey: "UserEmail") ?? (Auth.auth().currentUser?.email ?? ""))
        _denomination = State(initialValue: UserDefaults.standard.string(forKey: "UserFaithBackground") ?? "")
        _church = State(initialValue: UserDefaults.standard.string(forKey: "UserChurch") ?? "")
        _bibleGoal = State(initialValue: UserDefaults.standard.string(forKey: "UserBibleGoal") ?? "")
        _readingFrequency = State(initialValue: UserDefaults.standard.string(forKey: "UserReadingFrequency") ?? "")
        _spiritualGoal = State(initialValue: UserDefaults.standard.string(forKey: "UserSpiritualGoal") ?? "")
        _guidancePreference = State(initialValue: UserDefaults.standard.string(forKey: "UserGuidancePreference") ?? "")
        _biggestChallenge = State(initialValue: UserDefaults.standard.string(forKey: "UserBiggestChallenge") ?? "")
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#fde8e8"), Color(hex: "#fdf0f0"), Color(hex: "#ebe8f5")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {

                    // ── Page title ───────────────────────────
                    VStack(spacing: 4) {
                        Text("Settings")
                            .font(.custom("Georgia", size: 30))
                            .italic()
                            .foregroundColor(.textDark)
                        Text("Manage your account & preferences")
                            .font(.system(size: 13))
                            .foregroundColor(.textSoft)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)

                    // ── Account section ──────────────────────
                    if authState.isAuthenticated {
                        settingsCard {
                            sectionHeader("Account Info", icon: "person.circle")

                            styledTextField("Name", text: $name, key: nameKey)
                            divider()
                            styledPickerRow("Age Range", selection: $ageRange, options: ageRanges, key: ageRangeKey)
                            divider()
                            styledTextField("Email", text: $email, key: emailKey)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                            divider()
                            styledPickerRow("Denomination", selection: $denomination, options: denominations, key: denominationKey)
                            divider()
                            styledTextField("Church", text: $church, key: churchKey)
                        }

                        settingsCard {
                            sectionHeader("Bible & Faith", icon: "book")

                            styledPickerRow("Bible Goal", selection: $bibleGoal, options: bibleGoals, key: bibleGoalKey)
                            divider()
                            styledPickerRow("Reading Frequency", selection: $readingFrequency, options: readingFrequencies, key: readingFrequencyKey)
                            divider()
                            styledPickerRow("Spiritual Goal", selection: $spiritualGoal, options: spiritualGoals, key: spiritualGoalKey)
                            divider()
                            styledPickerRow("Guidance Preference", selection: $guidancePreference, options: guidancePreferences, key: guidancePreferenceKey)
                            divider()
                            styledPickerRow("Biggest Challenge", selection: $biggestChallenge, options: biggestChallenges, key: biggestChallengeKey)
                        }

                        settingsCard {
                            sectionHeader("Account Actions", icon: "gearshape")

                            Button(action: {
                                try? Auth.auth().signOut()
                                authState.updateAuthenticationState(isAuthenticated: false, isGuest: false)
                                resetUserDefaults()
                                UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
                                UserDefaults.standard.set(false, forKey: "hasCompletedOnboardingQuestions")
                            }) {
                                actionRow(label: "Sign Out", icon: "arrow.right.circle", color: .roseGold)
                            }
                            .buttonStyle(PlainButtonStyle())

                            divider()

                            Button(action: { showDeleteConfirmation = true }) {
                                actionRow(label: "Delete Account", icon: "trash", color: Color.red.opacity(0.7))
                            }
                            .buttonStyle(PlainButtonStyle())
                            .disabled(isDeleting)
                        }

                        if let error = deletionError {
                            Text(error)
                                .font(.system(size: 13))
                                .foregroundColor(.red)
                                .padding(.horizontal, 20)
                        }

                    } else if authState.isGuest {
                        settingsCard {
                            sectionHeader("Account", icon: "person.circle")

                            Text("You're browsing as a guest. Sign in to save your profile and unlock more features.")
                                .font(.system(size: 14))
                                .foregroundColor(.textSoft)
                                .lineSpacing(5)
                                .padding(.top, 4)

                            Button(action: {
                                authState.updateAuthenticationState(isAuthenticated: false, isGuest: false)
                                resetUserDefaults()
                                UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
                                UserDefaults.standard.set(false, forKey: "hasCompletedOnboardingQuestions")
                            }) {
                                Text("Sign In / Sign Up")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(Color.roseGold)
                                    .cornerRadius(14)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.top, 8)
                        }
                    }

                    // ── About section ────────────────────────
                    settingsCard {
                        sectionHeader("About", icon: "info.circle")

                        linkRow(label: "Contact Us", url: supportEmailURL)
                        divider()
                        linkRow(label: "Terms of Use", url: termsOfUseURL)
                        divider()
                        linkRow(label: "Privacy Policy", url: privacyPolicyURL)
                        divider()
                        linkRow(label: "Website", url: websiteURL)
                    }

                    Text("Dear Mom · Bible for Moms")
                        .font(.system(size: 11))
                        .foregroundColor(.textSoft)
                        .padding(.bottom, 40)
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .alert("Delete Account", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { showDeleteConfirmation = false }
            Button("Delete", role: .destructive) {
                isDeleting = true
                viewModel.deleteAccount(authState: authState) { result in
                    isDeleting = false
                    switch result {
                    case .success:
                        resetUserDefaults()
                        UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
                        UserDefaults.standard.set(false, forKey: "hasCompletedOnboardingQuestions")
                        deletionError = nil
                    case .failure(let error):
                        deletionError = error.localizedDescription
                    }
                    showDeleteConfirmation = false
                }
            }
        } message: {
            Text("Are you sure you want to delete your account? This action cannot be undone.")
        }
    }

    // MARK: - Reusable Components

    @ViewBuilder
    private func settingsCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            content()
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color(hex: "#f0c8c8").opacity(0.2), radius: 10, x: 0, y: 4)
    }

    @ViewBuilder
    private func sectionHeader(_ title: String, icon: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.roseGold)
            Text(title.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .tracking(2)
                .foregroundColor(.textSoft)
        }
        .padding(.bottom, 14)
    }

    @ViewBuilder
    private func styledTextField(_ label: String, text: Binding<String>, key: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.textSoft)
                .frame(width: 110, alignment: .leading)
            TextField(label, text: text)
                .font(.system(size: 14))
                .foregroundColor(.textDark)
                .multilineTextAlignment(.trailing)
                .onChange(of: text.wrappedValue) { _, newValue in
                    userDefaults.set(newValue, forKey: key)
                }
        }
        .padding(.vertical, 10)
    }

    @ViewBuilder
    private func styledPickerRow(_ label: String, selection: Binding<String>, options: [String], key: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.textSoft)
                .frame(width: 110, alignment: .leading)
            Spacer()
            Picker("", selection: selection) {
                // Placeholder option — matches the default "" value so no warning
                Text("Select…").tag("").foregroundStyle(Color.textSoft)
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(.menu)
            .tint(.roseGold)
            .onChange(of: selection.wrappedValue) { _, newValue in
                userDefaults.set(newValue, forKey: key)
            }
        }
        .padding(.vertical, 6)
    }

    @ViewBuilder
    private func actionRow(label: String, icon: String, color: Color) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 15))
                .foregroundColor(color)
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(color)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 12))
                .foregroundColor(.textSoft)
        }
        .padding(.vertical, 10)
    }

    @ViewBuilder
    private func linkRow(label: String, url: URL) -> some View {
        Link(destination: url) {
            HStack {
                Text(label)
                    .font(.system(size: 15))
                    .foregroundColor(.textDark)
                Spacer()
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 12))
                    .foregroundColor(.textSoft)
            }
            .padding(.vertical, 10)
        }
    }

    @ViewBuilder
    private func divider() -> some View {
        Rectangle()
            .fill(Color(hex: "#f0e8e8"))
            .frame(height: 1)
    }

    // MARK: - Helpers

    private func resetUserDefaults() {
        let keys = [nameKey, ageRangeKey, emailKey, denominationKey, churchKey,
                    bibleGoalKey, readingFrequencyKey, spiritualGoalKey,
                    guidancePreferenceKey, biggestChallengeKey,
                    "ChecklistTasks", "CompletedDays", "CompletedTaskCount", "CurrentWeek",
                    "UserMotherhoodStage", "UserCurrentSeason", "UserQuietTime",
                    "UserCurrentNeed", "UserFaithJourney", "UserReason"]
        keys.forEach { userDefaults.removeObject(forKey: $0) }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(AuthenticationState())
    }
}
