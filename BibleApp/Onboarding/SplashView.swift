import SwiftUI
import FirebaseAuth

struct SplashView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var isActive = false
    @State private var opacity = 0.0
    
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
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    VStack(spacing: 16) {
                        Image("dailybiblelogo") // Updated to match AuthView
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .accessibilityLabel("Closer to Christ App Logo")
                        
                        Text("Closer to Christ")
                            .font(.custom("Georgia", size: 36))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Begin each day with God’s Word and purpose.")
                            .font(.system(size: 16, weight: .medium, design: .serif))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    .opacity(opacity)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Closer to Christ. Begin each day with God’s Word and purpose.")
                }
                .onAppear {
                    withAnimation(.easeIn(duration: 1.0)) {
                        opacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            isActive = true
                        }
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
