//
//  PaywallView.swift
//  Bible for Moms
//
//  Layout inspired by a reference Bible-app paywall: bold headline,
//  checkmarked feature list, two package cards (best value highlighted),
//  single CTA, footer links. No free-trial toggle. Kept in the app's
//  warm/soft color theme rather than the reference's dark theme.
//  Single screen — no scrolling.
//

import SwiftUI
import RevenueCat

// MARK: - Colors
extension Color {
    static let bfmCream       = Color(red: 1.00, green: 0.973, blue: 0.941)
    static let bfmBlush       = Color(red: 0.988, green: 0.894, blue: 0.894)
    static let bfmPeach       = Color(red: 0.984, green: 0.847, blue: 0.769)
    static let bfmRose        = Color(red: 0.910, green: 0.627, blue: 0.627)
    static let bfmRoseDeep    = Color(red: 0.851, green: 0.490, blue: 0.490)
    static let bfmBrown       = Color(red: 0.420, green: 0.310, blue: 0.310)
    static let bfmBrownSoft   = Color(red: 0.549, green: 0.447, blue: 0.408)
    static let bfmGold        = Color(red: 0.878, green: 0.706, blue: 0.471)
}

struct PaywallView: View {
    @StateObject private var viewModel = PurchaseViewModel()
    @State private var selectedPackage: Package?
    @State private var logoAppeared = false
    @State private var logoPulse = false

    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    var onCompletion: ((Bool) -> Void)? = nil

    // Benefit-driven copy instead of feature labels.
    private let features: [String] = [
        "30-day journeys for every season of motherhood",
        "A verse made for exactly how you're feeling today",
        "Never lose the promise that spoke to your heart",
        "A gentle nudge to meet God, even on the hard days"
    ]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundGradient

                VStack(spacing: 0) {
                    topBar

                    Spacer(minLength: 2)

                    logo

                    Spacer(minLength: 10)

                    headline

                    Spacer(minLength: 18)

                    featureList

                    Spacer(minLength: 18)

                    packageSelector

                    Spacer(minLength: 16)

                    continueButton

                    cancelAnytimeText

                    footerLinks
                }
                .padding(.horizontal, 24)
                .frame(height: geo.size.height)
            }
        }
        .onReceive(viewModel.$currentOffering) { _ in selectDefaultPackageIfNeeded() }
        .onChange(of: viewModel.isPremium) { _, isPremium in
            if isPremium {
                onCompletion?(true)
                dismiss()
            }
        }
        .task { selectDefaultPackageIfNeeded() }
        .onAppear {
            // Stronger pre-selection guarantee
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                selectDefaultPackageIfNeeded()
            }
        }
        .alert("Something went wrong", isPresented: errorBinding) {
            Button("OK", role: .cancel) { viewModel.errorMessage = nil }
        } message: { Text(viewModel.errorMessage ?? "Please try again.") }
    }

    private var errorBinding: Binding<Bool> {
        Binding(get: { viewModel.errorMessage != nil }, set: { if !$0 { viewModel.errorMessage = nil }})
    }

    // Prefers annual — made more robust
    private func selectDefaultPackageIfNeeded() {
        guard selectedPackage == nil, let offering = viewModel.currentOffering, !offering.availablePackages.isEmpty else {
            return
        }
        
        if let annual = viewModel.annualPackage {
            selectedPackage = annual
            return
        }
        
        if let annualFallback = offering.availablePackages.first(where: { $0.packageType == .annual }) {
            selectedPackage = annualFallback
            return
        }
        
        if let yearly = offering.availablePackages.first(where: {
            $0.packageType == .annual ||
            $0.identifier.lowercased().contains("annual") ||
            $0.identifier.lowercased().contains("year")
        }) {
            selectedPackage = yearly
            return
        }
        
        selectedPackage = viewModel.weeklyPackage ?? offering.availablePackages.first
    }

    // MARK: - Background (Cooler & Softer Gradient)
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color.bfmCream,
                Color(red: 0.98, green: 0.92, blue: 0.95),   // Soft cool pink
                Color(red: 0.95, green: 0.88, blue: 0.97)    // Light lavender
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    // MARK: - Top bar
    private var topBar: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.bfmBrownSoft)
                    .padding(9)
                    .background(Color.white.opacity(0.6))
                    .clipShape(Circle())
            }
            Spacer()
        }
        .padding(.top, 8)
    }

    // MARK: - Logo
    private var logo: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.bfmRose.opacity(0.35), Color.bfmRoseDeep.opacity(0.45)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 92, height: 92)
                .shadow(color: Color.bfmRoseDeep.opacity(0.25), radius: 10, y: 5)

            Image("Bibleformomslogo")
                .resizable()
                .scaledToFit()
                .frame(height: 74)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .scaleEffect(logoAppeared ? (logoPulse ? 1.04 : 1.0) : 0.7)
        .opacity(logoAppeared ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.55, dampingFraction: 0.65)) {
                logoAppeared = true
            }
            withAnimation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true).delay(0.6)) {
                logoPulse = true
            }
        }
    }

    // MARK: - Headline
    private var headline: some View {
        Text("Never Miss a Moment\nof Faith")
            .font(.system(size: 27, weight: .bold, design: .serif))
            .foregroundColor(.bfmBrown)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .fixedSize(horizontal: false, vertical: true)
    }

    // MARK: - Feature list
    private var featureList: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(features, id: \.self) { feature in
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(Color.bfmRoseDeep).frame(width: 28, height: 28)
                        Image(systemName: "checkmark")
                            .font(.system(size: 13, weight: .heavy))
                            .foregroundColor(.white)
                    }
                    Text(feature)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.bfmBrown)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    // MARK: - Package selector
    private var packageSelector: some View {
        VStack(spacing: 12) {
            if let offering = viewModel.currentOffering {
                ForEach(offering.availablePackages, id: \.identifier) { package in
                    PackageCard(package: package, isSelected: selectedPackage?.identifier == package.identifier)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.15)) {
                                selectedPackage = package
                            }
                        }
                }
            } else if viewModel.isLoading {
                ProgressView().tint(.bfmRoseDeep)
            }
        }
    }

    // MARK: - Continue button (More "Pop")
    private var continueButton: some View {
        Button {
            guard let package = selectedPackage else { return }
            Task { await viewModel.purchase(package) }
        } label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView().tint(.white)
                } else {
                    Text("Continue")
                        .font(.system(size: 17, weight: .bold))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 0.98, green: 0.45, blue: 0.55),  // Vibrant rose
                        Color(red: 0.85, green: 0.25, blue: 0.45)   // Deeper rich rose
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(color: Color(red: 0.85, green: 0.25, blue: 0.45).opacity(0.4), radius: 12, y: 6)
        }
        .disabled(selectedPackage == nil || viewModel.isLoading)
        .padding(.top, 4)
    }

    private var cancelAnytimeText: some View {
        Text("No commitment, Cancel anytime")
            .font(.system(size: 13, weight: .medium))
            .foregroundColor(.bfmBrownSoft)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 8)
    }

    // MARK: - Footer links
    private var footerLinks: some View {
        HStack(spacing: 14) {
            Button { openURL(URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!) } label: {
                Text("Terms of use").font(.system(size: 12)).foregroundColor(.bfmBrownSoft)
            }
            Text("·").foregroundColor(.bfmBrownSoft)
            Button { openURL(URL(string: "https://www.faithformoms.com/r/privacy")!) } label: {
                Text("Privacy policy").font(.system(size: 12)).foregroundColor(.bfmBrownSoft)
            }
            Text("·").foregroundColor(.bfmBrownSoft)
            Button { Task { await viewModel.restorePurchases() } } label: {
                Text(viewModel.isLoading ? "Restoring…" : "Restore")
                    .font(.system(size: 12)).foregroundColor(.bfmBrownSoft)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 12)
        .padding(.bottom, 10)
    }
}

// MARK: - Package Card
private struct PackageCard: View {
    let package: Package
    let isSelected: Bool

    private var isYearly: Bool { package.packageType == .annual }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(isYearly ? "12-Month Access" : "Weekly Access")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.bfmBrown)

                    Text(isYearly ? "Billed yearly at $49.99" : "$4.99 per week")
                        .font(.system(size: 13))
                        .foregroundColor(.bfmBrownSoft)

                    if isYearly {
                        Text("Just $0.96/week — cancel anytime")
                            .font(.system(size: 11.5))
                            .foregroundColor(.bfmBrownSoft.opacity(0.85))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                ZStack {
                    if isSelected {
                        Circle()
                            .fill(Color.bfmRoseDeep)
                            .frame(width: 26, height: 26)
                            .overlay(
                                Image(systemName: "checkmark")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                            )
                    } else {
                        Circle()
                            .stroke(Color.bfmBrownSoft.opacity(0.5), lineWidth: 1.5)
                            .frame(width: 26, height: 26)
                    }
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        isSelected
                        ? AnyShapeStyle(
                            LinearGradient(
                                colors: [Color.bfmBlush.opacity(0.9), Color.bfmPeach.opacity(0.7)],
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            )
                          )
                        : AnyShapeStyle(Color.white.opacity(0.4))
                    )
            )
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(isSelected ? Color.bfmRoseDeep : Color.bfmBrownSoft.opacity(0.2), lineWidth: isSelected ? 2 : 1))

            if isYearly {
                Text("Save 81%")
                    .font(.system(size: 12, weight: .bold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.bfmRoseDeep)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .offset(x: 10, y: -14)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    PaywallView()
}
