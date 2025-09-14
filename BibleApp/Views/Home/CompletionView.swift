import SwiftUI

struct CompletionView: View {
    let onDismiss: () -> Void
    @State private var isConfettiActive: Bool = false
    @State private var isShowingShareSheet: Bool = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Background image
                Image("back2")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // Semi-transparent overlay for readability
                Color.black.opacity(0.3)
                    .ignoresSafeArea()

                // Confetti effect
                ConfettiView(isActive: $isConfettiActive)
                    .ignoresSafeArea()

                VStack(spacing: geo.size.height * 0.04) {
                    // Push content down
                    Spacer()
                        .frame(height: geo.size.height * 0.1)
                    
                    // Congrats Graphic
                    Image(systemName: "hands.sparkles.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.25)
                        .foregroundColor(.white)
                        .shadow(radius: 6)
                    
                    // Title
                    Text("You’re getting closer to Christ!")
                        .font(.system(size: geo.size.width * 0.065, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, geo.size.width * 0.08)
                    
                    // Subtitle
                    Text("You completed all 3 daily tasks:\nPrayed • Read today’s verse • Completed the task")
                        .font(.system(size: geo.size.width * 0.045, weight: .regular, design: .serif))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, geo.size.width * 0.1)
                    
                    Spacer()
                    
                    // Buttons
                    VStack(spacing: geo.size.height * 0.02) {
                        Button(action: {
                            print("CompletionView: Share button tapped")
                            isShowingShareSheet = true
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                            }
                            .font(.system(size: geo.size.width * 0.045, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.vertical, 8) // Increased vertical padding
                            .padding(.horizontal, 8)
                            .frame(maxWidth: geo.size.width * 0.5) // Reduced width
                            .background(Color(hex: "#d8b4fe"))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        }
                        .sheet(isPresented: $isShowingShareSheet) {
                            ShareSheet(items: ["I completed all my daily tasks in BibleApp! 🎉"])
                        }
                        
                        Button(action: {
                            isConfettiActive = false
                            onDismiss()
                        }) {
                            Text("Continue")
                                .font(.system(size: geo.size.width * 0.05, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        .onAppear {
            isConfettiActive = true
            print("CompletionView: onAppear, isConfettiActive set to true")
            // Stop confetti after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isConfettiActive = false
                print("CompletionView: Confetti stopped after 3 seconds")
            }
        }
        .onChange(of: isConfettiActive) { _, newValue in
            print("CompletionView: isConfettiActive changed to \(newValue)")
        }
    }
}

#Preview("iPhone 14 - Completion") {
    CompletionView(onDismiss: { print("Dismissed") })
}

#Preview("iPad Pro - Completion") {
    CompletionView(onDismiss: { print("Dismissed") })
}
