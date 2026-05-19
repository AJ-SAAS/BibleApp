// MARK: - JourneyBrowseView.swift

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
        return journeys.filter {
            $0.category == selectedCategory
        }
    }

    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack(alignment: .leading, spacing: 20) {

                // MARK: Header
                VStack(alignment: .leading, spacing: 6) {
                    Text("Journeys")
                        .font(.largeTitle.bold())

                    Text("Find encouragement for where you are today.")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                // MARK: Categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(categories, id: \.self) { category in
                            Button {
                                selectedCategory = category
                            } label: {
                                Text(category)
                                    .font(.subheadline.weight(.semibold))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(
                                        selectedCategory == category
                                            ? Color(hex: "#2c1f14")
                                            : Color(hex: "#f1ece5")
                                    )
                                    .foregroundColor(
                                        selectedCategory == category
                                            ? .white
                                            : Color(hex: "#2c1f14")
                                    )
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // MARK: Grid
                LazyVGrid(columns: columns, spacing: 12) {
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
        .background(Color(hex: "#faf6f0"))
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        JourneyBrowseView()
    }
}
