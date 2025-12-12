import SwiftUI

struct OnboardingQuestionsView: View {
    @EnvironmentObject var authState: AuthenticationState
    @State private var currentQuestionIndex = 0
    @State private var navigateToHome = false
    
    // State variables for answers
    @State private var faithBackground = ""
    @State private var ageGroup = ""
    @State private var bibleGoal = ""
    @State private var readingFrequency = ""
    @State private var spiritualGoal = ""
    @State private var guidancePreference = ""
    @State private var biggestChallenge = ""
    
    // UserDefaults keys
    private let userDefaults = UserDefaults.standard
    private let faithBackgroundKey = "UserFaithBackground"
    private let ageGroupKey = "UserAgeGroup"
    private let bibleGoalKey = "UserBibleGoal"
    private let readingFrequencyKey = "UserReadingFrequency"
    private let spiritualGoalKey = "UserSpiritualGoal"
    private let guidancePreferenceKey = "UserGuidancePreference"
    private let biggestChallengeKey = "UserBiggestChallenge"
    
    // Question data
    private let questions = [
        (
            question: "What’s your faith background?",
            subtitle: "This helps us recommend resources that resonate with you.",
            choices: ["Orthodox", "Catholic", "Baptist", "Methodist", "Pentecostal", "Other"],
            key: "UserFaithBackground"
        ),
        (
            question: "Which age group best describes you?",
            subtitle: "We ask so we can better personalize your journey.",
            choices: ["13–17", "18–24", "25–34", "35–44", "45–54", "55+"],
            key: "UserAgeGroup"
        ),
        (
            question: "What’s your main goal with the Bible?",
            subtitle: "We’d love to know how Closer to Christ can serve you.",
            choices: ["To study and learn the Bible", "To find guidance for life’s challenges"],
            key: "UserBibleGoal"
        ),
        (
            question: "How often do you currently read the Bible?",
            subtitle: "This helps us encourage you with the right pace.",
            choices: ["Almost every day", "A few times a week", "Rarely", "I’m new to the Bible"],
            key: "UserReadingFrequency"
        ),
        (
            question: "What’s your biggest spiritual goal right now?",
            subtitle: "We’ll suggest content that supports your growth.",
            choices: ["Deepen my daily faith", "Overcome challenges", "Share my faith with others", "Build lasting habits"],
            key: "UserSpiritualGoal"
        ),
        (
            question: "What type of guidance do you prefer?",
            subtitle: "We want to match you with what inspires you most.",
            choices: ["Daily verses & tasks", "In-depth Bible study", "Encouragement from community", "Guided prayers"],
            key: "UserGuidancePreference"
        ),
        (
            question: "What’s the biggest challenge you face right now?",
            subtitle: "This helps us create a daily plan that’s relevant to you.",
            choices: ["Staying consistent", "Feeling disconnected", "Life’s challenges", "Understanding the Bible"],
            key: "UserBiggestChallenge"
        )
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Progress Bar
                    ProgressView(value: Double(currentQuestionIndex + 1), total: Double(questions.count))
                        .progressViewStyle(LinearProgressViewStyle(tint: Color.blue.opacity(0.8)))
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    
                    // Back Button (hidden for first question)
                    if currentQuestionIndex > 0 {
                        HStack {
                            Button(action: {
                                currentQuestionIndex -= 1
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                                    .padding()
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    } else {
                        Spacer().frame(height: 40) // Maintain spacing for first question
                    }
                    
                    // Question and Subtitle
                    VStack(alignment: .leading, spacing: 8) {
                        Text("👉 \(questions[currentQuestionIndex].question)")
                            .font(.system(size: 28, weight: .bold, design: .serif))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        
                        Text(questions[currentQuestionIndex].subtitle)
                            .font(.system(size: 16, weight: .regular, design: .serif))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Answer Choices (moved down with padding)
                    VStack(spacing: 10) {
                        ForEach(questions[currentQuestionIndex].choices, id: \.self) { choice in
                            AnswerButton(
                                choice: choice,
                                isSelected: isSelected(choice: choice),
                                onSelect: {
                                    saveAnswer(choice: choice)
                                }
                            )
                            .frame(maxWidth: 300) // Constrain width for centering
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20) // Added padding to move answers down
                    
                    Spacer()
                    
                    // Continue or Start My Journey button
                    Button(action: {
                        if isAnswerSelected() {
                            if currentQuestionIndex < questions.count - 1 {
                                currentQuestionIndex += 1
                            } else {
                                userDefaults.set(true, forKey: "hasCompletedOnboardingQuestions")
                                navigateToHome = true
                            }
                        }
                    }) {
                        Text(currentQuestionIndex == questions.count - 1 ? "Start My Journey" : "Continue")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 300)
                            .background(isAnswerSelected() ? Color.black : Color.gray)
                            .cornerRadius(8)
                    }
                    .disabled(!isAnswerSelected())
                    .padding(.bottom, 60)
                }
                .padding(.top, 10)
                .navigationDestination(isPresented: $navigateToHome) {
                    TabBarView()
                        .environmentObject(authState)
                        .navigationBarBackButtonHidden(true)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            // Load saved answers if any
            loadSavedAnswers()
            print("OnboardingQuestionsView: Appeared, currentQuestionIndex: \(currentQuestionIndex)")
        }
    }
    
    // Check if an answer is selected for the current question
    private func isAnswerSelected() -> Bool {
        switch currentQuestionIndex {
        case 0: return !faithBackground.isEmpty
        case 1: return !ageGroup.isEmpty
        case 2: return !bibleGoal.isEmpty
        case 3: return !readingFrequency.isEmpty
        case 4: return !spiritualGoal.isEmpty
        case 5: return !guidancePreference.isEmpty
        case 6: return !biggestChallenge.isEmpty
        default: return false
        }
    }
    
    // Check if a specific choice is selected
    private func isSelected(choice: String) -> Bool {
        switch currentQuestionIndex {
        case 0: return choice == faithBackground
        case 1: return choice == ageGroup
        case 2: return choice == bibleGoal
        case 3: return choice == readingFrequency
        case 4: return choice == spiritualGoal
        case 5: return choice == guidancePreference
        case 6: return choice == biggestChallenge
        default: return false
        }
    }
    
    // Save the selected answer to UserDefaults
    private func saveAnswer(choice: String) {
        let key = questions[currentQuestionIndex].key
        userDefaults.set(choice, forKey: key)
        switch currentQuestionIndex {
        case 0: faithBackground = choice
        case 1: ageGroup = choice
        case 2: bibleGoal = choice
        case 3: readingFrequency = choice
        case 4: spiritualGoal = choice
        case 5: guidancePreference = choice
        case 6: biggestChallenge = choice
        default: break
        }
    }
    
    // Load saved answers from UserDefaults
    private func loadSavedAnswers() {
        faithBackground = userDefaults.string(forKey: faithBackgroundKey) ?? ""
        ageGroup = userDefaults.string(forKey: ageGroupKey) ?? ""
        bibleGoal = userDefaults.string(forKey: bibleGoalKey) ?? ""
        readingFrequency = userDefaults.string(forKey: readingFrequencyKey) ?? ""
        spiritualGoal = userDefaults.string(forKey: spiritualGoalKey) ?? ""
        guidancePreference = userDefaults.string(forKey: guidancePreferenceKey) ?? ""
        biggestChallenge = userDefaults.string(forKey: biggestChallengeKey) ?? ""
    }
}

// Subview for Answer Button
struct AnswerButton: View {
    let choice: String
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            Text(choice)
                .font(.system(size: 18, weight: .regular, design: .serif))
                .foregroundColor(isSelected ? .white : .black)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.black : Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
        }
    }
}

#Preview("iPhone 14") {
    OnboardingQuestionsView()
        .environmentObject(AuthenticationState())
}

#Preview("iPad Pro") {
    OnboardingQuestionsView()
        .environmentObject(AuthenticationState())
}
