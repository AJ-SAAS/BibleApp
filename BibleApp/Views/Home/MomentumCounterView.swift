import SwiftUI

struct MomentumCounterView: View {
    let completedDays: Set<Int>
    let geometry: GeometryProxy
    
    var body: some View {
        let daysInMonth = Calendar.current.range(of: .day, in: .month, for: Date())?.count ?? 31 // Adjust for current month (August = 31)
        let rows = (daysInMonth + 6) / 7 // Approx 4-5 rows for 28-31 days
        let columns = 7
        
        VStack(spacing: 4) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 4) {
                    ForEach(0..<columns, id: \.self) { column in
                        let day = row * columns + column + 1
                        if day <= daysInMonth {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(completedDays.contains(day) ? Color.green : Color.gray.opacity(0.3)) // Dim grey for incomplete
                                .frame(width: 16, height: 16) // Small rounded squares
                                .accessibilityLabel("Day \(day): \(completedDays.contains(day) ? "Completed" : "Not completed")")
                        } else {
                            Color.clear
                                .frame(width: 16, height: 16)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: min(geometry.size.width * 0.9, 600))
    }
}

struct MomentumCounterView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            MomentumCounterView(completedDays: [1, 2, 3], geometry: geometry)
        }
    }
}
