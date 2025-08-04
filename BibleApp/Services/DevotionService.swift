import SwiftUI

struct DevotionView: View {
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                    VStack(spacing: geometry.size.width > 600 ? 24 : 20) {
                        Text("Daily Devotion")
                            .font(.system(.largeTitle, design: .default, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
                            .padding(.top, geometry.size.width > 600 ? 40 : 24)

                        Text("Verse of the Day")
                            .font(.system(.title2, design: .default, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)

                        Text("Proverbs 3:5-6\nTrust in the Lord with all your heart...")
                            .font(.system(.body, design: .default, weight: .regular))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)

                        Text("Task")
                            .font(.system(.title2, design: .default, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)

                        Text("Write down 3 areas where you're struggling to trust God.")
                            .font(.system(.body, design: .default, weight: .regular))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, geometry.size.width > 600 ? 64 : 32)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, geometry.size.width > 600 ? 40 : 24)
                }
                .background(Color.white.ignoresSafeArea())
            }
        }
    }
}

struct DevotionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DevotionView()
                .previewDevice("iPhone 14")
                .previewDisplayName("iPhone 14")
            DevotionView()
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
                .previewDisplayName("iPad Pro")
        }
    }
}
