import SwiftUI

struct OnboardingQuestionsView: View {
    @EnvironmentObject var authState: AuthenticationState

    @State private var denomination = ""
    @State private var ageGroup = ""
    @State private var goal = ""

    var body: some View {
        VStack(spacing: 30) {
            Text("Help us tailor your experience")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 50)

            VStack(spacing: 20) {
                Picker("Your Denomination", selection: $denomination) {
                    Text("Orthodox").tag("Orthodox")
                    Text("Catholic").tag("Catholic")
                    Text("Baptist").tag("Baptist")
                    Text("Methodist").tag("Methodist")
                    Text("Pentecostal").tag("Pentecostal")
                }
                .pickerStyle(.menu)
                .foregroundColor(.white)

                Picker("Your Age Group", selection: $ageGroup) {
                    Text("13-17").tag("13-17")
                    Text("18-24").tag("18-24")
                    Text("25-34").tag("25-34")
                    Text("35-44").tag("35-44")
                    Text("45-54").tag("45-54")
                    Text("55+").tag("55+")
                }
                .pickerStyle(.menu)
                .foregroundColor(.white)

                Picker("Your Goal", selection: $goal) {
                    Text("Just study the Bible").tag("study")
                    Text("Overcome life challenges").tag("challenges")
                }
                .pickerStyle(.menu)
                .foregroundColor(.white)
            }
            .padding(.horizontal)

            Spacer()

            Button(action: {
                // Save answers if needed
                authState.updateAuthenticationState(isAuthenticated: authState.isAuthenticated, isGuest: authState.isGuest)
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 300)
                    .background(Color.purple)
                    .cornerRadius(8)
            }
            .padding(.bottom, 60)
        }
        .background(Color.black.ignoresSafeArea())
    }
}
