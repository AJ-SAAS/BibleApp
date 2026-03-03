import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var navigateToAuth = false
    @State private var navigateToQuestions = false

    var body: some View {
        NavigationStack {
            MissionScreen(
                onContinueAsGuest: {
                    UserDefaults.standard.set(false, forKey: "hasCompletedOnboardingQuestions")
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
        }
    }
}

// MARK: - MissionScreen

struct MissionScreen: View {
    var onContinueAsGuest: () -> Void
    var onSignIn: () -> Void

    @State private var logoOpacity: Double = 0
    @State private var logoOffset: CGFloat = 16
    @State private var contentOpacity: Double = 0
    @State private var buttonsOpacity: Double = 0

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color(hex: "#fde8e8"), Color(hex: "#fdf0f0"), Color(hex: "#ebe8f5")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Decorative blurred circles
            Circle()
                .fill(Color(hex: "#f5c5be").opacity(0.3))
                .frame(width: 340, height: 340)
                .offset(x: 130, y: -220)
                .blur(radius: 50)

            Circle()
                .fill(Color(hex: "#d4c5f5").opacity(0.2))
                .frame(width: 260, height: 260)
                .offset(x: -120, y: 300)
                .blur(radius: 45)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // ── Logo ─────────────────────────────
                    HStack {
                        Image("Bibleformomslogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                            .cornerRadius(22)
                            .shadow(color: Color(hex: "#c9847a").opacity(0.25), radius: 14, x: 0, y: 5)
                            .opacity(logoOpacity)
                            .offset(y: logoOffset)
                        Spacer()
                    }
                    .padding(.horizontal, 28)
                    .padding(.top, 56)
                    .padding(.bottom, 28)

                    // ── Headline ─────────────────────────
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Made for Moms,\nRooted in Scripture.")
                            .font(.custom("Georgia", size: 34))
                            .italic()
                            .foregroundColor(Color(hex: "#3d2020"))
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)

                        Text("Daily devotionals, Bible study, and gentle encouragement — all designed for your motherhood journey.")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(hex: "#9a6b6b"))
                            .lineSpacing(5)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 36)
                    .opacity(contentOpacity)

                    // ── Feature pills ─────────────────────
                    VStack(spacing: 12) {
                        featurePill(icon: "heart.text.square", text: "Devotionals tailored to your season of motherhood")
                        featurePill(icon: "book.closed", text: "Full KJV Bible with verse highlighting")
                        featurePill(icon: "sparkles", text: "Daily hope & strength, one verse at a time")
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 40)
                    .opacity(contentOpacity)

                    // ── Community badge ───────────────────
                    Text("Join thousands of moms deepening their faith daily.")
                        .font(.custom("Georgia", size: 17))
                        .italic()
                        .foregroundColor(Color(hex: "#7a5555"))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(Color(hex: "#f0d0cc"), lineWidth: 1)
                        )
                        .padding(.horizontal, 28)
                        .padding(.bottom, 40)
                        .opacity(contentOpacity)

                    // ── Buttons ───────────────────────────
                    VStack(spacing: 14) {

                        // Sign up with email — primary
                        Button(action: onSignIn) {
                            HStack(spacing: 10) {
                                Image(systemName: "envelope.fill")
                                    .font(.system(size: 15))
                                Text("Sign up with Email")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "#d4827a"), Color(hex: "#c06b6b")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(18)
                            .shadow(color: Color(hex: "#c9847a").opacity(0.35), radius: 10, x: 0, y: 4)
                        }
                        .buttonStyle(PlainButtonStyle())

                        // Continue without account — secondary
                        Button(action: onContinueAsGuest) {
                            Text("Continue without an account")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(Color(hex: "#9a6b6b"))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(18)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .strokeBorder(Color(hex: "#f0d0cc"), lineWidth: 1.5)
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 28)
                    .opacity(buttonsOpacity)

                    // ── Legal ─────────────────────────────
                    Text("By continuing, you agree to our Privacy Policy and Terms of Use. Your information is handled with care.")
                        .font(.system(size: 11))
                        .foregroundColor(Color(hex: "#b89090"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 28)
                        .padding(.top, 16)
                        .padding(.bottom, 50)
                        .opacity(contentOpacity)
                }
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.7).delay(0.1)) {
                logoOpacity = 1
                logoOffset = 0
            }
            withAnimation(.easeOut(duration: 0.6).delay(0.4)) {
                contentOpacity = 1
            }
            withAnimation(.easeOut(duration: 0.6).delay(0.7)) {
                buttonsOpacity = 1
            }
        }
    }

    @ViewBuilder
    private func featurePill(icon: String, text: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.roseGold)
                .frame(width: 32)

            Text(text)
                .font(.system(size: 14))
                .foregroundColor(Color(hex: "#7a5555"))
                .lineSpacing(3)

            Spacer()
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background(Color.white.opacity(0.65))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .strokeBorder(Color(hex: "#f0d0cc").opacity(0.6), lineWidth: 1)
        )
    }
}

// MARK: - Preview

#Preview {
    OnboardingView()
        .environmentObject(AuthenticationState())
}
