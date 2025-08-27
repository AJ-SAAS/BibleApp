import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var name: String = "User Name"
    @State private var ageRange: String = "18-24"
    @State private var email: String = "user@example.com"
    @State private var denomination: String = ""
    @State private var church: String = ""
    
    let ageRanges = ["13-17", "18-24", "25-34", "35-44", "45-54", "55+"]
    
    private let privacyPolicyURL = URL(string: "https://www.thedailybible.app/r/privacy")!
    private let websiteURL = URL(string: "https://www.thedailybible.app/")!
    private let termsOfUseURL = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!
    
    // Support email with subject line
    private let supportEmailURL = URL(string: "mailto:thedailybibleappsupport@gmail.com?subject=Daily%20Bible%20App%20Support")!
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Account Info")) {
                    TextField("Name", text: $name)
                    Picker("Age Range", selection: $ageRange) {
                        ForEach(ageRanges, id: \.self) { range in
                            Text(range).tag(range)
                        }
                    }
                    .pickerStyle(.menu)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    TextField("Denomination", text: $denomination)
                    TextField("Church", text: $church)
                    Button(action: {
                        do {
                            try Auth.auth().signOut()
                            authState.updateAuthenticationState(isAuthenticated: false)
                            print("SettingsView: Signed out successfully")
                        } catch {
                            print("SettingsView: Sign-out error: \(error.localizedDescription)")
                        }
                    }) {
                        Text("Sign Out")
                            .foregroundStyle(.blue)
                    }
                    .accessibilityLabel("Sign Out")
                }
                
                Section(header: Text("About")) {
                    Link("Contact Us", destination: supportEmailURL)
                        .foregroundStyle(.blue)
                    Link("Terms of Use", destination: termsOfUseURL)
                        .foregroundStyle(.blue)
                    Link("Privacy Policy", destination: privacyPolicyURL)
                        .foregroundStyle(.blue)
                    Link("Website", destination: websiteURL)
                        .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Settings")
            .background(Color.white)
        }
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
