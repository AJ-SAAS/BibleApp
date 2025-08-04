import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                    VStack(spacing: geometry.size.width > 600 ? 24 : 20) {
                        Text("Welcome to Closer to Christ")
                            .font(.system(.largeTitle, design: .default, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
                            .padding(.top, geometry.size.width > 600 ? 40 : 24)

                        Text("Start your daily devotion to grow closer to Christ.")
                            .font(.system(.body, design: .default, weight: .regular))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)

                        NavigationLink(destination: DevotionView()) {
                            Text("Today’s Devotion")
                                .font(.system(.headline, design: .default, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: min(geometry.size.width * 0.8, 400))
                                .padding()
                                .background(.blue)
                                .cornerRadius(8)
                                .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
                                .accessibilityLabel("Go to Today’s Devotion")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, geometry.size.width > 600 ? 40 : 24)
                }
                .background(Color.white.ignoresSafeArea())
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .previewDevice("iPhone 14")
                .previewDisplayName("iPhone 14")
            HomeView()
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
                .previewDisplayName("iPad Pro")
        }
    }
}
