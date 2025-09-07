import SwiftUI
import FirebaseAuth

struct SplashView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var isActive = false
    @State private var currentTextIndex = 0
    @State private var offsetX: CGFloat = UIScreen.main.bounds.width // start offscreen right
    @State private var fade = false

    let texts = [
        "start your day with scripture",
        "live god’s word daily",
        "draw closer to christ"
    ]

    var body: some View {
        Group {
            if isActive {
                if UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") {
                    if authState.isAuthenticated {
                        TabBarView()
                            .environmentObject(authState)
                    } else {
                        AuthView()
                            .environmentObject(authState)
                    }
                } else {
                    OnboardingView()
                        .environmentObject(authState)
                }
            } else {
                GeometryReader { geo in
                    ZStack {
                        // Background color
                        Color(red: 55/255, green: 4/255, blue: 64/255)
                            .ignoresSafeArea()

                        // App Icon at 30% height
                        Image("dailybiblelogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 165, height: 165)
                            .position(x: geo.size.width / 2, y: geo.size.height * 0.32)
                            .accessibilityLabel("Closer to Christ App Logo")

                        // Text box at 60% height
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 1)
                                .frame(width: 320, height: 70)

                            Text(texts[currentTextIndex])
                                .font(.system(size: 22, weight: .regular, design: .serif))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                                .offset(x: offsetX)
                        }
                        .position(x: geo.size.width / 2, y: geo.size.height * 0.6)
                    }
                    .onAppear {
                        animateTexts()
                    }
                }
            }
        }
    }

    /// Animates texts one by one with enter from right, exit to left, final text stays
    private func animateTexts() {
        guard currentTextIndex < texts.count else { return }

        // Enter from right
        offsetX = UIScreen.main.bounds.width
        withAnimation(.easeOut(duration: 0.5)) {
            offsetX = 0
        }

        // Hold in center for 1.2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            if self.currentTextIndex < self.texts.count - 1 {
                // Exit to left
                withAnimation(.easeIn(duration: 0.5)) {
                    offsetX = -UIScreen.main.bounds.width
                }

                // After exit, show next text
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.currentTextIndex += 1
                    animateTexts()
                }
            } else {
                // Final text, hold and then transition
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeOut(duration: 0.6)) {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(AuthenticationState())
}

