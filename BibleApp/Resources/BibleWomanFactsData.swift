import Foundation

struct BibleWomanFact: Identifiable {
    let id = UUID()
    let title: String
    let fact: String
    let reference: String
}

struct BibleWomanFactsData {
    static let facts: [BibleWomanFact] = [
        BibleWomanFact(
            title: "Did you know?",
            fact: "Deborah was both a prophetess and a judge — leading an entire nation with wisdom and courage.",
            reference: "Judges 4–5"
        ),
        BibleWomanFact(
            title: "Did you know?",
            fact: "Mary was chosen to carry Jesus not because of status, but because of her faith and obedience.",
            reference: "Luke 1:38"
        ),
        BibleWomanFact(
            title: "Did you know?",
            fact: "Esther saved an entire nation through bravery, patience, and perfect timing.",
            reference: "Esther 4:14"
        ),
        BibleWomanFact(
            title: "Did you know?",
            fact: "The first people to witness the resurrection of Jesus were women.",
            reference: "Matthew 28:1–10"
        )
    ]
}
