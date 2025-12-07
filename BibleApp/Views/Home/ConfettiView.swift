import SwiftUI

// MARK: - Duolingo-Style Confetti (Fixed & Production Ready)
struct ConfettiView: View {
    @Binding var isActive: Bool
    
    private let particleCount = 120
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Only create particles when active
                if isActive {
                    ForEach(0..<particleCount, id: \.self) { index in
                        ConfettiParticle(
                            startRect: proxy.frame(in: .global),
                            delay: Double(index) * 0.01,
                            duration: 2.5 + Double.random(in: 0...1.0)
                        )
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

// MARK: - Single Confetti Particle
struct ConfettiParticle: View {
    let startRect: CGRect
    let delay: Double
    let duration: Double
    
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = -100
    @State private var rotation: Angle = .zero
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    
    private let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink, .mint]
    
    var body: some View {
        let color = colors.randomElement()!
        let size = CGFloat.random(in: 9...16)
        let velocity = CGFloat.random(in: 700...1200)
        let angle = Angle(degrees: Double.random(in: -50...50))
        let spin = Double.random(in: -500...500)
        
        // Random shape
        Group {
            if Bool.random() {
                Circle()
            } else if Bool.random() {
                StarShape()
            } else if Bool.random() {
                Rectangle()
            } else {
                TriangleShape()
            }
        }
        .foregroundColor(color)
        .frame(width: size, height: size)
        .scaleEffect(scale)
        .rotationEffect(rotation)
        .opacity(opacity)
        .offset(x: startRect.midX + offsetX - UIScreen.main.bounds.width / 2,
                y: offsetY)
        .onAppear {
            withAnimation(
                .linear(duration: duration)
                .delay(delay)
            ) {
                offsetX = cos(angle.radians) * velocity * 0.6
                offsetY = sin(angle.radians) * velocity + 900
                rotation = .degrees(spin)
                scale = 0.2
                opacity = 0
            }
        }
    }
}

// MARK: - Shapes
struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        let numberOfPoints = 5
        let angle = CGFloat.pi / CGFloat(numberOfPoints)
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.width / 2
        
        for i in 0..<(numberOfPoints * 2) {
            let currentRadius = i % 2 == 0 ? radius : radius * 0.4
            let currentAngle = CGFloat(i) * angle - .pi / 2
            let point = CGPoint(
                x: center.x + cos(currentAngle) * currentRadius,
                y: center.y + sin(currentAngle) * currentRadius
            )
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}

struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

// MARK: - How to Use
// Example usage in your home screen:
struct HomeViewExample: View {
    @State private var showConfetti = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack {
                Text("Daily Task Complete!")
                    .font(.largeTitle)
                    .bold()
                
                Button("Celebrate!") {
                    withAnimation {
                        showConfetti = true
                    }
                    // Auto-hide after 3.5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        showConfetti = false
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            
            if showConfetti {
                ConfettiView(isActive: $showConfetti)
                    .allowsHitTesting(false) // Don't block taps underneath
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HomeViewExample()
}
