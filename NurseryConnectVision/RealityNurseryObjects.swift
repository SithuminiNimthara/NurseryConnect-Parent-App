import RealityKit
import UIKit

enum RealityNurseryObjects {
    
    /// Generates a representative 3D entity for a nursery zone
    static func generateEntity(for zone: NurseryZone) -> Entity {
        let container = Entity()
        container.name = zone.rawValue
        
        switch zone {
        case .reading:
            // Shelf-like structure with "books"
            let shelf = createBox(size: [0.8, 0.4, 0.2], color: .init(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0))
            container.addChild(shelf)
            
            // Add some vibrant books
            let colors: [UIColor] = [.systemRed, .systemBlue, .systemGreen, .systemYellow, .systemPurple]
            for i in 0..<5 {
                let book = createBox(size: [0.04, 0.3, 0.18], color: colors[i])
                book.position = [-0.3 + Float(i) * 0.15, 0.3, 0]
                container.addChild(book)
            }
            
        case .play:
            // Toy blocks and balls
            let block1 = createBox(size: [0.3, 0.3, 0.3], color: .systemOrange)
            block1.position = [-0.2, 0, 0]
            container.addChild(block1)
            
            let block2 = createBox(size: [0.25, 0.25, 0.25], color: .systemCyan)
            block2.position = [0.1, 0.27, 0]
            block2.orientation = .init(angle: .pi/6, axis: [0, 1, 0])
            container.addChild(block2)
            
            let ball1 = createSphere(radius: 0.15, color: .systemPink)
            ball1.position = [0.3, -0.1, 0.2]
            container.addChild(ball1)

            let ball2 = createSphere(radius: 0.12, color: .systemYellow)
            ball2.position = [0.4, -0.12, -0.1]
            container.addChild(ball2)
            
        case .meal:
            // Table and plate
            let tableTop = createBox(size: [0.8, 0.04, 0.8], color: .white)
            tableTop.position = [0, 0, 0]
            container.addChild(tableTop)
            
            // Table legs
            let legPositions: [SIMD3<Float>] = [[-0.35, -0.3, -0.35], [0.35, -0.3, -0.35], [-0.35, -0.3, 0.35], [0.35, -0.3, 0.35]]
            for pos in legPositions {
                let leg = createBox(size: [0.05, 0.6, 0.05], color: .lightGray)
                leg.position = pos
                container.addChild(leg)
            }
            
            let plate = createSphere(radius: 0.15, color: .systemBlue)
            plate.scale = [1, 0.1, 1]
            plate.position = [0, 0.04, 0]
            container.addChild(plate)
            
        case .rest:
            // Mat and pillow
            let mat = createBox(size: [1.0, 0.05, 1.5], color: .systemBlue.withAlphaComponent(0.4))
            container.addChild(mat)
            
            let pillow = createBox(size: [0.5, 0.1, 0.3], color: .white)
            pillow.position = [0, 0.05, -0.5]
            container.addChild(pillow)
        }
        
        // Add a collision shape for tap interaction
        let collisionShape = ShapeResource.generateBox(size: [1.2, 1.0, 1.5])
        container.components.set(CollisionComponent(shapes: [collisionShape]))
        container.components.set(InputTargetComponent())
        
        return container
    }
    
    private static func createBox(size: SIMD3<Float>, color: UIColor) -> ModelEntity {
        let mesh = MeshResource.generateBox(size: size, cornerRadius: 0.04) // Increased corner radius
        // Soften the color for a nursery theme
        let pastelColor = color.withAlphaComponent(0.85)
        let material = SimpleMaterial(color: pastelColor, isMetallic: false)
        return ModelEntity(mesh: mesh, materials: [material])
    }
    
    private static func createSphere(radius: Float, color: UIColor) -> ModelEntity {
        let mesh = MeshResource.generateSphere(radius: radius)
        let pastelColor = color.withAlphaComponent(0.85)
        let material = SimpleMaterial(color: pastelColor, isMetallic: false)
        return ModelEntity(mesh: mesh, materials: [material])
    }
}
