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
