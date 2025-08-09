import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authState: AuthenticationState
    @StateObject private var viewModel = DevotionViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: geometry.size.width > 600 ? 24 : 20) {
                    
                    // Day Tracker (Letters + Circles in Grid - proportional sizing)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: geometry.size.width / 80) {
                        ForEach(1...7, id: \.self) { day in
                            VStack(spacing: geometry.size.width / 80) {
                                Text(dayOfWeekLetter(day))
                                    .font(.system(size: geometry.size.width / 30 + 1, weight: .bold)) // Reduced by 4px
                                    .lineLimit(1)
                                
                                Circle()
                                    .fill(viewModel.completedDays.contains(day) ? Color.green : Color.gray)
                                    .frame(width: geometry.size.width / 15,
                                           height: geometry.size.width / 15)
                                    .accessibilityLabel("Day \(dayOfWeekLetter(day)): \(viewModel.completedDays.contains(day) ? "Completed" : "Not completed")")
                            }
                        }
                    }
                    .padding(.horizontal, geometry.size.width / 16)
                    .padding(.bottom, geometry.size.width / 40)
                    
                    // Date + Monthly Theme
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.formattedDate)
                            .font(.system(.largeTitle, design: .serif).weight(.bold))
                            .foregroundColor(.black)
                        
                        Text(viewModel.currentMonthTheme.uppercased())
                            .font(.system(size: 12, weight: .medium, design: .serif)) // Reduced by 2px
                            .foregroundColor(.gray.opacity(0.8)) // Darker gray
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 0)
                    
                    // Verse of the Day (Label)
                    Text("VERSE OF THE DAY")
                        .font(.system(size: 16, weight: .medium, design: .serif)) // Increased by 2px
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, geometry.size.width / 80)
                        .padding(.horizontal, 0)
                    
                    // Verse Card
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        
                        VStack(alignment: .leading, spacing: 12) { // Increased spacing
                            Text("\"\(viewModel.currentDevotion.verse)\"" ) // Added quotation marks
                                .font(.custom("Georgia", size: 30)) // Set to 30px
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                            
                            Text(viewModel.currentDevotion.reference)
                                .font(.system(size: 16, weight: .medium, design: .serif)) // Increased by 2px
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(20)
                    }
                    .frame(maxWidth: 600)
                    .frame(maxWidth: .infinity)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Verse: \(viewModel.currentDevotion.verse), \(viewModel.currentDevotion.reference)")
                    
                    // Task Label
                    Text("TASK")
                        .font(.system(size: 14, weight: .medium, design: .serif))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, geometry.size.width / 80)
                        .padding(.horizontal, 0)
                    
                    // Task Body
                    Text(viewModel.currentDevotion.task)
                        .font(.system(size: 18, weight: .regular, design: .serif))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: 600, alignment: .leading)
                        .frame(maxWidth: .infinity)
                        .accessibilityLabel("Task: \(viewModel.currentDevotion.task)")
                    
                    // Achieved Button
                    Button(action: {
                        viewModel.toggleTaskCompletion()
                    }) {
                        Text(viewModel.isTaskCompleted ? "Achieved" : "Achieved?")
                            .font(.system(.headline, design: .default, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: 400)
                            .padding()
                            .background(viewModel.isTaskCompleted ? Color.green : Color.black)
                            .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, geometry.size.width / 40)
                    .accessibilityLabel(viewModel.isTaskCompleted ? "Task Achieved" : "Mark Task as Achieved")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 0)
                .padding(.vertical, geometry.size.width > 600 ? 40 : 24)
            }
            .background(Color.white.ignoresSafeArea())
        }
    }
    
    // Helper function to map day number to letter
    private func dayOfWeekLetter(_ day: Int) -> String {
        let days = ["M", "T", "W", "T", "F", "S", "S"]
        return days[day - 1]
    }
}

#Preview("iPhone 14") {
    HomeView()
        .environmentObject(AuthenticationState())
}

#Preview("iPad Pro") {
    HomeView()
        .environmentObject(AuthenticationState())
}
