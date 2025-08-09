import Foundation

class DevotionViewModel: ObservableObject {
    @Published var currentDevotion: Devotion
    @Published var isTaskCompleted: Bool = false
    @Published var completedDays: Set<Int> = [] // 1 = Monday, ..., 7 = Sunday
    
    var dayOfWeek: Int { // 1 = Monday, ..., 7 = Sunday
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: Date())
        return (weekday + 5) % 7 + 1 // Adjust to start week on Monday (BST convention)
    }
    
    var currentMonthTheme: String {
        let month = Calendar.current.component(.month, from: Date())
        return DevotionData.monthlyThemes[month] ?? "Unknown Theme"
    }
    
    var currentMonth: String {
        return currentMonthTheme.components(separatedBy: " – ").first ?? ""
    }
    
    var currentTheme: String {
        return currentMonthTheme.components(separatedBy: " – ").dropFirst().joined(separator: " – ")
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy" // e.g., "Saturday, August 9, 2025"
        return formatter.string(from: Date())
    }
    
    init() {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        let currentDay = calendar.component(.day, from: Date())
        
        // Find the devotion for the current month and day
        if let devotion = DevotionData.devotions.first(where: { $0.month == currentMonth && $0.day == currentDay }) {
            self.currentDevotion = devotion
        } else {
            // Fallback devotion
            self.currentDevotion = Devotion(
                month: currentMonth,
                day: currentDay,
                verse: "Trust in the Lord with all your heart and lean not on your own understanding.",
                reference: "Proverbs 3:5-6",
                task: "Write down 3 areas where you're struggling to trust God."
            )
        }
        
        // Load completed days from UserDefaults
        if let savedDays = UserDefaults.standard.array(forKey: "completedDays") as? [Int] {
            completedDays = Set(savedDays)
        }
        isTaskCompleted = completedDays.contains(dayOfWeek)
    }
    
    func toggleTaskCompletion() {
        isTaskCompleted.toggle()
        if isTaskCompleted {
            completedDays.insert(dayOfWeek)
        } else {
            completedDays.remove(dayOfWeek)
        }
        saveCompletedDays()
        print("DevotionViewModel: Task completion toggled to \(isTaskCompleted), completedDays: \(completedDays)")
    }
    
    private func saveCompletedDays() {
        UserDefaults.standard.set(Array(completedDays), forKey: "completedDays")
    }
}
