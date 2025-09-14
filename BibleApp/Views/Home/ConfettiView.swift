import SwiftUI
import UIKit

struct ConfettiView: UIViewRepresentable {
    @Binding var isActive: Bool

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let emitterLayer = CAEmitterLayer()
        context.coordinator.emitterLayer = emitterLayer
        view.layer.addSublayer(emitterLayer)
        
        // Debug
        print("ConfettiView: makeUIView, isActive: \(isActive)")
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        let emitterLayer = context.coordinator.emitterLayer
        uiView.frame = uiView.superview?.bounds ?? UIScreen.main.bounds
        emitterLayer?.frame = uiView.bounds
        emitterLayer?.emitterPosition = CGPoint(x: uiView.bounds.midX, y: 0)
        emitterLayer?.emitterShape = .line
        emitterLayer?.emitterSize = CGSize(width: uiView.bounds.width, height: 1)
        
        // Only configure cells if not already set
        if emitterLayer?.emitterCells == nil {
            let shapes = ["circle", "star"]
            let colors: [UIColor] = [.red, .blue, .green, .yellow, .purple, .white]
            
            let cells = shapes.flatMap { shape in
                colors.map { color in
                    let cell = CAEmitterCell()
                    cell.birthRate = isActive ? 40 : 0 // Increased for visibility
                    cell.lifetime = 5.0
                    cell.velocity = 300
                    cell.velocityRange = 100
                    cell.emissionLongitude = .pi // Downward
                    cell.emissionRange = .pi / 4
                    cell.spin = 3
                    cell.spinRange = 4
                    cell.scale = 0.05
                    cell.scaleRange = 0.02
                    cell.yAcceleration = 200 // Stronger gravity
                    cell.color = color.cgColor
                    
                    let image = UIGraphicsImageRenderer(size: CGSize(width: 10, height: 10)).image { ctx in
                        ctx.cgContext.setFillColor(color.cgColor)
                        if shape == "circle" {
                            ctx.cgContext.fillEllipse(in: CGRect(x: 0, y: 0, width: 10, height: 10))
                        } else {
                            ctx.cgContext.move(to: CGPoint(x: 5, y: 0))
                            ctx.cgContext.addLine(to: CGPoint(x: 7, y: 3))
                            ctx.cgContext.addLine(to: CGPoint(x: 10, y: 5))
                            ctx.cgContext.addLine(to: CGPoint(x: 7, y: 7))
                            ctx.cgContext.addLine(to: CGPoint(x: 5, y: 10))
                            ctx.cgContext.addLine(to: CGPoint(x: 3, y: 7))
                            ctx.cgContext.addLine(to: CGPoint(x: 0, y: 5))
                            ctx.cgContext.addLine(to: CGPoint(x: 3, y: 3))
                            ctx.cgContext.closePath()
                            ctx.cgContext.fillPath()
                        }
                    }
                    cell.contents = image.cgImage
                    return cell
                }
            }
            emitterLayer?.emitterCells = cells
        } else {
            emitterLayer?.birthRate = isActive ? 1 : 0
        }
        
        // Debug
        print("ConfettiView: updateUIView, isActive: \(isActive), bounds: \(uiView.bounds), cells: \(emitterLayer?.emitterCells?.count ?? 0)")
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var emitterLayer: CAEmitterLayer?
    }
}

#Preview {
    ConfettiView(isActive: .constant(true))
}
