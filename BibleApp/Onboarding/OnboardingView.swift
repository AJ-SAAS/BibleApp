import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var currentPage = 0
    @State private var shouldNavigateToAuth = false // New state for navigation
    
    var body: some View {
        Group {
            if shouldNavigateToAuth {
                AuthView()
                    .environmentObject(authState)
            } else {
                VStack {
                    // Conditional view to disable swiping
                    Group {
                        if currentPage == 0 {
                            OnboardingPage(
                                title: "Welcome to Bible App!",
                                subtitle: "Grow closer to God with daily Bible verses and tasks.",
                                imageName: "book.fill",
                                tag: 0,
                                buttonText: "Next",
                                onButtonTap: { currentPage += 1 }
                            )
                        } else if currentPage == 1 {
                            OnboardingPage(
                                title: "Daily Inspiration",
                                subtitle: "Receive a new verse and task each day to inspire your faith.",
                                imageName: "calendar",
                                tag: 1,
                                buttonText: "Next",
                                onButtonTap: { currentPage += 1 }
                            )
                        } else if currentPage == 2 {
                            OnboardingPage(
                                title: "Track Your Journey",
                                subtitle: "Complete tasks and track your spiritual growth with our checklist.",
                                imageName: "checkmark.circle.fill",
                                tag: 2,
                                buttonText: "Next",
                                onButtonTap: { currentPage += 1 }
                            )
                        } else if currentPage == 3 {
                            OnboardingPage(
                                title: "Begin Your Journey",
                                subtitle: "Start your daily devotion today and grow closer to God!",
                                imageName: "book.open.fill",
                                tag: 3,
                                buttonText: "Get Started",
                                onButtonTap: {
                                    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                                    shouldNavigateToAuth = true // Trigger navigation
                                }
                            )
                        }
                    }
                    
                    // Page indicator dots
                    HStack(spacing: 8) {
                        ForEach(0..<4, id: \.self) { index in
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(index == currentPage ? .black : .gray.opacity(0.3))
                                .accessibilityLabel(index == currentPage ? "Current page \(index + 1)" : "Page \(index + 1)")
                        }
                    }
                    .padding(.bottom, 20)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Page \(currentPage + 1) of 4")
                }
                .background(Color.white)
                .gesture(DragGesture().onEnded { _ in /* Disable swipe */ })
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
                .foregroundColor(.black)
                .accessibilityLabel("Icon for \(title)")
            
            Text(title)
                .font(.system(size: 28, weight: .bold, design: .serif))
                .foregroundColor(.black)
            
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
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 300)
                    .background(Color.black)
                    .cornerRadius(8)
            }
            .accessibilityLabel(buttonText)
            .padding(.bottom, 60)
        }
        .padding()
        .tag(tag)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title). \(subtitle)")
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AuthenticationState())
}
