import SwiftUI
import FirebaseAuth

struct DidYouKnowFact: Identifiable {
    let id = UUID()
    let text: String
    let imageName: String
}

struct SplashView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var isActive = false
    @State private var showDidYouKnow = false
    @State private var currentFact: DidYouKnowFact?
    @State private var logoOpacity: Double = 0
    @State private var logoOffset: CGFloat = 20
    @State private var textOpacity: Double = 0
    @State private var buttonOpacity: Double = 0

    private var isFirstLaunch: Bool {
        !UserDefaults.standard.bool(forKey: "hasSeenBrandedSplash")
    }

    let facts: [DidYouKnowFact] = [
        DidYouKnowFact(text: "Esther bravely approached the king to save her people. (Esther 4:14-16)", imageName: "BFM1"),
        DidYouKnowFact(text: "Mary, the mother of Jesus, said yes to God despite uncertainty. (Luke 1:38)", imageName: "BFM2"),
        DidYouKnowFact(text: "Deborah led Israel as a prophetess and judge. (Judges 4:4-5)", imageName: "BFM3"),
        DidYouKnowFact(text: "Ruth showed loyalty and faith, becoming part of Jesus' lineage. (Ruth 1:16-17)", imageName: "BFM4"),
        DidYouKnowFact(text: "Hannah prayed earnestly for a child and dedicated Samuel to God. (1 Samuel 1:27-28)", imageName: "BFM5"),
        DidYouKnowFact(text: "Miriam led women in worship and praise. (Exodus 15:20-21)", imageName: "BFM6"),
        DidYouKnowFact(text: "Priscilla taught the Word alongside her husband Aquila. (Acts 18:26)", imageName: "BFM7"),
        DidYouKnowFact(text: "Mary Magdalene was the first to witness the resurrected Jesus. (John 20:11-18)", imageName: "BFM8"),
        DidYouKnowFact(text: "Phoebe served as a deaconess, helping the early church. (Romans 16:1-2)", imageName: "BFM9"),
        DidYouKnowFact(text: "Lydia welcomed Paul and hosted the church in her home. (Acts 16:14-15)", imageName: "BFM10"),
        DidYouKnowFact(text: "Rahab protected Israelite spies and showed faith that spared her family. (Joshua 2:1-21)", imageName: "BFM11"),
        DidYouKnowFact(text: "Elizabeth rejoiced at God's miraculous plan for John the Baptist. (Luke 1:41-45)", imageName: "BFM1"),
        DidYouKnowFact(text: "Anna the prophetess worshiped and prayed at the temple daily. (Luke 2:36-38)", imageName: "BFM2"),
        DidYouKnowFact(text: "The Shunammite woman offered hospitality to Elisha and was blessed. (2 Kings 4:8-17)", imageName: "BFM3"),
        DidYouKnowFact(text: "Abigail prevented David from making a grave mistake through wisdom. (1 Samuel 25:23-35)", imageName: "BFM4"),
        DidYouKnowFact(text: "Huldah was a prophetess who guided King Josiah with God's Word. (2 Kings 22:14-20)", imageName: "BFM5"),
        DidYouKnowFact(text: "Jael courageously defeated Sisera to save Israel. (Judges 4:17-22)", imageName: "BFM6"),
        DidYouKnowFact(text: "Martha served Jesus faithfully, showing love through action. (Luke 10:38-42)", imageName: "BFM7"),
        DidYouKnowFact(text: "Joanna supported the disciples financially and spiritually. (Luke 8:3)", imageName: "BFM8"),
        DidYouKnowFact(text: "The Proverbs 31 woman was praised for strength, wisdom, and faith. (Proverbs 31:10-31)", imageName: "BFM9"),
        DidYouKnowFact(text: "Mary of Bethany honored Jesus with her precious gift. (John 12:1-8)", imageName: "BFM10"),
        DidYouKnowFact(text: "The woman at the well became the first evangelist after meeting Jesus. (John 4:7-26)", imageName: "BFM11"),
        DidYouKnowFact(text: "Phoebe exemplified service and leadership in the early church. (Romans 16:1-2)", imageName: "BFM1"),
        DidYouKnowFact(text: "Priscilla taught with wisdom and courage, spreading God's Word. (Acts 18:24-26)", imageName: "BFM2"),
        DidYouKnowFact(text: "Salome witnessed and ministered at Jesus' crucifixion. (Mark 15:40-41)", imageName: "BFM3"),
        DidYouKnowFact(text: "Susanna helped support the disciples with her own resources. (Luke 8:3)", imageName: "BFM4"),
        DidYouKnowFact(text: "Anna's prophetic words revealed God's plan for Jesus. (Luke 2:36-38)", imageName: "BFM5"),
        DidYouKnowFact(text: "Ruth's devotion to Naomi is one of the Bible's greatest acts of love. (Ruth 1:16)", imageName: "BFM6"),
        DidYouKnowFact(text: "Rahab's faith in God changed her destiny and her family's forever. (Joshua 6:17-25)", imageName: "BFM7"),
        DidYouKnowFact(text: "Elizabeth, filled with the Holy Spirit, blessed Mary and her unborn child. (Luke 1:41-45)", imageName: "BFM8")
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
            } else if showDidYouKnow, let fact = currentFact {
                didYouKnowScreen(fact: fact)
                    .transition(.opacity)
            } else if isFirstLaunch {
                splashScreen
                    .onAppear {
                        UserDefaults.standard.set(true, forKey: "hasSeenBrandedSplash")
                        withAnimation(.easeOut(duration: 0.7).delay(0.2)) {
                            logoOpacity = 1; logoOffset = 0
                        }
                        withAnimation(.easeOut(duration: 0.6).delay(0.6)) {
                            textOpacity = 1
                        }
                        withAnimation(.easeOut(duration: 0.6).delay(1.0)) {
                            buttonOpacity = 1
                        }
                    }
            } else {
                Color(hex: "#fdf0f0").ignoresSafeArea()
                    .onAppear {
                        currentFact = facts.randomElement()
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showDidYouKnow = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            withAnimation(.easeOut(duration: 0.5)) {
                                showDidYouKnow = false
                                isActive = true
                            }
                        }
                    }
            }
        }
    }

    // MARK: - Branded Splash (first launch only)

    private var splashScreen: some View {
        ZStack {
            LinearGradient(
                stops: [
                    .init(color: Color(hex: "#fde8e8"), location: 0.0),
                    .init(color: Color(hex: "#fdf0f0"), location: 0.5),
                    .init(color: Color(hex: "#ebe8f5"), location: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .fill(Color(hex: "#f5c5be").opacity(0.25))
                .frame(width: 320, height: 320)
                .offset(x: 120, y: -200)
                .blur(radius: 40)

            Circle()
                .fill(Color(hex: "#d4c5f5").opacity(0.2))
                .frame(width: 280, height: 280)
                .offset(x: -120, y: 280)
                .blur(radius: 40)

            VStack(spacing: 0) {
                Spacer()
                VStack(spacing: 20) {
                    Image("Bibleformomslogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .cornerRadius(22)
                        .shadow(color: Color(hex: "#c9847a").opacity(0.3), radius: 16, x: 0, y: 6)
                        .opacity(logoOpacity)
                        .offset(y: logoOffset)

                    VStack(spacing: 10) {
                        Text("Dear Mom")
                            .font(.custom("Georgia", size: 42))
                            .italic()
                            .foregroundColor(Color(hex: "#3d2020"))
                        Text("Daily hope & strength\nfor your motherhood journey")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(hex: "#9a6b6b"))
                            .multilineTextAlignment(.center)
                            .lineSpacing(6)
                    }
                    .opacity(textOpacity)
                }
                .padding(.bottom, 60)

                Button(action: {
                    withAnimation(.easeOut(duration: 0.5)) { isActive = true }
                }) {
                    Text("Continue")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            LinearGradient(
                                colors: [Color(hex: "#d4827a"), Color(hex: "#c06b6b")],
                                startPoint: .leading, endPoint: .trailing
                            )
                        )
                        .cornerRadius(18)
                        .shadow(color: Color(hex: "#c9847a").opacity(0.4), radius: 12, x: 0, y: 5)
                }
                .padding(.horizontal, 40)
                .opacity(buttonOpacity)

                Spacer(minLength: 60)
            }
        }
    }

    // MARK: - Did You Know Screen (every open after first)

    private func didYouKnowScreen(fact: DidYouKnowFact) -> some View {
        ZStack(alignment: .top) {
            // Full-screen background image
            Image(fact.imageName)
                .resizable()
                .scaledToFill()
                .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                .clipped()

            // Dark gradient at top so text is legible, fades out toward middle
            LinearGradient(
                stops: [
                    .init(color: Color.black.opacity(0.72), location: 0.0),
                    .init(color: Color.black.opacity(0.35), location: 0.45),
                    .init(color: Color.black.opacity(0.0),  location: 0.75)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Text pinned to top of screen
            VStack(alignment: .center, spacing: 16) {
                Text("DID YOU KNOW?")
                    .font(.system(size: 11, weight: .semibold))
                    .tracking(3)
                    .foregroundColor(Color(hex: "#f5c5be"))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 7)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(20)

                Text(fact.text)
                    .font(.custom("Georgia", size: 26))
                    .italic()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .shadow(color: Color.black.opacity(0.4), radius: 4, x: 0, y: 2)
            }
            .padding(.horizontal, 32)
            .padding(.top, 120)
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(AuthenticationState())
}
