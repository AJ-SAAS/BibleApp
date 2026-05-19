import SwiftUI

struct JourneyDetailView: View {

    let journey: Journey
    let days: [JourneyDay]

    private let progressManager = JourneyProgressManager.shared

    init(journey: Journey) {
        self.journey = journey
        self.days = JourneyService.shared.loadJourneyDays(for: journey.id)
    }

    // MARK: - Computed Progress

    private var completedDays: Int {
        days.filter {
            progressManager.isCompleted(
                journeyID: journey.id,
                day: $0.dayNumber
            )
        }.count
    }

    private var nextDayNumber: Int {
        (1...journey.durationDays).first { day in
            !progressManager.isCompleted(journeyID: journey.id, day: day)
        } ?? journey.durationDays
    }

    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack(spacing: 0) {

                // MARK: HERO
                ZStack(alignment: .bottomLeading) {

                    Image(journey.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 360)
                        .frame(maxWidth: .infinity)
                        .clipped()

                    LinearGradient(
                        colors: [.clear, .black.opacity(0.75)],
                        startPoint: .top,
                        endPoint: .bottom
                    )

                    VStack(alignment: .leading, spacing: 12) {

                        Spacer()

                        Text(journey.title)
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)

                        Text(journey.subtitle)
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.95))

                        Text(journey.description)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))

                        HStack(spacing: 12) {
                            Label("\(journey.durationDays) Days", systemImage: "calendar")
                            Label("5 min/day", systemImage: "clock")
                        }
                        .font(.caption.weight(.medium))
                        .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(24)
                }

                // MARK: PROGRESS HEADER
                VStack(alignment: .leading, spacing: 16) {

                    VStack(alignment: .leading, spacing: 6) {

                        Text("Your Journey")
                            .font(.headline)

                        Text("\(completedDays)/\(journey.durationDays) days completed")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    // MARK: CONTINUE BUTTON (IMPORTANT UX UPGRADE)
                    NavigationLink {

                        if let day = days.first(where: {
                            $0.dayNumber == nextDayNumber
                        }) {
                            JourneyDayView(day: day)
                        }

                    } label: {

                        HStack {
                            Image(systemName: "play.fill")
                            Text("Continue Day \(nextDayNumber)")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#DFA58D"))
                        .cornerRadius(18)
                    }

                    // MARK: PROGRESS DOTS
                    ScrollView(.horizontal, showsIndicators: false) {

                        HStack(spacing: 10) {

                            ForEach(1...journey.durationDays, id: \.self) { day in

                                let isCompleted = progressManager.isCompleted(
                                    journeyID: journey.id,
                                    day: day
                                )

                                let isNext = day == nextDayNumber

                                Circle()
                                    .fill(
                                        isCompleted
                                        ? Color(hex: "#DFA58D")
                                        : isNext
                                        ? Color(hex: "#c7a08c")
                                        : Color(hex: "#ece4db")
                                    )
                                    .frame(width: isNext ? 40 : 34, height: isNext ? 40 : 34)
                                    .overlay {

                                        Text("\(day)")
                                            .font(.caption.bold())
                                            .foregroundColor(
                                                isCompleted || isNext ? .white : .gray
                                            )
                                    }
                            }
                        }
                    }

                    // MARK: DAYS LIST (LOCKED SYSTEM)
                    VStack(spacing: 14) {

                        ForEach(days) { day in

                            let isUnlocked = day.dayNumber <= nextDayNumber

                            NavigationLink {

                                JourneyDayView(day: day)

                            } label: {

                                JourneyDayCard(day: day)
                                    .opacity(isUnlocked ? 1 : 0.5)
                            }
                            .disabled(!isUnlocked)
                        }
                    }
                }
                .padding(20)
                .background(Color(hex: "#faf6f0"))
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color(hex: "#faf6f0"))
        .navigationBarTitleDisplayMode(.inline)
    }
}
