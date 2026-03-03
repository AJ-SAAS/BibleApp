import SwiftUI

// MARK: - Quiz Models

struct QuizQuestion {
    let question: String
    let answers: [String]
    let correctIndex: Int
    let category: String
}

struct QuizResult {
    let date: String
    let score: Int
    let total: Int
}

// MARK: - Question Bank (120 questions)

let allQuizQuestions: [QuizQuestion] = [

    // MARK: Biblical Women (20)
    QuizQuestion(question: "Which woman hid two Israelite spies on her rooftop?", answers: ["Deborah", "Rahab", "Ruth", "Miriam"], correctIndex: 1, category: "Biblical Women"),
    QuizQuestion(question: "Who was the first woman to witness Jesus' resurrection?", answers: ["Mary, mother of Jesus", "Martha", "Mary Magdalene", "Salome"], correctIndex: 2, category: "Biblical Women"),
    QuizQuestion(question: "Deborah served Israel in which dual role?", answers: ["Queen and priestess", "Prophetess and judge", "Teacher and midwife", "Scribe and healer"], correctIndex: 1, category: "Biblical Women"),
    QuizQuestion(question: "What did Hannah desperately pray for at the temple?", answers: ["Wisdom", "Healing", "A child", "Forgiveness"], correctIndex: 2, category: "Biblical Women"),
    QuizQuestion(question: "Ruth said 'Where you go I will go' to whom?", answers: ["Boaz", "Naomi", "Elimelech", "Orpah"], correctIndex: 1, category: "Biblical Women"),
    QuizQuestion(question: "Esther was queen in which kingdom?", answers: ["Egypt", "Babylon", "Persia", "Assyria"], correctIndex: 2, category: "Biblical Women"),
    QuizQuestion(question: "Who led the women of Israel in singing after crossing the Red Sea?", answers: ["Deborah", "Hannah", "Miriam", "Rahab"], correctIndex: 2, category: "Biblical Women"),
    QuizQuestion(question: "Priscilla taught the Gospel alongside her husband whose name was?", answers: ["Timothy", "Aquila", "Silas", "Barnabas"], correctIndex: 1, category: "Biblical Women"),
    QuizQuestion(question: "Lydia, a seller of purple cloth, was converted in which city?", answers: ["Athens", "Corinth", "Philippi", "Rome"], correctIndex: 2, category: "Biblical Women"),
    QuizQuestion(question: "Which prophetess recognised baby Jesus in the temple?", answers: ["Elizabeth", "Phoebe", "Anna", "Joanna"], correctIndex: 2, category: "Biblical Women"),
    QuizQuestion(question: "The Proverbs 31 woman is described as being worth more than what?", answers: ["Gold", "Rubies", "Silver", "Sapphires"], correctIndex: 1, category: "Biblical Women"),
    QuizQuestion(question: "Who was Elizabeth's famous son?", answers: ["Jesus", "Paul", "John the Baptist", "Stephen"], correctIndex: 2, category: "Biblical Women"),
    QuizQuestion(question: "Abigail brought David food to prevent him from doing what?", answers: ["Fleeing the country", "Killing her household in anger", "Attacking Jerusalem", "Breaking the law of Moses"], correctIndex: 1, category: "Biblical Women"),
    QuizQuestion(question: "Mary of Bethany poured expensive perfume on Jesus' feet. What was it?", answers: ["Myrrh", "Frankincense", "Spikenard", "Cassia"], correctIndex: 2, category: "Biblical Women"),
    QuizQuestion(question: "Which woman became queen to save her people from destruction?", answers: ["Miriam", "Deborah", "Esther", "Ruth"], correctIndex: 2, category: "Biblical Women"),
    QuizQuestion(question: "Huldah was a prophetess who gave God's word to which king?", answers: ["David", "Solomon", "Josiah", "Hezekiah"], correctIndex: 2, category: "Biblical Women"),
    QuizQuestion(question: "Which woman was known for her loyalty to her mother-in-law after her husband died?", answers: ["Orpah", "Ruth", "Rahab", "Abigail"], correctIndex: 1, category: "Biblical Women"),
    QuizQuestion(question: "Jael defeated which enemy commander by driving a tent peg through his head?", answers: ["Goliath", "Sisera", "Haman", "Pharaoh"], correctIndex: 1, category: "Biblical Women"),
    QuizQuestion(question: "Which woman supported Jesus' ministry financially and is mentioned in Luke 8?", answers: ["Phoebe", "Joanna", "Lydia", "Priscilla"], correctIndex: 1, category: "Biblical Women"),
    QuizQuestion(question: "Naomi changed her name to Mara, which means what?", answers: ["Blessed", "Bitter", "Empty", "Forgotten"], correctIndex: 1, category: "Biblical Women"),

    // MARK: Motherhood in the Bible (15)
    QuizQuestion(question: "How many sons did Hannah dedicate to God's service?", answers: ["Two", "One", "Three", "Four"], correctIndex: 1, category: "Motherhood"),
    QuizQuestion(question: "Who placed baby Moses in a basket on the Nile?", answers: ["Miriam", "Pharaoh's daughter", "His mother Jochebed", "His grandmother"], correctIndex: 2, category: "Motherhood"),
    QuizQuestion(question: "Which mother interceded with Solomon to spare her baby's life?", answers: ["Bathsheba", "The true mother of the child", "Jezebel", "Abigail"], correctIndex: 1, category: "Motherhood"),
    QuizQuestion(question: "Mary treasured the things said about Jesus and kept them where?", answers: ["In a scroll", "In her heart", "In prayer", "In a letter"], correctIndex: 1, category: "Motherhood"),
    QuizQuestion(question: "Eunice and Lois are remembered as the faithful mother and grandmother of whom?", answers: ["Titus", "Timothy", "Mark", "Luke"], correctIndex: 1, category: "Motherhood"),
    QuizQuestion(question: "Which mother dressed her son in goat skin to receive Isaac's blessing?", answers: ["Rachel", "Leah", "Rebekah", "Sarah"], correctIndex: 2, category: "Motherhood"),
    QuizQuestion(question: "Who was the mother of Isaac?", answers: ["Hagar", "Rebekah", "Rachel", "Sarah"], correctIndex: 3, category: "Motherhood"),
    QuizQuestion(question: "What did Lois pass on to her grandson Timothy?", answers: ["Wealth", "A priestly role", "Sincere faith", "The Torah scrolls"], correctIndex: 2, category: "Motherhood"),
    QuizQuestion(question: "Who was the mother of John the Baptist?", answers: ["Mary", "Anna", "Elizabeth", "Salome"], correctIndex: 2, category: "Motherhood"),
    QuizQuestion(question: "Rachel wept for her children in Jeremiah's prophecy. What was she weeping for?", answers: ["Their sin", "Their exile", "Their poverty", "Their sickness"], correctIndex: 1, category: "Motherhood"),
    QuizQuestion(question: "Which mother of twins struggled during her pregnancy and asked God why?", answers: ["Sarah", "Rachel", "Rebekah", "Leah"], correctIndex: 2, category: "Motherhood"),
    QuizQuestion(question: "Who nursed her own son Moses after he was found by Pharaoh's daughter?", answers: ["Miriam", "Jochebed", "Zipporah", "Pharaoh's daughter's servant"], correctIndex: 1, category: "Motherhood"),
    QuizQuestion(question: "Which mother is called 'the mother of all living'?", answers: ["Sarah", "Eve", "Mary", "Ruth"], correctIndex: 1, category: "Motherhood"),
    QuizQuestion(question: "Proverbs 31:28 says her children do what when they see her?", answers: ["Obey her", "Praise her", "Rise up and call her blessed", "Follow her ways"], correctIndex: 2, category: "Motherhood"),
    QuizQuestion(question: "Which woman cried out to God saying 'give me children or I will die'?", answers: ["Hannah", "Sarah", "Rachel", "Leah"], correctIndex: 2, category: "Motherhood"),

    // MARK: Psalms & Proverbs (15)
    QuizQuestion(question: "Complete: 'The Lord is my shepherd, I shall not...'", answers: ["Fear", "Fall", "Want", "Fail"], correctIndex: 2, category: "Psalms & Proverbs"),
    QuizQuestion(question: "Which Psalm begins 'God is our refuge and strength'?", answers: ["Psalm 23", "Psalm 46", "Psalm 91", "Psalm 121"], correctIndex: 1, category: "Psalms & Proverbs"),
    QuizQuestion(question: "Proverbs 3:5 says to trust in the Lord and lean not on your own...", answers: ["Strength", "Plans", "Understanding", "Wisdom"], correctIndex: 2, category: "Psalms & Proverbs"),
    QuizQuestion(question: "Psalm 121 says 'My help comes from...'", answers: ["The Lord", "My family", "The temple", "The mountains"], correctIndex: 0, category: "Psalms & Proverbs"),
    QuizQuestion(question: "Which chapter of Proverbs is known as 'the virtuous woman'?", answers: ["Chapter 8", "Chapter 22", "Chapter 31", "Chapter 16"], correctIndex: 2, category: "Psalms & Proverbs"),
    QuizQuestion(question: "'Children are a heritage from the Lord.' Which Psalm says this?", answers: ["Psalm 127", "Psalm 100", "Psalm 139", "Psalm 23"], correctIndex: 0, category: "Psalms & Proverbs"),
    QuizQuestion(question: "Proverbs 22:6 says 'Train up a child in the way he should go, and when he is old...'", answers: ["He will prosper", "He will not depart from it", "He will bless you", "He will be wise"], correctIndex: 1, category: "Psalms & Proverbs"),
    QuizQuestion(question: "'Be still and know that I am God' is from which Psalm?", answers: ["Psalm 23", "Psalm 46", "Psalm 91", "Psalm 139"], correctIndex: 1, category: "Psalms & Proverbs"),
    QuizQuestion(question: "Psalm 139 says God knit us together where?", answers: ["In the earth", "In our mother's womb", "In the heavens", "In the garden"], correctIndex: 1, category: "Psalms & Proverbs"),
    QuizQuestion(question: "Which Psalm is known as the 'Shepherd Psalm'?", answers: ["Psalm 1", "Psalm 19", "Psalm 23", "Psalm 91"], correctIndex: 2, category: "Psalms & Proverbs"),
    QuizQuestion(question: "Proverbs 31:25 says she is clothed with what two things?", answers: ["Grace and mercy", "Strength and dignity", "Faith and hope", "Wisdom and love"], correctIndex: 1, category: "Psalms & Proverbs"),
    QuizQuestion(question: "Psalm 91:11 says God will command his angels to do what for you?", answers: ["Guide your steps", "Guard you in all your ways", "Light your path", "Strengthen your heart"], correctIndex: 1, category: "Psalms & Proverbs"),
    QuizQuestion(question: "Complete: 'This is the day the Lord has made; let us...'", answers: ["Praise and worship", "Pray and fast", "Rejoice and be glad", "Rest and be still"], correctIndex: 2, category: "Psalms & Proverbs"),
    QuizQuestion(question: "Which Psalm begins with 'How lovely is your dwelling place, Lord Almighty'?", answers: ["Psalm 63", "Psalm 84", "Psalm 100", "Psalm 122"], correctIndex: 1, category: "Psalms & Proverbs"),
    QuizQuestion(question: "Proverbs 17:22 says 'A cheerful heart is good...'", answers: ["For the soul", "Like medicine", "For all things", "For your children"], correctIndex: 1, category: "Psalms & Proverbs"),

    // MARK: New Testament (20)
    QuizQuestion(question: "How many disciples did Jesus have?", answers: ["10", "11", "12", "14"], correctIndex: 2, category: "New Testament"),
    QuizQuestion(question: "Where was Jesus born?", answers: ["Nazareth", "Jerusalem", "Bethlehem", "Capernaum"], correctIndex: 2, category: "New Testament"),
    QuizQuestion(question: "What was the first miracle Jesus performed?", answers: ["Healing a blind man", "Feeding 5000 people", "Turning water into wine", "Raising Lazarus"], correctIndex: 2, category: "New Testament"),
    QuizQuestion(question: "Which disciple denied Jesus three times?", answers: ["John", "James", "Peter", "Andrew"], correctIndex: 2, category: "New Testament"),
    QuizQuestion(question: "How many days was Lazarus in the tomb before Jesus raised him?", answers: ["Two", "Three", "Four", "Seven"], correctIndex: 2, category: "New Testament"),
    QuizQuestion(question: "Which book records the birth of the early church?", answers: ["Romans", "Acts", "Galatians", "Hebrews"], correctIndex: 1, category: "New Testament"),
    QuizQuestion(question: "What does the name 'Emmanuel' mean?", answers: ["God saves", "God with us", "God is Lord", "God is light"], correctIndex: 1, category: "New Testament"),
    QuizQuestion(question: "Jesus fed 5,000 people with how many loaves and fish?", answers: ["3 loaves 2 fish", "7 loaves 3 fish", "5 loaves 2 fish", "10 loaves 5 fish"], correctIndex: 2, category: "New Testament"),
    QuizQuestion(question: "Who baptised Jesus?", answers: ["Peter", "John the Baptist", "Elijah", "A temple priest"], correctIndex: 1, category: "New Testament"),
    QuizQuestion(question: "The Sermon on the Mount is recorded in which book?", answers: ["Mark", "Luke", "John", "Matthew"], correctIndex: 3, category: "New Testament"),
    QuizQuestion(question: "How many days did Jesus fast in the wilderness?", answers: ["20", "30", "40", "50"], correctIndex: 2, category: "New Testament"),
    QuizQuestion(question: "Which disciple was known as 'the one Jesus loved'?", answers: ["Peter", "James", "John", "Andrew"], correctIndex: 2, category: "New Testament"),
    QuizQuestion(question: "What was Paul's name before his conversion?", answers: ["Barnabas", "Silas", "Saul", "Titus"], correctIndex: 2, category: "New Testament"),
    QuizQuestion(question: "On which day did Jesus rise from the dead?", answers: ["The first day of the week", "The Sabbath", "The third Passover day", "The day of Pentecost"], correctIndex: 0, category: "New Testament"),
    QuizQuestion(question: "The Holy Spirit descended on the disciples on which day?", answers: ["Easter Sunday", "Ascension Day", "Pentecost", "The Sabbath"], correctIndex: 2, category: "New Testament"),
    QuizQuestion(question: "Which parable tells of a father running to welcome his returning son?", answers: ["The Good Samaritan", "The Prodigal Son", "The Lost Sheep", "The Ten Talents"], correctIndex: 1, category: "New Testament"),
    QuizQuestion(question: "Jesus said 'I am the way, the truth and the life' in which Gospel?", answers: ["Matthew", "Mark", "Luke", "John"], correctIndex: 3, category: "New Testament"),
    QuizQuestion(question: "Which city was Paul travelling to when he was converted?", answers: ["Jerusalem", "Corinth", "Damascus", "Antioch"], correctIndex: 2, category: "New Testament"),
    QuizQuestion(question: "How many Gospels are in the New Testament?", answers: ["3", "4", "5", "6"], correctIndex: 1, category: "New Testament"),
    QuizQuestion(question: "What gift did the wise men NOT bring to Jesus?", answers: ["Gold", "Frankincense", "Myrrh", "Silver"], correctIndex: 3, category: "New Testament"),

    // MARK: Old Testament (20)
    QuizQuestion(question: "How many days did it rain during Noah's flood?", answers: ["20 days", "30 days", "40 days", "50 days"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "Who was sold into slavery by his brothers?", answers: ["Benjamin", "Reuben", "Joseph", "Simeon"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "Which prophet was swallowed by a great fish?", answers: ["Elijah", "Jonah", "Isaiah", "Hosea"], correctIndex: 1, category: "Old Testament"),
    QuizQuestion(question: "David defeated Goliath with what weapon?", answers: ["A sword", "A spear", "A sling and stone", "An arrow"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "How many commandments did God give Moses?", answers: ["5", "7", "10", "12"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "Which river did the Israelites cross to enter the Promised Land?", answers: ["Nile", "Euphrates", "Jordan", "Tigris"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "Who was the first king of Israel?", answers: ["David", "Solomon", "Saul", "Samuel"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "The burning bush appeared to which prophet?", answers: ["Elijah", "Moses", "Isaiah", "Ezekiel"], correctIndex: 1, category: "Old Testament"),
    QuizQuestion(question: "In which garden did Adam and Eve live?", answers: ["Garden of Gethsemane", "Garden of Eden", "Garden of Olives", "Garden of God"], correctIndex: 1, category: "Old Testament"),
    QuizQuestion(question: "What did God use to guide the Israelites at night in the wilderness?", answers: ["A bright star", "An angel", "A pillar of fire", "Lightning"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "How many plagues did God send upon Egypt?", answers: ["7", "8", "10", "12"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "What animal spoke to Balaam?", answers: ["A serpent", "A dove", "A donkey", "A lion"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "Solomon asked God for which gift?", answers: ["Wealth", "Long life", "Wisdom", "Power over enemies"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "Elijah was taken to heaven in what?", answers: ["A great wind", "A chariot of fire", "A cloud", "An earthquake"], correctIndex: 1, category: "Old Testament"),
    QuizQuestion(question: "Which city's walls fell down after the Israelites marched around it?", answers: ["Jerusalem", "Bethlehem", "Jericho", "Samaria"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "God created the world in how many days?", answers: ["5", "6", "7", "8"], correctIndex: 1, category: "Old Testament"),
    QuizQuestion(question: "What was the sign of God's covenant with Noah?", answers: ["A dove", "A rainbow", "A star", "A burning bush"], correctIndex: 1, category: "Old Testament"),
    QuizQuestion(question: "Daniel was thrown into what because he refused to stop praying?", answers: ["A burning furnace", "A pit", "A lion's den", "A prison"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "Which book of the Bible tells the story of creation?", answers: ["Exodus", "Leviticus", "Genesis", "Numbers"], correctIndex: 2, category: "Old Testament"),
    QuizQuestion(question: "Samson's strength came from what?", answers: ["His armour", "His prayers", "His long hair", "His staff"], correctIndex: 2, category: "Old Testament"),

    // MARK: Faith & Encouragement (15)
    QuizQuestion(question: "'For God so loved the world' is found in which verse?", answers: ["John 1:1", "John 3:16", "Romans 8:28", "Jeremiah 29:11"], correctIndex: 1, category: "Faith"),
    QuizQuestion(question: "Jeremiah 29:11 says God has plans to give us a future and a...", answers: ["Purpose", "Hope", "Crown", "Promise"], correctIndex: 1, category: "Faith"),
    QuizQuestion(question: "What fruit of the Spirit is listed first in Galatians 5:22?", answers: ["Joy", "Peace", "Love", "Patience"], correctIndex: 2, category: "Faith"),
    QuizQuestion(question: "Romans 8:28 says all things work together for good to those who...", answers: ["Pray daily", "Love God", "Obey the law", "Give generously"], correctIndex: 1, category: "Faith"),
    QuizQuestion(question: "How many fruits of the Spirit are listed in Galatians 5?", answers: ["7", "8", "9", "10"], correctIndex: 2, category: "Faith"),
    QuizQuestion(question: "Isaiah 40:31 says those who wait on the Lord will renew their...", answers: ["Faith", "Hearts", "Strength", "Minds"], correctIndex: 2, category: "Faith"),
    QuizQuestion(question: "What is the greatest commandment according to Jesus?", answers: ["Keep the Sabbath", "Love the Lord your God with all your heart", "Do not murder", "Honour your parents"], correctIndex: 1, category: "Faith"),
    QuizQuestion(question: "Philippians 4:6 tells us not to be anxious but to present requests through...", answers: ["Fasting", "Sacrifice", "Prayer and petition", "Works of service"], correctIndex: 2, category: "Faith"),
    QuizQuestion(question: "Which chapter of 1 Corinthians is known as the 'love chapter'?", answers: ["Chapter 10", "Chapter 11", "Chapter 13", "Chapter 15"], correctIndex: 2, category: "Faith"),
    QuizQuestion(question: "Complete: 'I can do all things through Christ who...'", answers: ["Loves me", "Saves me", "Strengthens me", "Guides me"], correctIndex: 2, category: "Faith"),
    QuizQuestion(question: "Matthew 6:33 says 'seek first the kingdom of God and his...'", answers: ["Mercy", "Glory", "Righteousness", "Peace"], correctIndex: 2, category: "Faith"),
    QuizQuestion(question: "Faith without works is described as what in James 2?", answers: ["Incomplete", "Weak", "Dead", "Useless"], correctIndex: 2, category: "Faith"),
    QuizQuestion(question: "Hebrews 11:1 defines faith as the substance of things hoped for and the evidence of things...", answers: ["Prayed for", "Not seen", "Not yet done", "Yet to come"], correctIndex: 1, category: "Faith"),
    QuizQuestion(question: "1 John 4:8 says 'God is...'", answers: ["Holy", "Just", "Love", "Light"], correctIndex: 2, category: "Faith"),
    QuizQuestion(question: "Complete: 'Be strong and courageous. Do not be afraid... for the Lord your God...'", answers: ["Is watching you", "Will reward you", "Goes with you", "Fights for you"], correctIndex: 2, category: "Faith"),

    // MARK: Bible Knowledge (15)
    QuizQuestion(question: "How many books are in the Old Testament?", answers: ["27", "33", "39", "46"], correctIndex: 2, category: "Bible Knowledge"),
    QuizQuestion(question: "How many books are in the New Testament?", answers: ["22", "25", "27", "30"], correctIndex: 2, category: "Bible Knowledge"),
    QuizQuestion(question: "Which is the shortest book in the New Testament?", answers: ["Philemon", "2 John", "3 John", "Jude"], correctIndex: 2, category: "Bible Knowledge"),
    QuizQuestion(question: "Which book of the Bible has the most chapters?", answers: ["Genesis", "Isaiah", "Jeremiah", "Psalms"], correctIndex: 3, category: "Bible Knowledge"),
    QuizQuestion(question: "The book of Ruth contains how many chapters?", answers: ["2", "3", "4", "5"], correctIndex: 2, category: "Bible Knowledge"),
    QuizQuestion(question: "Which book comes after Matthew in the New Testament?", answers: ["Luke", "John", "Mark", "Acts"], correctIndex: 2, category: "Bible Knowledge"),
    QuizQuestion(question: "Esther is one of only two books not to mention God. What is the other?", answers: ["Ruth", "Song of Solomon", "Lamentations", "Obadiah"], correctIndex: 1, category: "Bible Knowledge"),
    QuizQuestion(question: "Which Gospel was written by a doctor?", answers: ["Matthew", "Mark", "Luke", "John"], correctIndex: 2, category: "Bible Knowledge"),
    QuizQuestion(question: "The first five books of the Bible are collectively called what?", answers: ["The Gospels", "The Torah", "The Epistles", "The Prophets"], correctIndex: 1, category: "Bible Knowledge"),
    QuizQuestion(question: "Which is the longest book in the Bible by chapter count?", answers: ["Genesis", "Isaiah", "Psalms", "Jeremiah"], correctIndex: 2, category: "Bible Knowledge"),
    QuizQuestion(question: "Who wrote most of the New Testament letters?", answers: ["Peter", "John", "Paul", "James"], correctIndex: 2, category: "Bible Knowledge"),
    QuizQuestion(question: "The book of Revelation was written by whom?", answers: ["Paul", "Peter", "John", "Luke"], correctIndex: 2, category: "Bible Knowledge"),
    QuizQuestion(question: "What is the very first word of the Bible?", answers: ["God", "In", "The", "Let"], correctIndex: 1, category: "Bible Knowledge"),
    QuizQuestion(question: "Which book of the Bible is a collection of songs and poetry?", answers: ["Proverbs", "Psalms", "Lamentations", "Song of Solomon"], correctIndex: 1, category: "Bible Knowledge"),
    QuizQuestion(question: "How many letters did Paul write to the Corinthians?", answers: ["1", "2", "3", "4"], correctIndex: 1, category: "Bible Knowledge"),
]

// MARK: - Daily Quiz Manager

struct DailyQuizManager {
    static func todayQuestions() -> [QuizQuestion] {
        let calendar = Calendar.current
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let total = allQuizQuestions.count
        var indices: [Int] = []
        var current = (dayOfYear - 1) * 7
        while indices.count < 5 {
            let index = current % total
            if !indices.contains(index) { indices.append(index) }
            current += 13
        }
        return indices.map { allQuizQuestions[$0] }
    }

    static var todayKey: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return "quiz_score_\(formatter.string(from: Date()))"
    }

    static func savedResult() -> QuizResult? {
        guard let data = UserDefaults.standard.data(forKey: todayKey),
              let dict = try? JSONDecoder().decode([String: Int].self, from: data) else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return QuizResult(date: formatter.string(from: Date()), score: dict["score"] ?? 0, total: dict["total"] ?? 5)
    }

    static func saveResult(score: Int, total: Int) {
        let dict = ["score": score, "total": total]
        if let data = try? JSONEncoder().encode(dict) {
            UserDefaults.standard.set(data, forKey: todayKey)
        }
    }
}

// MARK: - Quiz Card

struct DailyQuizCard: View {
    @State private var showQuiz = false
    @State private var savedResult: QuizResult? = DailyQuizManager.savedResult()

    var body: some View {
        Button(action: { showQuiz = true }) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            colors: [Color(hex: "#f5c5be"), Color(hex: "#d4827a")],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        ))
                        .frame(width: 52, height: 52)
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    if let result = savedResult {
                        Text("Quiz Complete! 🌸")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.textDark)
                        Text("You scored \(result.score) out of \(result.total) today")
                            .font(.system(size: 13))
                            .foregroundColor(.textSoft)
                    } else {
                        Text("Quiz of the Day")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.textDark)
                        Text("5 questions · Takes about 2 minutes")
                            .font(.system(size: 13))
                            .foregroundColor(.textSoft)
                    }
                }

                Spacer()

                if savedResult == nil {
                    Text("Start")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Color.roseGold)
                        .cornerRadius(20)
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(Color.green.opacity(0.7))
                }
            }
            .padding(18)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color(hex: "#f0c8c8").opacity(0.25), radius: 10, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showQuiz, onDismiss: {
            savedResult = DailyQuizManager.savedResult()
        }) {
            QuizSheetView()
        }
    }
}

// MARK: - Quiz Sheet

struct QuizSheetView: View {
    @Environment(\.dismiss) private var dismiss
    private let questions = DailyQuizManager.todayQuestions()
    @State private var currentIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showFeedback = false
    @State private var score = 0
    @State private var finished = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#fde8e8"), Color(hex: "#fdf0f0"), Color(hex: "#ebe8f5")],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            if finished { resultScreen } else { questionScreen }
        }
    }

    private var questionScreen: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.textSoft)
                        .padding(10)
                        .background(Color.white.opacity(0.7))
                        .clipShape(Circle())
                }
                Spacer()
                Text("\(currentIndex + 1) of \(questions.count)")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.textSoft)
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 16)

            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4).fill(Color(hex: "#f0e0e0")).frame(height: 5)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient(colors: [Color(hex: "#d4827a"), Color(hex: "#c9847a")], startPoint: .leading, endPoint: .trailing))
                        .frame(width: geo.size.width * CGFloat(currentIndex + 1) / CGFloat(questions.count), height: 5)
                        .animation(.spring(response: 0.4), value: currentIndex)
                }
            }
            .frame(height: 5)
            .padding(.horizontal, 24)
            .padding(.bottom, 32)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    Text(questions[currentIndex].category.uppercased())
                        .font(.system(size: 10, weight: .semibold))
                        .tracking(2)
                        .foregroundColor(.roseGold)

                    Text(questions[currentIndex].question)
                        .font(.custom("Georgia", size: 22))
                        .italic()
                        .foregroundColor(.textDark)
                        .lineSpacing(5)
                        .fixedSize(horizontal: false, vertical: true)

                    VStack(spacing: 12) {
                        ForEach(0..<questions[currentIndex].answers.count, id: \.self) { i in
                            answerButton(index: i)
                        }
                    }

                    if showFeedback {
                        Button(action: advance) {
                            Text(currentIndex == questions.count - 1 ? "See Results" : "Next Question")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .background(LinearGradient(colors: [Color(hex: "#d4827a"), Color(hex: "#c06b6b")], startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(18)
                                .shadow(color: Color.roseGold.opacity(0.3), radius: 8, x: 0, y: 3)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }

    @ViewBuilder
    private func answerButton(index: Int) -> some View {
        let isSelected = selectedAnswer == index
        let isCorrect = index == questions[currentIndex].correctIndex

        let bgColor: Color = {
            if !showFeedback { return isSelected ? Color.roseGold.opacity(0.1) : Color.white }
            if isCorrect { return Color.green.opacity(0.12) }
            if isSelected { return Color.red.opacity(0.1) }
            return Color.white
        }()

        let borderColor: Color = {
            if !showFeedback { return isSelected ? Color.roseGold : Color(hex: "#f0e0e0") }
            if isCorrect { return Color.green.opacity(0.6) }
            if isSelected { return Color.red.opacity(0.5) }
            return Color(hex: "#f0e0e0")
        }()

        Button(action: {
            guard !showFeedback else { return }
            selectedAnswer = index
            if index == questions[currentIndex].correctIndex { score += 1 }
            withAnimation(.spring(response: 0.3)) { showFeedback = true }
        }) {
            HStack(spacing: 14) {
                Text(["A", "B", "C", "D"][index])
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(showFeedback && isCorrect ? .white : (isSelected ? .white : .textSoft))
                    .frame(width: 28, height: 28)
                    .background(showFeedback && isCorrect ? Color.green.opacity(0.8) : (isSelected ? Color.roseGold : Color(hex: "#f5eded")))
                    .clipShape(Circle())

                Text(questions[currentIndex].answers[index])
                    .font(.system(size: 15))
                    .foregroundColor(.textDark)
                    .multilineTextAlignment(.leading)

                Spacer()

                if showFeedback {
                    if isCorrect {
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                    } else if isSelected {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.red.opacity(0.7))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(bgColor)
            .cornerRadius(14)
            .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(borderColor, lineWidth: 1.5))
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(showFeedback)
    }

    private var resultScreen: some View {
        VStack(spacing: 32) {
            Spacer()
            Text(scoreEmoji).font(.system(size: 64))

            VStack(spacing: 12) {
                Text(scoreHeadline)
                    .font(.custom("Georgia", size: 28))
                    .italic()
                    .foregroundColor(.textDark)
                    .multilineTextAlignment(.center)
                Text("You scored \(score) out of \(questions.count)")
                    .font(.system(size: 16))
                    .foregroundColor(.textSoft)
                HStack(spacing: 10) {
                    ForEach(0..<questions.count, id: \.self) { i in
                        Circle()
                            .fill(i < score ? Color.green.opacity(0.7) : Color(hex: "#f0d0cc"))
                            .frame(width: 14, height: 14)
                    }
                }
                .padding(.top, 4)
            }
            .padding(.horizontal, 32)

            Text(scoreVerse)
                .font(.custom("Georgia", size: 15))
                .italic()
                .foregroundColor(Color(hex: "#9a6b6b"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 36)
                .padding(.vertical, 16)
                .background(Color.white.opacity(0.7))
                .cornerRadius(16)
                .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Color(hex: "#f0d0cc"), lineWidth: 1))
                .padding(.horizontal, 28)

            Spacer()

            Button(action: { dismiss() }) {
                Text("Done")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(LinearGradient(colors: [Color(hex: "#d4827a"), Color(hex: "#c06b6b")], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(18)
                    .shadow(color: Color.roseGold.opacity(0.3), radius: 8, x: 0, y: 3)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 28)
            .padding(.bottom, 50)
        }
    }

    private func advance() {
        selectedAnswer = nil
        showFeedback = false
        if currentIndex < questions.count - 1 {
            withAnimation(.spring(response: 0.3)) { currentIndex += 1 }
        } else {
            DailyQuizManager.saveResult(score: score, total: questions.count)
            withAnimation { finished = true }
        }
    }

    private var scoreEmoji: String {
        switch score {
        case 5: return "🌟"
        case 4: return "🌸"
        case 3: return "☀️"
        case 2: return "🌿"
        default: return "💛"
        }
    }

    private var scoreHeadline: String {
        switch score {
        case 5: return "Perfect score! You shine!"
        case 4: return "Almost perfect — well done!"
        case 3: return "Great effort, keep going!"
        case 2: return "Good try, keep learning!"
        default: return "Every step is progress!"
        }
    }

    private var scoreVerse: String {
        switch score {
        case 5: return "\"Well done, good and faithful servant.\" — Matthew 25:21"
        case 4: return "\"She is clothed with strength and dignity.\" — Proverbs 31:25"
        case 3: return "\"I can do all things through Christ who strengthens me.\" — Philippians 4:13"
        case 2: return "\"Trust in the Lord with all your heart.\" — Proverbs 3:5"
        default: return "\"For I know the plans I have for you, declares the Lord.\" — Jeremiah 29:11"
        }
    }
}

#Preview {
    DailyQuizCard()
        .padding()
}
