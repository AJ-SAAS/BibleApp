import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authState: AuthenticationState
    @StateObject private var viewModel = DevotionViewModel()

    var body: some View {
        GeometryReader { geometry in
            let gridSpacing = geometry.size.width / 80
            let topPadding = geometry.size.width / 40
            let circleSize = geometry.size.width / 15
            let cardWidth = min(geometry.size.width * 0.9, 600)
            let horizontalPadding = (geometry.size.width - cardWidth) / 2
            let spacingVStack: CGFloat = geometry.size.width > 600 ? 24 : 20

            ScrollView {
                VStack(spacing: spacingVStack) {
                    // Day + Monthly Theme
                    VStack(alignment: .leading, spacing: 4) {
                        Text(dayOfWeekString())
                            .font(.system(size: 28, weight: .bold, design: .serif))
                            .foregroundColor(.black)
                        
                        Text("\(viewModel.currentMonthTheme)")
                            .font(.system(size: 14, weight: .medium, design: .serif))
                            .foregroundColor(.gray.opacity(0.8))
                    }
                    .frame(maxWidth: cardWidth, alignment: .leading)
                    
                    // Day Tracker
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: gridSpacing) {
                        ForEach(1...7, id: \.self) { day in
                            VStack(spacing: gridSpacing) {
                                Text(dayOfWeekLetter(day))
                                    .font(.system(size: geometry.size.width / 30 + 1, weight: .bold))
                                    .lineLimit(1)
                                
                                Circle()
                                    .fill(viewModel.completedDays.contains(day) ? Color.green : Color.gray)
                                    .frame(width: circleSize, height: circleSize)
                                    .accessibilityLabel("Day \(dayOfWeekLetter(day)): \(viewModel.completedDays.contains(day) ? "Completed" : "Not completed")")
                            }
                        }
                    }
                    .padding(.horizontal, horizontalPadding)
                    .padding(.vertical, topPadding)
                    
                    // Verse of the Day Label
                    Text("VERSE OF THE DAY")
                        .font(.custom("OpenSans-Medium", size: 16))
                        .foregroundColor(.gray)
                        .frame(maxWidth: cardWidth, alignment: .leading)
                    
                    // Verse Card
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("\"\(viewModel.currentDevotion.verse)\"")
                                .font(.custom("Georgia", size: 30))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                            
                            Text(viewModel.currentDevotion.reference)
                                .font(.system(size: 16, weight: .medium, design: .serif))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(20)
                    }
                    .frame(maxWidth: cardWidth)
                    
                    // Task Card
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(hex: "#fffcf5"),
                                        Color(hex: "#e6e2d5")
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("TASK OF THE DAY")
                                .font(.custom("OpenSans-Medium", size: 16))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(viewModel.currentDevotion.task)
                                .font(.system(size: 18, weight: .regular, design: .serif))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: cardWidth, alignment: .leading)
                        }
                        .padding(20)
                    }
                    .frame(maxWidth: cardWidth)
                    .padding(.top, topPadding)
                    
                    // To-Do List
                    VStack(alignment: .center, spacing: 12) {
                        Text("TODAY'S CHECKLIST")
                            .font(.custom("OpenSans-Medium", size: 16))
                            .foregroundColor(.gray)
                            .padding(.bottom, 4)
                            .frame(maxWidth: cardWidth, alignment: .leading)
                        
                        ForEach(viewModel.tasks.indices, id: \.self) { index in
                            let task = viewModel.tasks[index]
                            Button(action: {
                                viewModel.toggleTaskCompletion(at: index)
                            }) {
                                HStack {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(task.isCompleted ? .green : .gray)
                                        .font(.title3)
                                    Text(task.title)
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .regular, design: .serif))
                                    Spacer()
                                }
                                .frame(maxWidth: cardWidth, alignment: .leading)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .accessibilityLabel(task.title + (task.isCompleted ? ", completed" : ", not completed"))
                        }
                        
                        // Progress Bar (starts from left)
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: cardWidth, height: 8)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.yellow)
                                .frame(width: CGFloat(viewModel.completedTaskCount) / 3 * cardWidth, height: 8)
                                .animation(.easeInOut(duration: 0.2), value: viewModel.completedTaskCount)
                        }
                        .frame(width: cardWidth)
                        .padding(.top, 12)
                        .accessibilityLabel("Task progress: \(viewModel.completedTaskCount) out of 3 tasks completed")
                    }
                    .padding(.vertical, 12)
                    
                    // Achieved Button
                    Text(viewModel.isTaskCompleted && viewModel.completedTaskCount == 3 ? "All Tasks Completed!" : "Achieved \(viewModel.completedTaskCount)/3")
                        .font(.system(.headline, design: .default, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: 400)
                        .padding()
                        .background(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color(hex: "#b505c8"),
                                    Color(hex: "#5f0b89")
                                ]),
                                center: .center,
                                startRadius: geometry.size.width * 0.1,
                                endRadius: geometry.size.width * 0.5
                            )
                        )
                        .cornerRadius(8)
                        .padding(.top, 12)
                        .padding(.bottom, 20)
                        .animation(.easeInOut(duration: 0.2), value: viewModel.isTaskCompleted)
                        .animation(.easeInOut(duration: 0.2), value: viewModel.completedTaskCount)
                        .accessibilityLabel(viewModel.isTaskCompleted && viewModel.completedTaskCount == 3 ? "All tasks completed and logged" : "Achieved \(viewModel.completedTaskCount) of 3 tasks")
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, horizontalPadding)
                .padding(.top, geometry.size.width > 600 ? 40 : 24)
            }
            .scrollIndicators(.hidden)
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            viewModel.loadCompletedDaysForWeek()
        }
    }
    
    private func dayOfWeekLetter(_ day: Int) -> String {
        let days = ["M", "T", "W", "T", "F", "S", "S"]
        return days[day - 1]
    }
    
    private func dayOfWeekString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: viewModel.currentDate)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (r, g, b, a) = ((int >> 16) & 255, (int >> 8) & 255, int & 255, 255)
        case 8:
            (r, g, b, a) = ((int >> 24) & 255, (int >> 16) & 255, (int >> 8) & 255, int & 255)
        default:
            (r, g, b, a) = (0, 0, 0, 255)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview("iPhone 11") {
    HomeView()
        .environmentObject(AuthenticationState())
        .environmentObject(DevotionViewModel())
}

#Preview("iPad Pro") {
    HomeView()
        .environmentObject(AuthenticationState())
        .environmentObject(DevotionViewModel())
}
