import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authState: AuthenticationState
    @StateObject private var viewModel = DevotionViewModel()
    
    struct TodoTask {
        var title: String
        var isCompleted: Bool = false
    }

    @State private var todoTasks: [TodoTask] = [
        TodoTask(title: "Morning Prayer"),
        TodoTask(title: "Read today's Bible Verse"),
        TodoTask(title: "Complete today's task")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: geometry.size.width > 600 ? 24 : 20) {
                        // Day + Monthly Theme
                        VStack(alignment: .leading, spacing: 4) {
                            Text(dayOfWeekString())
                                .font(.system(size: 28, weight: .bold, design: .serif))
                                .foregroundColor(.black)
                            
                            Text("\(viewModel.currentMonthTheme)")
                                .font(.system(size: 14, weight: .medium, design: .serif))
                                .foregroundColor(.gray.opacity(0.8))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Day Tracker
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: geometry.size.width / 80) {
                            ForEach(1...7, id: \.self) { day in
                                VStack(spacing: geometry.size.width / 80) {
                                    Text(dayOfWeekLetter(day))
                                        .font(.system(size: geometry.size.width / 30 + 1, weight: .bold))
                                        .lineLimit(1)
                                    
                                    Circle()
                                        .fill(viewModel.completedDays.contains(day) ? Color.green : Color.gray)
                                        .frame(width: geometry.size.width / 15, height: geometry.size.width / 15)
                                        .accessibilityLabel("Day \(dayOfWeekLetter(day)): \(viewModel.completedDays.contains(day) ? "Completed" : "Not completed")")
                                }
                            }
                        }
                        .padding(.horizontal, geometry.size.width / 16)
                        .padding(.vertical, geometry.size.width / 40)
                        
                        // Verse of the Day Label (Reduced top padding)
                        Text("VERSE OF THE DAY")
                            .font(.system(size: 16, weight: .medium, design: .serif))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 16) // Reduced from 32 to 16
                        
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
                        
                        // Task Body
                        Text(viewModel.currentDevotion.task)
                            .font(.system(size: 18, weight: .regular, design: .serif))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: 600, alignment: .leading)
                            .frame(maxWidth: .infinity)
                            .accessibilityLabel("Task: \(viewModel.currentDevotion.task)")
                        
                        // To-Do List
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Today's Checklist")
                                .font(.system(size: 16, weight: .semibold, design: .serif))
                                .foregroundColor(.black)
                                .padding(.bottom, 4)
                            
                            ForEach(todoTasks.indices, id: \.self) { index in
                                Button(action: {
                                    todoTasks[index].isCompleted.toggle()
                                }) {
                                    HStack {
                                        Image(systemName: todoTasks[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(todoTasks[index].isCompleted ? .green : .gray)
                                            .font(.title3)
                                        Text(todoTasks[index].title)
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .regular, design: .serif))
                                        Spacer()
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                .accessibilityLabel(todoTasks[index].title + (todoTasks[index].isCompleted ? ", completed" : ", not completed"))
                            }
                        }
                        .padding(.vertical, 12)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 0)
                    .padding(.vertical, geometry.size.width > 600 ? 40 : 24)
                }
                .scrollIndicators(.hidden)
                .frame(height: geometry.size.height - 70)
                
                // Achieved Button pinned at bottom
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
                .padding(.horizontal, 16)
                .padding(.bottom, geometry.safeAreaInsets.bottom)
                .accessibilityLabel(viewModel.isTaskCompleted ? "Task Achieved" : "Mark Task as Achieved")
                .background(Color.white.shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: -2))
            }
            .background(Color.white.ignoresSafeArea())
        }
    }
    
    // Helper function to map day number to letter
    private func dayOfWeekLetter(_ day: Int) -> String {
        let days = ["M", "T", "W", "T", "F", "S", "S"]
        return days[day - 1]
    }
    
    // Helper to get full day name for today’s date
    private func dayOfWeekString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
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
