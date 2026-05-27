import SwiftUI

struct JourneyDayCard: View {
    let day: JourneyDay

    var body: some View {
        HStack(spacing: 18) {
            // Day Icon
            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .fill(
                        day.isLocked
                        ? Color.blushLight
                        : Color.white
                    )
                    .frame(width: 74, height: 74)

                VStack(spacing: 6) {
                    Image(systemName: day.isLocked ? "lock.fill" : "sun.max.fill")
                        .font(.title3)
                        .foregroundColor(day.isLocked ? .textSoft : Color.roseGold)

                    Text("\(day.dayNumber)")
                        .font(.caption.bold())
                        .foregroundColor(day.isLocked ? .textSoft : .textDark)
                }
            }

            // Text Content
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Day \(day.dayNumber)")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.textSoft)

                    Spacer()

                    if !day.isLocked {
                        Text("OPEN")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(Color.roseGold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.blushLight)
                            .cornerRadius(20)
                    }
                }

                Text(day.title)
                    .font(.headline)
                    .foregroundColor(.textDark)
                    .multilineTextAlignment(.leading)

                Text(day.scriptureReference)
                    .font(.subheadline)
                    .foregroundColor(.textSoft)
                    .lineLimit(1)
            }

            Spacer()

            Image(systemName: day.isLocked ? "lock.fill" : "chevron.right")
                .font(.caption.weight(.bold))
                .foregroundColor(day.isLocked ? .textSoft : Color.roseGold)
        }
        .padding(18)
        .background(Color.white)
        .cornerRadius(28)
        .opacity(day.isLocked ? 0.75 : 1.0)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    VStack(spacing: 20) {
        JourneyDayCard(day: JourneyDay(id: "1", journeyID: "peace_moms", dayNumber: 1, title: "Be Still and Know", verse: "", scriptureReference: "Psalm 46:10", reflection: "", prayer: "", action: "", journalPrompt: "", isLocked: false))
        
        JourneyDayCard(day: JourneyDay(id: "2", journeyID: "peace_moms", dayNumber: 2, title: "Trusting God in the Chaos", verse: "", scriptureReference: "Isaiah 26:3", reflection: "", prayer: "", action: "", journalPrompt: "", isLocked: true))
    }
    .padding()
    .background(Color.blushWhite)
}
