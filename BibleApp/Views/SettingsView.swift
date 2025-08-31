import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var authState: AuthenticationState
    @StateObject private var viewModel = AuthViewModel() // Added for account deletion
    @State private var name: String = ""
    @State private var ageRange: String = "18-24"
    @State private var email: String = ""
    @State private var denomination: String = ""
    @State private var church: String = ""
    @State private var showDeleteConfirmation: Bool = false // Added for confirmation alert
    @State private var deletionError: String? // Added for error handling
    @State private var isDeleting: Bool = false // Added for loading state
    
    let ageRanges = ["13-17", "18-24", "25-34", "35-44", "45-54", "55+"]
    
    private let privacyPolicyURL = URL(string: "https://www.thedailybible.app/r/privacy")!
    private let websiteURL = URL(string: "https://www.thedailybible.app/")!
    private let termsOfUseURL = URL(string: "https://www.thedailybible.app/r/terms")!
    private let supportEmailURL = URL(string: "mailto:thedailybibleappsupport@gmail.com?subject=Daily%20Bible%20App%20Support")!
    
    private let userDefaults = UserDefaults.standard
    private let nameKey = "UserName"
    private let ageRangeKey = "UserAgeRange"
    private let emailKey = "UserEmail"
    private let denominationKey = "UserDenomination"
    private let churchKey = "UserChurch"
    
    init() {
        // Load saved values from UserDefaults
        _name = State(initialValue: UserDefaults.standard.string(forKey: nameKey) ?? "")
        _ageRange = State(initialValue: UserDefaults.standard.string(forKey: ageRangeKey) ?? "18-24")
        _email = State(initialValue: UserDefaults.standard.string(forKey: emailKey) ?? (Auth.auth().currentUser?.email ?? ""))
        _denomination = State(initialValue: UserDefaults.standard.string(forKey: denominationKey) ?? "")
        _church = State(initialValue: UserDefaults.standard.string(forKey: churchKey) ?? "")
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
                            TextField("Denomination", text: $denomination)
                                .onChange(of: denomination) { _, newValue in
                                    userDefaults.set(newValue, forKey: denominationKey)
                                }
                                .accessibilityLabel("Denomination")
                            TextField("Church", text: $church)
                                .onChange(of: church) { _, newValue in
                                    userDefaults.set(newValue, forKey: churchKey)
                                }
                                .accessibilityLabel("Church")
                            Button(action: {
                                do {
                                    try Auth.auth().signOut()
                                    authState.updateAuthenticationState(isAuthenticated: false, isGuest: false)
                                    resetUserDefaults()
                                    print("SettingsView: Signed out successfully")
                                } catch {
                                    print("SettingsView: Sign-out error: \(error.localizedDescription)")
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
                                print("SettingsView: Guest signed out, returning to AuthView")
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
                                print("SettingsView: Account deleted successfully")
                                deletionError = nil
                            case .failure(let error):
                                deletionError = error.localizedDescription
                                print("SettingsView: Account deletion error: \(error.localizedDescription)")
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
        // Clear DevotionViewModel-related data
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
