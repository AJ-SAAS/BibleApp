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
                    
                    VStack {
                        Image("dailybiblelogo") // Updated to match AuthView
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .accessibilityLabel("dailybiblelogo")
                        
                        Text("Bible App")
                            .font(.custom("Georgia", size: 36))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Grow Closer to God Daily")
                            .font(.system(size: 16, weight: .medium, design: .serif))
                            .foregroundColor(.gray)
                    }
                    .opacity(opacity)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Bible App: Grow Closer to God Daily")
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
