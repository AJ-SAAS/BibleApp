import SwiftUI

struct SettingsView: View {
    @State private var name: String = "User Name"
    @State private var ageRange: String = "18-24"
    @State private var email: String = "user@example.com"
    @State private var denomination: String = ""
    @State private var church: String = ""
    
    let ageRanges = ["13-17", "18-24", "25-34", "35-44", "45-54", "55+"]
    
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
                    .pickerStyle(MenuPickerStyle()) // Scrollable within the form
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
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
                            .foregroundColor(.blue)
                    }
                    Button(action: {
                        // Implement restore purchases logic
                        print("Restore Purchases tapped")
                    }) {
                        Text("Restore Purchases")
                            .foregroundColor(.blue)
                    }
                }
                
                // About Section
                Section(header: Text("About")) {
                    Button(action: {
                        // Implement contact us logic
                        print("Contact Us tapped")
                    }) {
                        Text("Contact Us")
                            .foregroundColor(.blue)
                    }
                    Button(action: {
                        // Implement terms of use logic (e.g., open URL)
                        print("Terms of Use tapped")
                    }) {
                        Text("Terms of Use")
                            .foregroundColor(.blue)
                    }
                    Button(action: {
                        // Implement privacy policy logic (e.g., open URL)
                        print("Privacy Policy tapped")
                    }) {
                        Text("Privacy Policy")
                            .foregroundColor(.blue)
                    }
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
