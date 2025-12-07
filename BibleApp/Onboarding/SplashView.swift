import SwiftUI
import FirebaseAuth

struct SplashView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var isActive = false
    @State private var currentTextIndex = 0
    @State private var offsetX: CGFloat = UIScreen.main.bounds.width
    @State private var opacity: Double = 0

    let texts = [
        "start your day with scripture",
        "live God’s word daily",
        "draw closer to Christ"
    ]

    var body: some View {
        Group {
            if isActive {
                if authState.isAuthenticated && !UserDefaults.standard.bool(forKey: "hasCompletedOnboardingQuestions") {
                    OnboardingQuestionsView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                } else if authState.isAuthenticated || authState.isGuest {
                    TabBarView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                } else {
                    OnboardingView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                }
            } else {
                splashScreen
                    .onAppear { animateText() }
            }
        }
    }

    // MARK: - Splash Screen Layout
    private var splashScreen: some View {
        GeometryReader { geo in
            ZStack {
                // Background image (light blue)
                Image("back1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                // Clean app icon with curved edges
                Image("dailybiblelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 165, height: 165)
                    .cornerRadius(32) // <- Rounded edges
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.32)
                    .accessibilityLabel("The Daily Bible App Logo")

                // Text container with border and rounded corners
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.25))
                        )
                        .frame(width: 320, height: 70)

                    Text(texts[currentTextIndex])
                        .font(.system(size: 22, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .offset(x: offsetX)
                .opacity(opacity)
                .position(x: geo.size.width / 2, y: geo.size.height * 0.58)
            }
        }
    }

    // MARK: - Text Animation Logic
    private func animateText() {
        guard currentTextIndex < texts.count else { return }

        offsetX = UIScreen.main.bounds.width
        opacity = 0

        withAnimation(.easeOut(duration: 0.5)) {
            offsetX = 0
            opacity = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            if self.currentTextIndex < self.texts.count - 1 {
                withAnimation(.easeIn(duration: 0.5)) {
                    offsetX = -UIScreen.main.bounds.width
                    opacity = 0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.currentTextIndex += 1
                    animateText()
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation(.easeOut(duration: 0.6)) {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview("iPhone 14") {
    SplashView()
        .environmentObject(AuthenticationState())
}

#Preview("iPad Pro") {
    SplashView()
        .environmentObject(AuthenticationState())
}
