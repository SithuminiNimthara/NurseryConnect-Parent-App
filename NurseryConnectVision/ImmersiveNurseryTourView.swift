import SwiftUI
import RealityKit

struct ImmersiveNurseryTourView: View {
    @Environment(VisionAppModel.self) private var appModel

    var body: some View {
        RealityView { content, attachments in
            
            // 1. Add a semi-transparent floor for spatial grounding
            let floor = ModelEntity(
                mesh: .generateBox(size: [6.0, 0.02, 6.0]),
                materials: [
                    SimpleMaterial(
                        color: .init(white: 1.0, alpha: 0.1),
                        isMetallic: false
                    )
                ]
            )
            floor.position = [0, -1.2, -1.5]
            content.add(floor)

            // 2. Add Nursery Zones with procedural 3D objects
            // Reading Corner (Left)
            addZone(to: content, zone: .reading, position: [-1.4, -0.6, -1.2])
            
            // Play Area (Right)
            addZone(to: content, zone: .play, position: [1.4, -0.6, -1.2])
            
            // Meal Area (Front-Left)
            addZone(to: content, zone: .meal, position: [-1.0, -0.6, -2.2])
            
            // Rest Area (Front-Right)
            addZone(to: content, zone: .rest, position: [1.0, -0.6, -2.2])

            // 3. Setup Attachments (Sub-labels)
            setupAttachments(content: content, attachments: attachments)

            // 4. Setup Central Detail Panel
            if let detailPanel = attachments.entity(for: "detailPanel") {
                detailPanel.position = [0, 0.4, -1.8]
                content.add(detailPanel)
            }

        } update: { content, attachments in
            // Selection Highlighting: Scale up the selected zone object
            for zone in NurseryZone.allCases {
                if let entity = content.entities.first(where: { $0.name == zone.rawValue }) {
                    let isSelected = appModel.selectedZone == zone
                    let targetScale: Float = isSelected ? 1.3 : 1.0
                    entity.scale = [targetScale, targetScale, targetScale]
                }
            }
        } attachments: {
            // Label panels for each zone (Persistent floating labels)
            ForEach(NurseryZone.allCases) { zone in
                Attachment(id: zone.rawValue) {
                    NurseryAreaPanel(zone: zone)
                }
            }
            
            // Central detail panel that updates based on selection
            Attachment(id: "detailPanel") {
                if let selectedZone = appModel.selectedZone {
                    NurseryZoneDetailPanel(zone: selectedZone)
                }
            }
            
            Attachment(id: "titlePanel") {
                VStack(spacing: 16) {
                    Text("NurseryConnect: Real Parent Experience")
                        .font(.system(size: 64, weight: .bold))
                    
                    Text("Select a nursery zone to explore Olivia’s activities, learning progress, and wellbeing updates.")
                        .font(.system(size: 36, weight: .medium))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(width: 900)
                }
                .padding(40)
                .glassBackgroundEffect()
            }
        }
        .gesture(SpatialTapGesture().targetedToAnyEntity().onEnded { event in
            // Handle selecting a zone by tapping its 3D object
            if let zone = NurseryZone(rawValue: event.entity.name) {
                appModel.selectZone(zone)
            }
        })
    }

    private func addZone(to content: RealityViewContent, zone: NurseryZone, position: SIMD3<Float>) {
        let entity = RealityNurseryObjects.generateEntity(for: zone)
        entity.position = position
        content.add(entity)
    }

    private func setupAttachments(content: RealityViewContent, attachments: RealityViewAttachments) {
        // Position labels above the 3D objects
        let zonePositions: [NurseryZone: SIMD3<Float>] = [
            .reading: [-1.4, 0.2, -1.2],
            .play: [1.4, 0.2, -1.2],
            .meal: [-1.0, 0.2, -2.2],
            .rest: [1.0, 0.2, -2.2]
        ]
        
        for (zone, pos) in zonePositions {
            if let label = attachments.entity(for: zone.rawValue) {
                label.position = pos
                content.add(label)
            }
        }
        
        if let title = attachments.entity(for: "titlePanel") {
            title.position = [0, 1.6, -1.8]
            content.add(title)
        }
    }
}
