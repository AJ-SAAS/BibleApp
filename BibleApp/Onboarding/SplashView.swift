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
        "live god’s word daily",
        "draw closer to christ"
    ]

    var body: some View {
        Group {
            if isActive {
                if UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") || authState.isAuthenticated || authState.isGuest {
                    TabBarView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                } else {
                    OnboardingView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                }
            } else {
                GeometryReader { geo in
                    ZStack {
                        Image("back1")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()

                        Image("dailybiblelogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 165, height: 165)
                            .clipShape(RoundedRectangle(cornerRadius: 40)) // Added to curve edges
                            .position(x: geo.size.width / 2, y: geo.size.height * 0.32)
                            .accessibilityLabel("Closer to Christ App Logo")

                        // Combined Text + Border container
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 1)
                                .frame(width: 320, height: 70)

                            Text(texts[currentTextIndex])
                                .font(.system(size: 22, weight: .regular, design: .serif))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                        }
                        .offset(x: offsetX)
                        .opacity(opacity)
                        .position(x: geo.size.width / 2, y: geo.size.height * 0.6)
                    }
                    .onAppear {
                        animateTextWithBorder()
                    }
                }
            }
        }
    }

    private func animateTextWithBorder() {
        guard currentTextIndex < texts.count else { return }

        // Start offscreen right
        offsetX = UIScreen.main.bounds.width
        opacity = 0

        // Animate in
        withAnimation(.easeOut(duration: 0.5)) {
            offsetX = 0
            opacity = 1
        }

        // Hold for 1.2s
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            // If not the last text, slide out and continue
            if self.currentTextIndex < self.texts.count - 1 {
                withAnimation(.easeIn(duration: 0.5)) {
                    offsetX = -UIScreen.main.bounds.width
                    opacity = 0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.currentTextIndex += 1
                    animateTextWithBorder()
                }
            } else {
                // Last text: keep it for 0.7s then proceed
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
