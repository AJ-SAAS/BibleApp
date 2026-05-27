import SwiftUI

struct JourneyBrowseView: View {

    let journeys = JourneyService.shared.loadJourneys()

    @State private var selectedCategory: String = "All"

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var categories: [String] {
        let all = journeys.map { $0.category }
        return ["All"] + Array(Set(all)).sorted()
    }

    var filteredJourneys: [Journey] {
        if selectedCategory == "All" {
            return journeys
        }
        return journeys.filter { $0.category == selectedCategory }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {

                // Header
                VStack(alignment: .leading, spacing: 6) {
                    Text("Journeys")
                        .font(.custom("Georgia", size: 34))
                        .italic()
                        .foregroundColor(.textDark)

                    Text("Find encouragement for where you are today.")
                        .font(.system(size: 16))
                        .foregroundColor(.textSoft)
                }
                .padding(.horizontal)

                // Categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(categories, id: \.self) { category in
                            Button {
                                selectedCategory = category
                            } label: {
                                Text(category)
                                    .font(.system(size: 15, weight: .semibold))
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 10)
                                    .background(
                                        selectedCategory == category
                                        ? Color.roseGold
                                        : Color.blushLight
                                    )
                                    .foregroundColor(
                                        selectedCategory == category ? .white : .textDark
                                    )
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Grid
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filteredJourneys) { journey in
                        NavigationLink {
                            JourneyDetailView(journey: journey)
                        } label: {
                            JourneyCardView(journey: journey)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.top)
        }
        .background(Color.blushWhite)
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        JourneyBrowseView()
    }
}
