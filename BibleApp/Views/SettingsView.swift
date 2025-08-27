import SwiftUI

struct SettingsView: View {
    @State private var name: String = "User Name"
    @State private var ageRange: String = "18-24"
    @State private var email: String = "user@example.com"
    @State private var denomination: String = ""
    @State private var church: String = ""
    
    let ageRanges = ["13-17", "18-24", "25-34", "35-44", "45-54", "55+"]
    
    // Define URLs for the links
    private let privacyPolicyURL = URL(string: "https://www.thedailybible.app/r/privacy")!
    private let websiteURL = URL(string: "https://www.thedailybible.app/")!
    private let termsOfUseURL = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!
    
    var body: some View {
        NavigationView {
            Form {
                // Account Info Section
                Section(header: Text("Account Info")) {
                    TextField("Name", text: $name)
                    Picker("Age Range", selection: $ageRange) {
                        ForEach(ageRanges, id: \.self) { range in
                            Text(range).tag(range)
                        }
                    }
                    .pickerStyle(.menu) // Updated to .menu for iOS consistency
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true) // Added for better email input
                    TextField("Denomination", text: $denomination)
                    TextField("Church", text: $church)
                }
                
                // Subscription Section
                Section(header: Text("Subscription")) {
                    Text("Membership: Free Tier") // Placeholder, replace with dynamic data if needed
                    Button(action: {
                        // Implement upgrade to premium logic
                        print("Upgrade to Premium tapped")
                    }) {
                        Text("Upgrade to Premium")
                            .foregroundStyle(.blue)
                    }
                    Button(action: {
                        // Implement restore purchases logic
                        print("Restore Purchases tapped")
                    }) {
                        Text("Restore Purchases")
                            .foregroundStyle(.blue)
                    }
                }
                
                // About Section
                Section(header: Text("About")) {
                    Button(action: {
                        // Implement contact us logic (e.g., open mailto link or form)
                        print("Contact Us tapped")
                    }) {
                        Text("Contact Us")
                            .foregroundStyle(.blue)
                    }
                    Link("Terms of Use", destination: termsOfUseURL)
                        .foregroundStyle(.blue)
                    Link("Privacy Policy", destination: privacyPolicyURL)
                        .foregroundStyle(.blue)
                    Link("Website", destination: websiteURL)
                        .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview("iPhone 14") {
    SettingsView()
}

#Preview("iPad Pro") {
    SettingsView()
}
