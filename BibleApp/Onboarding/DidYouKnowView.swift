import SwiftUI

struct DidYouKnowView: View {
    var fact: DidYouKnowFact
    var onComplete: () -> Void

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                Image(fact.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(20)
                    .shadow(radius: 6)
                
                Text("Did You Know?")
                    .font(.system(size: 28, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                
                Text(fact.text)
                    .font(.system(size: 18, weight: .regular, design: .serif))
                    .foregroundColor(.black.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                Spacer()
            }
            .padding()
        }
        .transition(.opacity)
    }
}
