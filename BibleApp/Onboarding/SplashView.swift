import SwiftUI
import FirebaseAuth

struct SplashView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var isActive = false
    @State private var showDidYouKnow = false
    @State private var currentFact: DidYouKnowFact?

    // MARK: - 30 Rotating Facts
    let facts: [DidYouKnowFact] = [
        DidYouKnowFact(text: "Esther bravely approached the king to save her people. (Esther 4:14-16)", imageName: "esther"),
        DidYouKnowFact(text: "Mary, the mother of Jesus, said yes to God despite uncertainty. (Luke 1:38)", imageName: "mary_mother"),
        DidYouKnowFact(text: "Deborah led Israel as a prophetess and judge. (Judges 4:4-5)", imageName: "deborah"),
        DidYouKnowFact(text: "Ruth showed loyalty and faith, becoming part of Jesus’ lineage. (Ruth 1:16-17)", imageName: "ruth"),
        DidYouKnowFact(text: "Hannah prayed earnestly for a child and dedicated Samuel to God. (1 Samuel 1:27-28)", imageName: "hannah"),
        DidYouKnowFact(text: "Miriam led women in worship and praise. (Exodus 15:20-21)", imageName: "miriam"),
        DidYouKnowFact(text: "Priscilla taught the Word alongside her husband Aquila. (Acts 18:26)", imageName: "priscilla"),
        DidYouKnowFact(text: "Mary Magdalene was the first to witness the resurrected Jesus. (John 20:11-18)", imageName: "mary_magdalene"),
        DidYouKnowFact(text: "Phoebe served as a deaconess, helping the early church. (Romans 16:1-2)", imageName: "phoebe"),
        DidYouKnowFact(text: "Lydia welcomed Paul and hosted the church in her home. (Acts 16:14-15)", imageName: "lydia"),
        DidYouKnowFact(text: "Rahab protected Israelite spies and showed faith that spared her family. (Joshua 2:1-21)", imageName: "rahab"),
        DidYouKnowFact(text: "Elizabeth rejoiced at God’s miraculous plan for John the Baptist. (Luke 1:41-45)", imageName: "elizabeth"),
        DidYouKnowFact(text: "Anna the prophetess worshiped and prayed at the temple daily. (Luke 2:36-38)", imageName: "anna"),
        DidYouKnowFact(text: "The Shunammite woman offered hospitality to Elisha and was blessed. (2 Kings 4:8-17)", imageName: "shunammite"),
        DidYouKnowFact(text: "Abigail prevented David from making a grave mistake through wisdom. (1 Samuel 25:23-35)", imageName: "abigail"),
        DidYouKnowFact(text: "Huldah was a prophetess who guided King Josiah with God’s Word. (2 Kings 22:14-20)", imageName: "huldah"),
        DidYouKnowFact(text: "Jael courageously defeated Sisera to save Israel. (Judges 4:17-22)", imageName: "jael"),
        DidYouKnowFact(text: "Salome witnessed and ministered at Jesus’ crucifixion. (Mark 15:40-41)", imageName: "salome"),
        DidYouKnowFact(text: "Anna’s lifelong devotion inspired faith in all who saw her. (Luke 2:36-37)", imageName: "anna"),
        DidYouKnowFact(text: "Martha served Jesus faithfully, showing love through action. (Luke 10:38-42)", imageName: "martha"),
        DidYouKnowFact(text: "Joanna supported the disciples financially and spiritually. (Luke 8:3)", imageName: "joanna"),
        DidYouKnowFact(text: "Susanna helped the early church with gifts and generosity. (Luke 8:3)", imageName: "susanna"),
        DidYouKnowFact(text: "The Proverbs 31 woman was praised for strength, wisdom, and faith. (Proverbs 31:10-31)", imageName: "proverbs31"),
        DidYouKnowFact(text: "Elizabeth, mother of John the Baptist, celebrated God’s plan for her life. (Luke 1:57-66)", imageName: "elizabeth"),
        DidYouKnowFact(text: "Rahab’s faith in God changed her destiny and her family’s. (Joshua 6:17-25)", imageName: "rahab"),
        DidYouKnowFact(text: "Mary of Bethany honored Jesus with her precious gift. (John 12:1-8)", imageName: "mary_bethany"),
        DidYouKnowFact(text: "Women at the well showed Jesus the power of living water. (John 4:7-26)", imageName: "woman_well"),
        DidYouKnowFact(text: "Anna’s prophetic words revealed God’s plan for Jesus. (Luke 2:36-38)", imageName: "anna"),
        DidYouKnowFact(text: "Phoebe exemplified service and leadership in the church. (Romans 16:1-2)", imageName: "phoebe"),
        DidYouKnowFact(text: "Priscilla taught with wisdom and courage, spreading God’s Word. (Acts 18:24-26)", imageName: "priscilla")
    ]

    var body: some View {
        Group {
            if isActive {
                // Go to main dashboard
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
            } else {
                splashScreen
                    .onAppear {
                        // Show Did You Know if it hasn't been seen today
                        if shouldShowDidYouKnow() {
                            currentFact = facts.randomElement()
                            showDidYouKnow = true
                            markDidYouKnowAsSeen()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    showDidYouKnow = false
                                    isActive = true
                                }
                            }
                        } else {
                            // Otherwise go straight to dashboard after splash
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    isActive = true
                                }
                            }
                        }
                    }
            }
        }
    }

    // MARK: - Original Splash Screen
    private var splashScreen: some View {
        GeometryReader { geo in
            ZStack {
                Image("mom_baby_splash")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.45), Color.black.opacity(0.15)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer()
                    Text("Bible for Moms")
                        .font(.system(size: 34, weight: .semibold, design: .serif))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    Text("Daily hope & strength\nfor your motherhood journey")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.white.opacity(0.95))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 32)

                    Spacer()

                    Button(action: {
                        withAnimation(.easeOut(duration: 0.5)) {
                            isActive = true
                        }
                    }) {
                        Text("Continue")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(14)
                            .padding(.horizontal, 32)
                            .shadow(radius: 6)
                    }

                    Spacer(minLength: 40)
                }
            }
        }
    }

    // MARK: - Did You Know Screen
    private func didYouKnowScreen(fact: DidYouKnowFact) -> some View {
        GeometryReader { geo in
            ZStack {
                Image(fact.imageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .clipped()

                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.4), Color.black.opacity(0.15)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .ignoresSafeArea()

                Text(fact.text)
                    .font(.system(size: 22, weight: .semibold, design: .serif))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .shadow(radius: 4)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.75)
            }
        }
    }
}

#Preview("iPhone 14") {
    SplashView()
        .environmentObject(AuthenticationState())
}
