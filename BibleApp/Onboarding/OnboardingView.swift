import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var currentPage = 0
    @State private var showMissionScreen = true
    @State private var navigateToAuth = false

    var body: some View {
        NavigationStack {
            Group {
                if authState.isAuthenticated || authState.isGuest {
                    TabBarView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                } else if showMissionScreen {
                    MissionScreen(
                        onContinueAsGuest: {
                            showMissionScreen = false
                            authState.updateAuthenticationState(isAuthenticated: false, isGuest: true)
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
                    .navigationBarBackButtonHidden(true)
                } else {
                    ZStack {
                        // Background image
                        Image("back1")
                            .resizable()
                            .scaledToFill()
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
                                            authState.updateAuthenticationState(isAuthenticated: false, isGuest: true)
                                        }
                                    )
                                }
                            }
                            
                            // Page indicator dots
                            HStack(spacing: 8) {
                                ForEach(0..<4, id: \.self) { index in
                                    Circle()
                                        .frame(width: 8, height: 8)
                                        .foregroundColor(index == currentPage ? .white : .gray.opacity(0.3))
                                }
                            }
                            .padding(.bottom, 20)
                        }
                        .gesture(DragGesture().onEnded { _ in })
                    }
                }
            }
        }
    }
}

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
                .foregroundColor(.white)
            
            Text(title)
                .font(.system(size: 28, weight: .bold, design: .serif))
                .foregroundColor(.white)
            
            Text(subtitle)
                .font(.system(size: 18, weight: .regular, design: .serif))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Spacer()
            
            Button(action: {
                onButtonTap()
            }) {
                Text(buttonText)
                    .font(.system(.headline, weight: .semibold))
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: 300)
                    .background(Color.white)
                    .cornerRadius(8)
            }
            .padding(.bottom, 60)
        }
        .padding()
        .tag(tag)
    }
}

struct MissionScreen: View {
    var onContinueAsGuest: () -> Void
    var onSignIn: () -> Void

    var body: some View {
        ZStack {
            // Background image
            Image("back1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 12) {
                // App Logo
                Image("dailybiblelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180, alignment: .leading)
                    .cornerRadius(40)
                    .padding(.top, 40)
                    .padding(.leading, 20)
                
                // Tagline
                Text("Built on Scripture, Made for You.")
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 20)
                
                // Description
                Text("Created with guidance from pastors, teachers, and believers who live by the Word.")
                    .font(.system(size: 18, weight: .regular, design: .serif))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                
                Text("Join a growing community of Christians deepening their faith daily.")
                    .font(.system(size: 27, weight: .semibold, design: .serif))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.yellow, lineWidth: 0.5)
                    )
                    .frame(maxWidth: .infinity)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 40)
                
                Button(action: onContinueAsGuest) {
                    Text("Continue without an account")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
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
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                
                Text("We respect your privacy and handle your sensitive information according to GDPR standards. By signing up, you agree to our Privacy Policy and Terms of Use.")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
            }
            .padding(.top, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

#Preview("iPhone 14 - Onboarding") {
    OnboardingView()
        .environmentObject(AuthenticationState())
}

#Preview("iPad Pro - Onboarding") {
    OnboardingView()
        .environmentObject(AuthenticationState())
}
