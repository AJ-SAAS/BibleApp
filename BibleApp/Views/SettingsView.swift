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
    
    // Answer choices for pickers
    let ageRanges = ["13–17", "18–24", "25–34", "35–44", "45–54", "55+"]
    let denominations = ["Orthodox", "Catholic", "Baptist", "Methodist", "Pentecostal", "Other"]
    let bibleGoals = ["To study and learn the Bible", "To find guidance for life’s challenges"]
    let readingFrequencies = ["Almost every day", "A few times a week", "Rarely", "I’m new to the Bible"]
    let spiritualGoals = ["Deepen my daily faith", "Overcome challenges", "Share my faith with others", "Build lasting habits"]
    let guidancePreferences = ["Daily verses & tasks", "In-depth Bible study", "Encouragement from community", "Guided prayers"]
    let biggestChallenges = ["Staying consistent", "Feeling disconnected", "Life’s challenges", "Understanding the Bible"]
    
    private let privacyPolicyURL = URL(string: "https://www.thedailybible.app/r/privacy")!
    private let websiteURL = URL(string: "https://www.thedailybible.app/")!
    private let termsOfUseURL = URL(string: "https://www.thedailybible.app/r/terms")!
    private let supportEmailURL = URL(string: "mailto:thedailybibleappsupport@gmail.com?subject=Daily%20Bible%20App%20Support")!
    
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
        _name = State(initialValue: UserDefaults.standard.string(forKey: nameKey) ?? "")
        _ageRange = State(initialValue: UserDefaults.standard.string(forKey: ageRangeKey) ?? "")
        _email = State(initialValue: UserDefaults.standard.string(forKey: emailKey) ?? (Auth.auth().currentUser?.email ?? ""))
        _denomination = State(initialValue: UserDefaults.standard.string(forKey: denominationKey) ?? "")
        _church = State(initialValue: UserDefaults.standard.string(forKey: churchKey) ?? "")
        _bibleGoal = State(initialValue: UserDefaults.standard.string(forKey: bibleGoalKey) ?? "")
        _readingFrequency = State(initialValue: UserDefaults.standard.string(forKey: readingFrequencyKey) ?? "")
        _spiritualGoal = State(initialValue: UserDefaults.standard.string(forKey: spiritualGoalKey) ?? "")
        _guidancePreference = State(initialValue: UserDefaults.standard.string(forKey: guidancePreferenceKey) ?? "")
        _biggestChallenge = State(initialValue: UserDefaults.standard.string(forKey: biggestChallengeKey) ?? "")
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                Form {
                    if authState.isAuthenticated {
                        Section(header: Text("Account Info")) {
                            TextField("Name", text: $name)
                                .onChange(of: name) { _, newValue in
                                    userDefaults.set(newValue, forKey: nameKey)
                                }
                                .accessibilityLabel("Name")
                            Picker("Age Range", selection: $ageRange) {
                                ForEach(ageRanges, id: \.self) { range in
                                    Text(range).tag(range)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: ageRange) { _, newValue in
                                userDefaults.set(newValue, forKey: ageRangeKey)
                            }
                            .accessibilityLabel("Age Range")
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .onChange(of: email) { _, newValue in
                                    userDefaults.set(newValue, forKey: emailKey)
                                }
                                .accessibilityLabel("Email")
                            Picker("Denomination", selection: $denomination) {
                                ForEach(denominations, id: \.self) { denom in
                                    Text(denom).tag(denom)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: denomination) { _, newValue in
                                userDefaults.set(newValue, forKey: denominationKey)
                            }
                            .accessibilityLabel("Denomination")
                            TextField("Church", text: $church)
                                .onChange(of: church) { _, newValue in
                                    userDefaults.set(newValue, forKey: churchKey)
                                }
                                .accessibilityLabel("Church")
                            Picker("Bible Goal", selection: $bibleGoal) {
                                ForEach(bibleGoals, id: \.self) { goal in
                                    Text(goal).tag(goal)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: bibleGoal) { _, newValue in
                                userDefaults.set(newValue, forKey: bibleGoalKey)
                            }
                            .accessibilityLabel("Bible Goal")
                            Picker("Reading Frequency", selection: $readingFrequency) {
                                ForEach(readingFrequencies, id: \.self) { frequency in
                                    Text(frequency).tag(frequency)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: readingFrequency) { _, newValue in
                                userDefaults.set(newValue, forKey: readingFrequencyKey)
                            }
                            .accessibilityLabel("Reading Frequency")
                            Picker("Spiritual Goal", selection: $spiritualGoal) {
                                ForEach(spiritualGoals, id: \.self) { goal in
                                    Text(goal).tag(goal)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: spiritualGoal) { _, newValue in
                                userDefaults.set(newValue, forKey: spiritualGoalKey)
                            }
                            .accessibilityLabel("Spiritual Goal")
                            Picker("Guidance Preference", selection: $guidancePreference) {
                                ForEach(guidancePreferences, id: \.self) { preference in
                                    Text(preference).tag(preference)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: guidancePreference) { _, newValue in
                                userDefaults.set(newValue, forKey: guidancePreferenceKey)
                            }
                            .accessibilityLabel("Guidance Preference")
                            Picker("Biggest Challenge", selection: $biggestChallenge) {
                                ForEach(biggestChallenges, id: \.self) { challenge in
                                    Text(challenge).tag(challenge)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: biggestChallenge) { _, newValue in
                                userDefaults.set(newValue, forKey: biggestChallengeKey)
                            }
                            .accessibilityLabel("Biggest Challenge")
                            Button(action: {
                                do {
                                    try Auth.auth().signOut()
                                    authState.updateAuthenticationState(isAuthenticated: false, isGuest: false)
                                    resetUserDefaults()
                                    UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
                                    UserDefaults.standard.set(false, forKey: "hasCompletedOnboardingQuestions")
                                } catch {
                                    deletionError = error.localizedDescription
                                }
                            }) {
                                Text("Sign Out")
                                    .foregroundStyle(.blue)
                            }
                            .accessibilityLabel("Sign Out")
                            Button(action: {
                                showDeleteConfirmation = true
                            }) {
                                Text("Delete Account")
                                    .foregroundStyle(.red)
                            }
                            .disabled(isDeleting)
                            .accessibilityLabel("Delete Account")
                        }
                        if let error = deletionError {
                            Section {
                                Text(error)
                                    .foregroundStyle(.red)
                                    .accessibilityLabel("Error: \(error)")
                            }
                        }
                    } else if authState.isGuest {
                        Section(header: Text("Account Info")) {
                            Text("You are using the app as a guest. Sign in or sign up to save your profile across devices (optional).")
                                .font(.system(.body, design: .default, weight: .regular))
                                .foregroundColor(.gray)
                                .accessibilityLabel("Guest mode message")
                            Button(action: {
                                authState.updateAuthenticationState(isAuthenticated: false, isGuest: false)
                                resetUserDefaults()
                                UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
                                UserDefaults.standard.set(false, forKey: "hasCompletedOnboardingQuestions")
                            }) {
                                Text("Sign In / Sign Up")
                                    .foregroundStyle(.blue)
                            }
                            .accessibilityLabel("Sign In or Sign Up")
                        }
                    }
                    
                    Section(header: Text("About")) {
                        Link("Contact Us", destination: supportEmailURL)
                            .foregroundStyle(.blue)
                            .accessibilityLabel("Contact Us")
                        Link("Terms of Use", destination: termsOfUseURL)
                            .foregroundStyle(.blue)
                            .accessibilityLabel("Terms of Use")
                        Link("Privacy Policy", destination: privacyPolicyURL)
                            .foregroundStyle(.blue)
                            .accessibilityLabel("Privacy Policy")
                        Link("Website", destination: websiteURL)
                            .foregroundStyle(.blue)
                            .accessibilityLabel("Website")
                    }
                }
                .navigationTitle("Settings")
                .navigationBarBackButtonHidden(true)
                .background(Color.white)
                .scrollContentBackground(.hidden)
                .alert("Delete Account", isPresented: $showDeleteConfirmation) {
                    Button("Cancel", role: .cancel) {
                        showDeleteConfirmation = false
                    }
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
        }
    }
    
    private func resetUserDefaults() {
        userDefaults.removeObject(forKey: nameKey)
        userDefaults.removeObject(forKey: ageRangeKey)
        userDefaults.removeObject(forKey: emailKey)
        userDefaults.removeObject(forKey: denominationKey)
        userDefaults.removeObject(forKey: churchKey)
        userDefaults.removeObject(forKey: bibleGoalKey)
        userDefaults.removeObject(forKey: readingFrequencyKey)
        userDefaults.removeObject(forKey: spiritualGoalKey)
        userDefaults.removeObject(forKey: guidancePreferenceKey)
        userDefaults.removeObject(forKey: biggestChallengeKey)
        userDefaults.removeObject(forKey: "ChecklistTasks")
        userDefaults.removeObject(forKey: "CompletedDays")
        userDefaults.removeObject(forKey: "CompletedTaskCount")
        userDefaults.removeObject(forKey: "CurrentWeek")
    }
}

#Preview("iPhone 14") {
    SettingsView()
        .environmentObject(AuthenticationState())
}

#Preview("iPad Pro") {
    SettingsView()
        .environmentObject(AuthenticationState())
}
