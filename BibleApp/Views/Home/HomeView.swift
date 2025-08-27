import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authState: AuthenticationState
    @StateObject private var viewModel = DevotionViewModel()

    var body: some View {
        GeometryReader { geometry in
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
                    
                    // Verse of the Day Label
                    Text("VERSE OF THE DAY")
                        .font(.system(size: 16, weight: .medium, design: .serif))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 16)
                    
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
                        
                        ForEach(viewModel.tasks.indices, id: \.self) { index in
                            Button(action: {
                                viewModel.toggleTaskCompletion(at: index)
                            }) {
                                HStack {
                                    Image(systemName: viewModel.tasks[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(viewModel.tasks[index].isCompleted ? .green : .gray)
                                        .font(.title3)
                                    Text(viewModel.tasks[index].title)
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .regular, design: .serif))
                                    Spacer()
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .accessibilityLabel(viewModel.tasks[index].title + (viewModel.tasks[index].isCompleted ? ", completed" : ", not completed"))
                        }
                    }
                    .padding(.vertical, 12)
                    
                    // Achieved Button (Display-Only)
                    Text(viewModel.isTaskCompleted && viewModel.completedTaskCount == 3 ? "All Tasks Completed!" : "Achieved \(viewModel.completedTaskCount)/3")
                        .font(.system(.headline, design: .default, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: 400)
                        .padding()
                        .background(viewModel.isTaskCompleted ? Color.green : (viewModel.completedTaskCount > 0 ? Color.black : Color.gray))
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 12)
                        .padding(.bottom, 60)
                        .animation(.easeInOut(duration: 0.2), value: viewModel.isTaskCompleted)
                        .animation(.easeInOut(duration: 0.2), value: viewModel.completedTaskCount)
                        .accessibilityLabel(viewModel.isTaskCompleted && viewModel.completedTaskCount == 3 ? "All tasks completed and logged" : "Achieved \(viewModel.completedTaskCount) of 3 tasks")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
                .padding(.top, geometry.size.width > 600 ? 40 : 24)
            }
            .scrollIndicators(.hidden)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 50)
            }
            .background(Color.white)
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

#Preview("iPhone 14") {
    HomeView()
        .environmentObject(AuthenticationState())
        .environmentObject(DevotionViewModel())
}

#Preview("iPad Pro") {
    HomeView()
        .environmentObject(AuthenticationState())
        .environmentObject(DevotionViewModel())
}
