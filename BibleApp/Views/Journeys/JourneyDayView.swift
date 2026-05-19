// MARK: - JourneyDayView.swift

import SwiftUI

struct JourneyDayView: View {

    let day: JourneyDay

    private let progressManager = JourneyProgressManager.shared

    var body: some View {

        let isCompleted = progressManager.isCompleted(
            journeyID: day.journeyID,
            day: day.dayNumber
        )

        ScrollView(showsIndicators: false) {

            VStack(alignment: .leading, spacing: 32) {

                // MARK: Header

                VStack(alignment: .leading, spacing: 14) {

                    Text("Day \(day.dayNumber) of 30")
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.secondary)

                    Text(day.title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color(hex: "#2c1f14"))

                    Text("Take a deep breath. This moment is for you and God.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineSpacing(4)
                }
                .padding(.top, 8)

                // MARK: Verse
                VStack(alignment: .leading, spacing: 20) {

                    HStack(spacing: 10) {

                        Image(systemName: "book.fill")
                            .foregroundColor(Color(hex: "#DFA58D"))

                        Text("Today's Verse")
                            .font(.headline)
                    }

                    Text(day.verse)
                        .font(.title3)
                        .italic()
                        .lineSpacing(10)
                        .foregroundColor(Color(hex: "#2c1f14"))

                    Text(day.scriptureReference)
                        .font(.subheadline.weight(.bold))
                        .foregroundColor(Color(hex: "#DFA58D"))
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(color: .black.opacity(0.03), radius: 12, x: 0, y: 5)

                // MARK: Reflection
                VStack(alignment: .leading, spacing: 18) {

                    HStack(spacing: 10) {

                        Image(systemName: "heart.fill")
                            .foregroundColor(Color(hex: "#DFA58D"))

                        Text("Reflection")
                            .font(.headline)
                    }

                    Text(day.reflection)
                        .font(.body)
                        .lineSpacing(9)
                        .foregroundColor(Color(hex: "#2c1f14"))
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(30)

                // MARK: Prayer
                VStack(alignment: .leading, spacing: 18) {

                    HStack(spacing: 10) {

                        Image(systemName: "hands.sparkles.fill")
                            .foregroundColor(Color(hex: "#DFA58D"))

                        Text("Prayer")
                            .font(.headline)
                    }

                    Text(day.prayer)
                        .font(.body)
                        .italic()
                        .lineSpacing(9)
                        .foregroundColor(Color(hex: "#2c1f14"))
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(30)

                // MARK: Action
                VStack(alignment: .leading, spacing: 18) {

                    HStack(spacing: 10) {

                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color(hex: "#DFA58D"))

                        Text("Today's Action")
                            .font(.headline)
                    }

                    Text(day.action)
                        .font(.body)
                        .lineSpacing(9)
                        .foregroundColor(Color(hex: "#2c1f14"))
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(30)

                // MARK: Journal Prompt
                VStack(alignment: .leading, spacing: 18) {

                    HStack(spacing: 10) {

                        Image(systemName: "pencil.and.outline")
                            .foregroundColor(Color(hex: "#DFA58D"))

                        Text("Journal Prompt")
                            .font(.headline)
                    }

                    Text(day.journalPrompt)
                        .font(.body)
                        .italic()
                        .lineSpacing(9)
                        .foregroundColor(Color(hex: "#2c1f14"))
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(30)

                // MARK: Completion Section

                VStack(spacing: 18) {

                    Text(
                        isCompleted
                        ? "You completed this day ✨"
                        : "You showed up today. That matters."
                    )
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                    Button {

                        progressManager.toggleComplete(
                            journeyID: day.journeyID,
                            day: day.dayNumber
                        )

                    } label: {

                        HStack {

                            Image(systemName: isCompleted
                                  ? "checkmark.seal.fill"
                                  : "checkmark.circle.fill"
                            )

                            Text(
                                isCompleted
                                ? "Completed"
                                : "Finish Today's Journey"
                            )
                            .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            isCompleted
                            ? Color.green
                            : Color(hex: "#DFA58D")
                        )
                        .cornerRadius(22)
                    }
                }
                .padding(.bottom, 20)
            }
            .padding(20)
        }
        .background(Color(hex: "#faf6f0"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {

    NavigationStack {

        JourneyDayView(
            day: JourneyDay(
                id: "1",
                journeyID: "peace_moms",
                dayNumber: 1,
                title: "Be Still and Know",
                verse: "Be still, and know that I am God.",
                scriptureReference: "Psalm 46:10",
                reflection: "Even in the chaos of motherhood, God invites you to pause and rest in His presence.",
                prayer: "Lord, help me slow down and remember You are with me today.",
                action: "Set a 2-minute timer today. Sit in silence, put your phone down, close your eyes and just breathe.",
                journalPrompt: "What is one thing I am carrying right now that I need to hand to God?",
                isLocked: false
            )
        )
    }
}
