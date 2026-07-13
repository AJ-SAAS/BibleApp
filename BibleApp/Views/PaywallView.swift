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

    private let features: [String] = [
        "Full devotional Journey library",
        "Daily verses picked for you",
        "Save your favorite promises",
        "Gentle daily reminders"
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
        .alert("Something went wrong", isPresented: errorBinding) {
            Button("OK", role: .cancel) { viewModel.errorMessage = nil }
        } message: { Text(viewModel.errorMessage ?? "Please try again.") }
    }

    private var errorBinding: Binding<Bool> {
        Binding(get: { viewModel.errorMessage != nil }, set: { if !$0 { viewModel.errorMessage = nil }})
    }

    private func selectDefaultPackageIfNeeded() {
        guard selectedPackage == nil else { return }
        selectedPackage = viewModel.annualPackage ?? viewModel.weeklyPackage
    }

    // MARK: - Background

    private var backgroundGradient: some View {
        LinearGradient(colors: [Color.bfmCream, Color.bfmBlush.opacity(0.6), Color.bfmPeach.opacity(0.4)],
                       startPoint: .top, endPoint: .bottom)
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
        Image("Bibleformomslogo")
            .resizable()
            .scaledToFit()
            .frame(height: 46)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: Color.bfmRoseDeep.opacity(0.18), radius: 6, y: 3)
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
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
    }

    // MARK: - Feature list (checkmarks, like the reference)

    private var featureList: some View {
        VStack(alignment: .leading, spacing: 14) {
            ForEach(features, id: \.self) { feature in
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(Color.bfmRoseDeep).frame(width: 24, height: 24)
                        Image(systemName: "checkmark")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                    }
                    Text(feature)
                        .font(.system(size: 15.5, weight: .medium))
                        .foregroundColor(.bfmBrown)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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

    // MARK: - Continue button

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
            .background(LinearGradient(colors: [Color.bfmRose, Color.bfmRoseDeep], startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(color: Color.bfmRoseDeep.opacity(0.3), radius: 10, y: 5)
        }
        .disabled(selectedPackage == nil || viewModel.isLoading)
        .padding(.top, 4)
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
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(isYearly ? "12-Month Access" : "Weekly Access")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.bfmBrown)

                Spacer()

                if isYearly {
                    Text("Save 81%")
                        .font(.system(size: 12, weight: .bold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.bfmRoseDeep)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }

            Text(isYearly ? "Billed yearly at $49.99" : "$4.99 per week")
                .font(.system(size: 13))
                .foregroundColor(.bfmBrownSoft)

            if isYearly {
                Text("Just $0.96/week — cancel anytime")
                    .font(.system(size: 11.5))
                    .foregroundColor(.bfmBrownSoft.opacity(0.85))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 16).fill(isSelected ? Color.white.opacity(0.85) : Color.white.opacity(0.4)))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(isSelected ? Color.bfmRoseDeep : Color.bfmBrownSoft.opacity(0.2), lineWidth: isSelected ? 2 : 1))
    }
}

// MARK: - Preview
#Preview {
    PaywallView()
}
