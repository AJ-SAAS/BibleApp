import SwiftUI
import Foundation

class DevotionViewModel: ObservableObject {
    @Published var currentDevotion: Devotion = Devotion(
        month: 1,
        day: 1,
        verse: "Loading verse...",
        reference: "",
        task: "Loading task..."
    )
    @Published var tasks: [Task] = []
    @Published var completedDays: Set<Int> = []
    @Published var completedTaskCount: Int = 0
    @Published var isTaskCompleted: Bool = false
    @Published var currentMonthTheme: String = ""
    @Published var currentDate: Date = Date()
    @Published var showCompletionView: Bool = false // For pop-up

    private let userDefaults = UserDefaults.standard
    private let tasksKey = "ChecklistTasks"
    private let completedDaysKey = "CompletedDays"
    private let taskCountKey = "CompletedTaskCount"
    private let weekKey = "CurrentWeek"

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
            currentDevotion = Devotion(
                month: month,
                day: day,
                verse: "Trust in the Lord with all your heart...",
                reference: "Proverbs 3:5-6",
                task: "Reflect on God's guidance today."
            )
        }

        // Load tasks for the current day
        loadTasksForCurrentDay()
    }

    func toggleTaskCompletion(at index: Int? = nil) {
        if let index = index {
            tasks[index].isCompleted.toggle()
        } else {
            isTaskCompleted.toggle()
            tasks[0].isCompleted = isTaskCompleted // Fallback for legacy calls
        }
        updateCompletedTaskCount()
        saveProgress()
        checkAllTasksCompleted()
        // Trigger pop-up if all tasks are completed
        if completedTaskCount == tasks.count {
            showCompletionView = true
            print("DevotionViewModel: All tasks completed, showCompletionView set to true")
        } else {
            showCompletionView = false // Ensure pop-up doesn't show if tasks are incomplete
        }
    }

    private func updateCompletedTaskCount() {
        completedTaskCount = tasks.filter { $0.isCompleted }.count
        isTaskCompleted = completedTaskCount == tasks.count
        saveCompletedTaskCount()
    }

    private func checkAllTasksCompleted() {
        if completedTaskCount == tasks.count {
            let calendar = Calendar.current
            let day = calendar.component(.weekday, from: currentDate) // 1=Sunday, ..., 7=Saturday
            completedDays.insert(day)
            saveCompletedDays()
        }
    }

    private func saveProgress() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: currentDate)

        let progressData = tasks.map { ["title": $0.title, "isCompleted": $0.isCompleted] }
        userDefaults.set(progressData, forKey: "\(tasksKey)_\(dateString)")
        print("Progress saved locally for \(dateString)")
    }

    private func saveCompletedDays() {
        userDefaults.set(Array(completedDays), forKey: completedDaysKey)
        print("Completed days saved locally: \(completedDays)")
    }

    private func saveCompletedTaskCount() {
        userDefaults.set(completedTaskCount, forKey: taskCountKey)
        print("Completed task count saved locally: \(completedTaskCount)")
    }

    func loadCompletedDaysForWeek() {
        let calendar = Calendar.current
        let currentWeek = calendar.component(.weekOfYear, from: currentDate)
        let savedWeek = userDefaults.integer(forKey: weekKey)

        if savedWeek != currentWeek {
            completedDays = []
            tasks = [
                Task(title: "Prayed today?", isCompleted: false),
                Task(title: "Read today's Bible Verse?", isCompleted: false),
                Task(title: "Completed the task?", isCompleted: false)
            ]
            showCompletionView = false // Reset pop-up state
            saveCompletedDays()
            saveProgress()
            userDefaults.set(currentWeek, forKey: weekKey)
            print("Reset completed days and tasks for new week: \(currentWeek)")
        } else {
            if let savedDays = userDefaults.array(forKey: completedDaysKey) as? [Int] {
                completedDays = Set(savedDays)
            }
            loadTasksForCurrentDay()
        }
    }

    private func loadTasksForCurrentDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: currentDate)

        if let taskData = userDefaults.array(forKey: "\(tasksKey)_\(dateString)") as? [[String: Any]] {
            tasks = taskData.enumerated().map { index, task in
                Task(
                    title: task["title"] as? String ?? tasks[safe: index]?.title ?? "Task \(index + 1)",
                    isCompleted: task["isCompleted"] as? Bool ?? false
                )
            }
        } else {
            tasks = [
                Task(title: "Prayed today?", isCompleted: false),
                Task(title: "Read today's Bible Verse?", isCompleted: false),
                Task(title: "Completed the task?", isCompleted: false)
            ]
            showCompletionView = false // Reset pop-up state
            saveProgress()
        }
        updateCompletedTaskCount()
    }
}

// Safe array subscript to avoid index out of range
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
