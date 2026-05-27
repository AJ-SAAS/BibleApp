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

            VStack(alignment: .leading, spacing: 4) {
                Text(journey.title)
                    .font(.custom("Georgia", size: 18))
                    .italic()
                    .foregroundColor(.white)
                    .lineLimit(2)

                Text(journey.category)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding(16)

            // Premium badge
            VStack {
                HStack {
                    if journey.isPremium {
                        Text("✨ Premium")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(8)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(12)
        }
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(22)
        .clipped()
        .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
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
