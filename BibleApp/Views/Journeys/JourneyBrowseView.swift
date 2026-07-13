import SwiftUI

// navigationDestination(item:) requires Journey: Hashable. Manual conformance
// here (rather than relying on auto-synthesis) works regardless of which
// file Journey.swift lives in. If you'd rather, move this into Journey.swift
// directly and delete it from here.
extension Journey: Hashable {
    static func == (lhs: Journey, rhs: Journey) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct JourneyBrowseView: View {

    let journeys = JourneyService.shared.loadJourneys()

    @StateObject private var purchaseViewModel = PurchaseViewModel()

    @State private var selectedCategory: String = "All"
    @State private var selectedJourney: Journey?       // drives navigation
    @State private var journeyPendingUnlock: Journey?   // drives paywall sheet

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
                        Button {
                            handleTap(on: journey)
                        } label: {
                            JourneyCardView(journey: journey)
                                .overlay(alignment: .topTrailing) {
                                    if journey.isPremium && !purchaseViewModel.isPremium {
                                        lockBadge
                                    }
                                }
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
        // Push to the detail screen only once we know the user can access it.
        .navigationDestination(item: $selectedJourney) { journey in
            JourneyDetailView(journey: journey)
        }
        // Locked journeys show the paywall instead of navigating.
        .sheet(item: $journeyPendingUnlock) { journey in
            PaywallView { didSubscribe in
                if didSubscribe {
                    // Send them straight into the journey they tapped.
                    selectedJourney = journey
                }
            }
        }
        .task {
            await purchaseViewModel.refreshPremiumStatus()
        }
    }

    private var lockBadge: some View {
        Image(systemName: "lock.fill")
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(.white)
            .padding(6)
            .background(Color.black.opacity(0.35))
            .clipShape(Circle())
            .padding(8)
    }

    private func handleTap(on journey: Journey) {
        if journey.isPremium && !purchaseViewModel.isPremium {
            journeyPendingUnlock = journey
        } else {
            selectedJourney = journey
        }
    }
}

#Preview {
    NavigationStack {
        JourneyBrowseView()
    }
}
