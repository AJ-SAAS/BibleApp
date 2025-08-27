import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class DevotionViewModel: ObservableObject {
    @Published var currentDevotion: Devotion = Devotion(month: 1, day: 1, verse: "Loading verse...", reference: "", task: "Loading task...")
    @Published var tasks: [Task] = []
    @Published var completedDays: Set<Int> = []
    @Published var completedTaskCount: Int = 0
    @Published var isTaskCompleted: Bool = false
    @Published var currentMonthTheme: String = ""
    private let db = Firestore.firestore()
    @Published var currentDate: Date = Date() // Made @Published for HomeView access
    
    struct Task: Identifiable {
        let id = UUID()
        let title: String
        var isCompleted: Bool
    }
    
    init() {
        fetchDailyContent()
        loadCompletedDaysForWeek()
    }
    
    func fetchDailyContent() {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        
        // Set monthly theme from DevotionData
        currentMonthTheme = DevotionData.monthlyThemes[month] ?? "Faith"
        
        // Fetch devotion for current month and day
        if let devotion = DevotionData.devotions.first(where: { $0.month == month && $0.day == day }) {
            currentDevotion = devotion
        } else {
            // Fallback if no devotion found
            currentDevotion = Devotion(
                month: month,
                day: day,
                verse: "Trust in the Lord with all your heart...",
                reference: "Proverbs 3:5-6",
                task: "Reflect on God's guidance today."
            )
        }
        
        // Set three specific tasks
        tasks = [
            Task(title: "Prayed today?", isCompleted: false),
            Task(title: "Read today's Bible Verse?", isCompleted: false),
            Task(title: "Completed the task?", isCompleted: false)
        ]
        updateCompletedTaskCount()
    }
    
    func toggleTaskCompletion(at index: Int? = nil) {
        if let index = index {
            tasks[index].isCompleted.toggle()
        } else {
            isTaskCompleted.toggle()
            tasks[0].isCompleted = isTaskCompleted // Fallback for legacy calls (not used)
        }
        updateCompletedTaskCount()
        saveProgress()
        checkAllTasksCompleted()
    }
    
    private func updateCompletedTaskCount() {
        completedTaskCount = tasks.filter { $0.isCompleted }.count
        isTaskCompleted = completedTaskCount == tasks.count
    }
    
    private func checkAllTasksCompleted() {
        if completedTaskCount == tasks.count {
            let calendar = Calendar.current
            let day = calendar.component(.weekday, from: currentDate) // 1=Sunday, 2=Monday, ..., 7=Saturday
            completedDays.insert(day)
            saveCompletedDaysToFirestore()
        }
    }
    
    private func saveProgress() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: currentDate)
        
        let progressData = tasks.map { ["title": $0.title, "isCompleted": $0.isCompleted] }
        db.collection("users").document(userId).collection("dailyProgress").document(dateString).setData([
            "tasks": progressData,
            "date": Timestamp(date: currentDate)
        ]) { error in
            if let error = error {
                print("Error saving progress: \(error.localizedDescription)")
            } else {
                print("Progress saved for \(dateString)")
            }
        }
    }
    
    private func saveCompletedDaysToFirestore() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let monthString = dateFormatter.string(from: currentDate)
        
        db.collection("users").document(userId).collection("completedDays").document(monthString).setData([
            "days": Array(completedDays),
            "month": Timestamp(date: currentDate)
        ]) { error in
            if let error = error {
                print("Error saving completed days: \(error.localizedDescription)")
            } else {
                print("Completed days saved for \(monthString)")
            }
        }
    }
    
    func loadCompletedDaysForWeek() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let monthString = dateFormatter.string(from: currentDate)
        
        db.collection("users").document(userId).collection("completedDays").document(monthString).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching completed days: \(error.localizedDescription)")
            } else if let data = snapshot?.data(), let days = data["days"] as? [Int] {
                self.completedDays = Set(days)
            }
            // Fetch tasks and update theme/devotion
            self.fetchTasksForCurrentDay()
            self.fetchDailyContent() // Ensure theme/devotion are updated after fetch
        }
    }
    
    private func fetchTasksForCurrentDay() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: currentDate)
        
        db.collection("users").document(userId).collection("dailyProgress").document(dateString).getDocument { snapshot, error in
            if let data = snapshot?.data(), let taskData = data["tasks"] as? [[String: Any]] {
                self.tasks = taskData.enumerated().map { index, task in
                    Task(title: task["title"] as? String ?? self.tasks[safe: index]?.title ?? "Task \(index + 1)",
                         isCompleted: task["isCompleted"] as? Bool ?? false)
                }
                self.updateCompletedTaskCount()
                self.checkAllTasksCompleted()
            }
        }
    }
}

// Safe array subscript to avoid index out of range
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
