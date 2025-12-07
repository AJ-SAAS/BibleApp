import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var currentPage = 0
    @State private var showMissionScreen = true
    @State private var navigateToAuth = false
    @State private var navigateToQuestions = false

    var body: some View {
        NavigationStack {
            Group {
                if showMissionScreen {
                    MissionScreen(
                        onContinueAsGuest: {
                            UserDefaults.standard.set(false, forKey: "hasCompletedOnboardingQuestions")
                            let keys = ["denomination", "frequency", "experience", "preference", "goal", "time", "notification"]
                            keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
                            authState.updateAuthenticationState(isAuthenticated: false, isGuest: true)
                            navigateToQuestions = true
                        },
                        onSignIn: {
                            navigateToAuth = true
                        }
                    )
                    .navigationDestination(isPresented: $navigateToAuth) {
                        AuthView()
                            .environmentObject(authState)
                            .navigationBarBackButtonHidden(true)
                    }
                    .navigationDestination(isPresented: $navigateToQuestions) {
                        OnboardingQuestionsView()
                            .environmentObject(authState)
                            .navigationBarBackButtonHidden(true)
                    }
                    .navigationBarBackButtonHidden(true)
                } else {
                    ZStack {
                        Color(red: 1.0, green: 0.992, blue: 0.961)
                            .ignoresSafeArea()
                        
                        VStack {
                            Group {
                                if currentPage == 0 {
                                    OnboardingPage(
                                        title: "Welcome to Closer to Christ",
                                        subtitle: "Your daily guide to Scripture, prayer, and purposeful living.",
                                        imageName: "book.fill",
                                        tag: 0,
                                        buttonText: "Next",
                                        onButtonTap: { currentPage += 1 }
                                    )
                                } else if currentPage == 1 {
                                    OnboardingPage(
                                        title: "Fresh Scripture Every Day",
                                        subtitle: "Wake up to a new verse and a simple task designed to deepen your faith and keep God’s Word alive in your heart.",
                                        imageName: "calendar",
                                        tag: 1,
                                        buttonText: "Next",
                                        onButtonTap: { currentPage += 1 }
                                    )
                                } else if currentPage == 2 {
                                    OnboardingPage(
                                        title: "Build Lasting Habits of Faith",
                                        subtitle: "Check off daily tasks, reflect on verses, and watch your spiritual life grow one step at a time.",
                                        imageName: "checkmark.circle.fill",
                                        tag: 2,
                                        buttonText: "Next",
                                        onButtonTap: { currentPage += 1 }
                                    )
                                } else if currentPage == 3 {
                                    OnboardingPage(
                                        title: "Your Walk with Christ Starts Here",
                                        subtitle: "Begin your daily devotion today and see how one small step draws you closer to Him.",
                                        imageName: "book.open.fill",
                                        tag: 3,
                                        buttonText: "Get Started",
                                        onButtonTap: {
                                            UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                                            UserDefaults.standard.set(false, forKey: "hasCompletedOnboardingQuestions")
                                            let keys = ["denomination", "frequency", "experience", "preference", "goal", "time", "notification"]
                                            keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
                                            authState.updateAuthenticationState(isAuthenticated: false, isGuest: true)
                                            navigateToQuestions = true
                                        }
                                    )
                                }
                            }
                            
                            HStack(spacing: 8) {
                                ForEach(0..<4, id: \.self) { index in
                                    Circle()
                                        .frame(width: 8, height: 8)
                                        .foregroundColor(index == currentPage ? .black : .gray.opacity(0.3))
                                }
                            }
                            .padding(.bottom, 20)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - OnboardingPage
struct OnboardingPage: View {
    let title: String
    let subtitle: String
    let imageName: String
    let tag: Int
    let buttonText: String
    let onButtonTap: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .foregroundColor(.black)
            
            Text(title)
                .font(.system(size: 28, weight: .bold, design: .serif))
                .foregroundColor(.black)
            
            Text(subtitle)
                .font(.system(size: 18, weight: .regular, design: .serif))
                .foregroundColor(.black.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Spacer()
            
            Button(action: { onButtonTap() }) {
                Text(buttonText)
                    .font(.system(.headline, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 300)
                    .background(Color.black)
                    .cornerRadius(8)
            }
            .padding(.bottom, 60)
        }
        .padding()
        .tag(tag)
    }
}

// MARK: - MissionScreen
struct MissionScreen: View {
    var onContinueAsGuest: () -> Void
    var onSignIn: () -> Void

    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.992, blue: 0.961)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Image("dailybiblelogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .cornerRadius(40)
                        .padding(.top, 20) // reduced top padding
                        .padding(.leading, 20)
                    
                    Text("Built on Scripture, Made for You.")
                        .font(.system(size: 34, weight: .bold, design: .serif))
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                    
                    Text("Created with guidance from pastors, teachers, and believers who live by the Word.")
                        .font(.system(size: 18, weight: .regular, design: .serif))
                        .foregroundColor(.black.opacity(0.7))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    
                    // Highlighted community text with new background & white font
                    Text("Join a growing community of Christians deepening their faith daily.")
                        .font(.system(size: 23, weight: .regular, design: .serif)) // 2px smaller
                        .foregroundColor(.black) // white text
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity)
                        .background(
                            Color(hex: "#e6e2d5") // new background color
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        )
                        .padding(.horizontal, 32)
                        .padding(.bottom, 40)
                    
                    Button(action: onContinueAsGuest) {
                        Text("Continue without an account")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 4)
                    
                    Button(action: onSignIn) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .font(.title2)
                            Text("Sign up with Email")
                                .font(.system(size: 17, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    
                    Text("We respect your privacy and handle your sensitive information according to GDPR standards. By signing up, you agree to our Privacy Policy and Terms of Use.")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                }
                .padding(.top, 16)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
    }
}

// MARK: - Preview
#Preview("iPhone 14 - Onboarding") {
    OnboardingView()
        .environmentObject(AuthenticationState())
}

#Preview("iPad Pro - Onboarding") {
    OnboardingView()
        .environmentObject(AuthenticationState())
}
