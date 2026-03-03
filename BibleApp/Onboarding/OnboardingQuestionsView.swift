import SwiftUI

// MARK: - Question Model

struct OnboardingQuestion {
    let question: String
    let subtitle: String
    let emoji: String
    let choices: [String]
    let key: String
}

// MARK: - OnboardingQuestionsView

struct OnboardingQuestionsView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var currentIndex = 0
    @State private var navigateToHome = false
    @State private var answers: [String] = Array(repeating: "", count: 6)
    @State private var animatingIn = false

    private let userDefaults = UserDefaults.standard

    private let questions: [OnboardingQuestion] = [
        OnboardingQuestion(
            question: "What stage of motherhood are you in?",
            subtitle: "So we can share stories and verses that truly speak to where you are.",
            emoji: "🌸",
            choices: ["Expecting a baby", "Newborn / baby stage", "Toddler years", "School-age kids", "Raising teens", "Empty nester"],
            key: "UserMotherhoodStage"
        ),
        OnboardingQuestion(
            question: "How would you describe your season right now?",
            subtitle: "We all go through different seasons — there's no wrong answer here.",
            emoji: "🍃",
            choices: ["Overwhelmed & stretched thin", "Finding my footing", "Growing & thriving", "Seeking something deeper"],
            key: "UserCurrentSeason"
        ),
        OnboardingQuestion(
            question: "When do you usually find a quiet moment?",
            subtitle: "We'll help you build a rhythm that fits your real life.",
            emoji: "☕️",
            choices: ["Early morning", "Nap time / school hours", "Evening after bedtime", "Whenever I can steal a minute"],
            key: "UserQuietTime"
        ),
        OnboardingQuestion(
            question: "What do you need most right now?",
            subtitle: "Be honest — we're here for all of it.",
            emoji: "🙏",
            choices: ["Strength to keep going", "Peace in the chaos", "Guidance as a mom", "Reconnecting with my faith"],
            key: "UserCurrentNeed"
        ),
        OnboardingQuestion(
            question: "How long have you been walking with God?",
            subtitle: "Every journey is beautiful, wherever you are on the path.",
            emoji: "✝️",
            choices: ["I'm new to faith", "A few years", "Most of my life", "Returning after a break"],
            key: "UserFaithJourney"
        ),
        OnboardingQuestion(
            question: "What brings you here today?",
            subtitle: "This helps us personalise your daily devotionals just for you.",
            emoji: "💛",
            choices: ["I need daily encouragement", "I want to study the Bible", "I want to raise my kids in faith", "I'm going through something hard"],
            key: "UserReason"
        )
    ]

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color(hex: "#fde8e8"), Color(hex: "#fdf0f0"), Color(hex: "#ebe8f5")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Progress bar ─────────────────────────
                progressBar
                    .padding(.top, 16)
                    .padding(.horizontal, 24)

                // ── Question card ─────────────────────────
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 28) {

                        questionHeader
                            .padding(.top, 32)

                        choicesStack

                        continueButton
                            .padding(.bottom, 60)
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToHome) {
            TabBarView()
                .environmentObject(authState)
                .navigationBarBackButtonHidden(true)
        }
        .onAppear { loadSavedAnswers() }
    }

    // MARK: - Progress Bar

    private var progressBar: some View {
        VStack(spacing: 10) {
            HStack {
                if currentIndex > 0 {
                    Button(action: {
                        withAnimation(.spring(response: 0.3)) {
                            currentIndex -= 1
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.roseGold)
                    }
                } else {
                    Spacer().frame(width: 24)
                }

                Spacer()

                Text("\(currentIndex + 1) of \(questions.count)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.textSoft)
            }

            // Progress track
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(hex: "#f0e0e0"))
                        .frame(height: 5)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "#d4827a"), Color(hex: "#c9847a")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geo.size.width * CGFloat(currentIndex + 1) / CGFloat(questions.count), height: 5)
                        .animation(.spring(response: 0.4), value: currentIndex)
                }
            }
            .frame(height: 5)
        }
    }

    // MARK: - Question Header

    private var questionHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(questions[currentIndex].emoji)
                .font(.system(size: 40))

            Text(questions[currentIndex].question)
                .font(.custom("Georgia", size: 26))
                .italic()
                .foregroundColor(.textDark)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            Text(questions[currentIndex].subtitle)
                .font(.system(size: 14))
                .foregroundColor(.textSoft)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Choices

    private var choicesStack: some View {
        VStack(spacing: 12) {
            ForEach(questions[currentIndex].choices, id: \.self) { choice in
                choiceButton(choice)
            }
        }
    }

    @ViewBuilder
    private func choiceButton(_ choice: String) -> some View {
        let isSelected = answers[currentIndex] == choice

        Button(action: {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                answers[currentIndex] = choice
                userDefaults.set(choice, forKey: questions[currentIndex].key)
            }
        }) {
            HStack(spacing: 14) {
                // Selection indicator
                ZStack {
                    Circle()
                        .strokeBorder(isSelected ? Color.roseGold : Color(hex: "#e0d0d0"), lineWidth: 1.5)
                        .frame(width: 22, height: 22)

                    if isSelected {
                        Circle()
                            .fill(Color.roseGold)
                            .frame(width: 12, height: 12)
                    }
                }

                Text(choice)
                    .font(.system(size: 15, weight: isSelected ? .medium : .regular))
                    .foregroundColor(isSelected ? .textDark : .textSoft)
                    .multilineTextAlignment(.leading)

                Spacer()
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.white : Color.white.opacity(0.6))
                    .shadow(
                        color: isSelected ? Color.roseGold.opacity(0.2) : Color.clear,
                        radius: 8, x: 0, y: 3
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        isSelected ? Color.roseGold.opacity(0.4) : Color.clear,
                        lineWidth: 1.5
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: - Continue Button

    private var continueButton: some View {
        let isAnswered = !answers[currentIndex].isEmpty
        let isLast = currentIndex == questions.count - 1

        return Button(action: {
            guard isAnswered else { return }
            if isLast {
                userDefaults.set(true, forKey: "hasCompletedOnboardingQuestions")
                navigateToHome = true
            } else {
                withAnimation(.spring(response: 0.3)) {
                    currentIndex += 1
                }
            }
        }) {
            HStack(spacing: 10) {
                Text(isLast ? "Begin My Journey" : "Continue")
                    .font(.system(size: 16, weight: .semibold))
                if !isLast {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 14, weight: .semibold))
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(
                Group {
                    if isAnswered {
                        LinearGradient(
                            colors: [Color(hex: "#d4827a"), Color(hex: "#c9847a")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    } else {
                        LinearGradient(
                            colors: [Color(hex: "#e0cece"), Color(hex: "#ddd0d0")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    }
                }
            )
            .cornerRadius(18)
            .shadow(
                color: isAnswered ? Color.roseGold.opacity(0.3) : Color.clear,
                radius: 10, x: 0, y: 4
            )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!isAnswered)
        .padding(.top, 8)
    }

    // MARK: - Helpers

    private func loadSavedAnswers() {
        for (i, q) in questions.enumerated() {
            answers[i] = userDefaults.string(forKey: q.key) ?? ""
        }
    }
}

#Preview {
    NavigationStack {
        OnboardingQuestionsView()
            .environmentObject(AuthenticationState())
    }
}
