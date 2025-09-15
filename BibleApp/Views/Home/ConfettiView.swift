import SwiftUI

struct ConfettiView: View {
    @Binding var isActive: Bool
    @State private var particles: [Particle] = []
    
    struct Particle: Identifiable {
        let id = UUID()
        let shape: String
        let color: Color
        var x: CGFloat
        var y: CGFloat
        let velocityX: CGFloat
        let velocityY: CGFloat
        var rotation: Angle
        let rotationSpeed: Double
        let scale: CGFloat
        var opacity: Double
    }
    
    private let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .white]
    private let shapes: [String] = ["circle", "star"]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(particles) { particle in
                    Group {
                        if particle.shape == "circle" {
                            Circle()
                                .fill(particle.color)
                                .frame(width: 10 * particle.scale, height: 10 * particle.scale)
                        } else {
                            StarShape()
                                .fill(particle.color)
                                .frame(width: 10 * particle.scale, height: 10 * particle.scale)
                        }
                    }
                    .rotationEffect(particle.rotation)
                    .opacity(particle.opacity)
                    .position(x: particle.x, y: particle.y)
                }
            }
            .ignoresSafeArea()
            .onChange(of: isActive) { _, newValue in
                if newValue {
                    generateParticles(in: geo.size)
                    print("ConfettiView: isActive set to true, generated \(particles.count) particles")
                } else {
                    particles = []
                    print("ConfettiView: isActive set to false, cleared particles")
                }
            }
            .onAppear {
                if isActive {
                    generateParticles(in: geo.size)
                    print("ConfettiView: onAppear, generated \(particles.count) particles")
                }
            }
        }
    }
    
    private func generateParticles(in size: CGSize) {
        particles = (0..<50).map { _ in
            let particle = Particle(
                shape: shapes.randomElement()!,
                color: colors.randomElement()!,
                x: CGFloat.random(in: 0...size.width),
                y: -10,
                velocityX: CGFloat.random(in: -50...50),
                velocityY: CGFloat.random(in: 100...300),
                rotation: .degrees(CGFloat.random(in: 0...360)),
                rotationSpeed: Double.random(in: -4...4),
                scale: CGFloat.random(in: 0.5...1),
                opacity: Double.random(in: 0.5...1)
            )
            
            // Schedule animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.linear(duration: 3)) {
                    if let index = particles.firstIndex(where: { $0.id == particle.id }) {
                        particles[index].y += particle.velocityY * 3
                        particles[index].x += particle.velocityX * 3
                        particles[index].rotation = .degrees(particle.rotation.degrees + particle.rotationSpeed * 3)
                        particles[index].opacity = max(0, particle.opacity - 0.5)
                    }
                }
            }
            return particle
        }
    }
}

struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius: CGFloat = rect.width / 2
            path.move(to: CGPoint(x: center.x, y: center.y - radius))
            for i in 1...8 {
                let angle = CGFloat(i) * .pi / 4
                let pointRadius = i % 2 == 0 ? radius : radius * 0.5
                let x = center.x + cos(angle) * pointRadius
                let y = center.y + sin(angle) * pointRadius
                path.addLine(to: CGPoint(x: x, y: y))
            }
            path.closeSubpath()
        }
    }
}

#Preview {
    ConfettiView(isActive: .constant(true))
}
