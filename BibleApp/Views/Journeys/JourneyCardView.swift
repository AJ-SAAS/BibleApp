// MARK: - JourneyCardView.swift

import SwiftUI

struct JourneyCardView: View {

    let journey: Journey

    var body: some View {

        ZStack(alignment: .bottomLeading) {

            Image(journey.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.65)],
                startPoint: .center,
                endPoint: .bottom
            )

            // Title only — bottom left
            Text(journey.category)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.bottom, 12)

            // Premium / Free badge — top left
            VStack {
                HStack {
                    Text(journey.isPremium ? "✨ Premium" : "🌿 Free")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            journey.isPremium
                                ? Color.black.opacity(0.45)
                                : Color(hex: "#3c8c5a").opacity(0.9)
                        )
                        .cornerRadius(8)
                    Spacer()
                }
                Spacer()
            }
            .padding(10)

            // Heart button — top right
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .font(.system(size: 11))
                        .foregroundColor(.white)
                        .frame(width: 28, height: 28)
                        .background(.white.opacity(0.25))
                        .clipShape(Circle())
                }
                Spacer()
            }
            .padding(10)
        }
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(20)
        .clipped()
    }
}

#Preview {
    JourneyCardView(
        journey: Journey(
            id: "1",
            title: "Rest for the Weary Mom",
            subtitle: "",
            imageName: "journey_peace",
            category: "Peace",
            durationDays: 30,
            isPremium: true,
            description: "",
            accentColor: "#DFA58D"
        )
    )
    .padding()
}
